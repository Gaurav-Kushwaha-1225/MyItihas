import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/di/injection_container.dart';
import '../models/user_model.dart';

/// Remote data source for user data using Supabase
abstract class UserRemoteDataSource {
  Future<UserModel> getUserById(String userId);
  Future<List<UserModel>> getAllUsers();
  Future<List<UserModel>> searchUsers(String query);
  Future<void> updateUser({
    required String userId,
    String? displayName,
    String? bio,
    String? avatarUrl,
  });
}

/// Implementation of user remote data source with Supabase
@LazySingleton(as: UserRemoteDataSource)
class UserRemoteDataSourceSupabase implements UserRemoteDataSource {
  final SupabaseClient _supabase;

  UserRemoteDataSourceSupabase(this._supabase);

  @override
  Future<UserModel> getUserById(String userId) async {
    final logger = getIt<Talker>();
    logger.info('🔍 [DataSource] Fetching user by ID: $userId');
    
    try {
      final response = await _supabase
          .from('users')
          .select('id, username, full_name, avatar_url, bio')
          .eq('id', userId)
          .single();

      logger.debug('📦 [DataSource] Raw response: $response');
      logger.info('🖼️ [DataSource] avatar_url from DB: ${response['avatar_url']}');

      final userModel = UserModel(
        id: response['id'] as String,
        username: response['username'] as String,
        displayName: response['full_name'] as String,
        avatarUrl: response['avatar_url'] as String? ?? '',
        bio: response['bio'] as String? ?? '',
        followerCount: 0,
        followingCount: 0,
        isFollowing: false,
        isCurrentUser: false,
      );
      
      logger.info('✅ [DataSource] UserModel avatarUrl: ${userModel.avatarUrl}');
      return userModel;
    } catch (e) {
      logger.error('❌ [DataSource] Error fetching user: $e');
      if (e.toString().contains('406') || e.toString().contains('not found')) {
        throw NotFoundException(
          'User not found',
          'USER_NOT_FOUND',
        );
      }
      throw ServerException(
        'Failed to fetch user: ${e.toString()}',
        'FETCH_USER_ERROR',
      );
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await _supabase
          .from('users')
          .select('id, username, full_name, avatar_url, bio')
          .order('created_at', ascending: false);

      return (response as List).map((user) {
        return UserModel(
          id: user['id'] as String,
          username: user['username'] as String,
          displayName: user['full_name'] as String,
          avatarUrl: user['avatar_url'] as String? ?? '',
          bio: user['bio'] as String? ?? '',
          followerCount: 0,
          followingCount: 0,
          isFollowing: false,
          isCurrentUser: false,
        );
      }).toList();
    } catch (e) {
      throw ServerException(
        'Failed to fetch users: ${e.toString()}',
        'FETCH_USERS_ERROR',
      );
    }
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      final response = await _supabase
          .from('users')
          .select('id, username, full_name, avatar_url, bio')
          .or('username.ilike.%$query%,full_name.ilike.%$query%')
          .limit(20);

      return (response as List).map((user) {
        return UserModel(
          id: user['id'] as String,
          username: user['username'] as String,
          displayName: user['full_name'] as String,
          avatarUrl: user['avatar_url'] as String? ?? '',
          bio: user['bio'] as String? ?? '',
          followerCount: 0,
          followingCount: 0,
          isFollowing: false,
          isCurrentUser: false,
        );
      }).toList();
    } catch (e) {
      throw ServerException(
        'Failed to search users: ${e.toString()}',
        'SEARCH_USERS_ERROR',
      );
    }
  }

  @override
  Future<void> updateUser({
    required String userId,
    String? displayName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      final updates = <String, dynamic>{};
      
      if (displayName != null) {
        updates['full_name'] = displayName;
      }
      if (bio != null) {
        updates['bio'] = bio;
      }
      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }

      if (updates.isEmpty) {
        return; // Nothing to update
      }

      updates['updated_at'] = DateTime.now().toIso8601String();

      await _supabase
          .from('users')
          .update(updates)
          .eq('id', userId);
    } catch (e) {
      throw ServerException(
        'Failed to update user: ${e.toString()}',
        'UPDATE_USER_ERROR',
      );
    }
  }
}
