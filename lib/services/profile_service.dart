import 'package:injectable/injectable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/errors/exceptions.dart';

/// Service for managing user profile data in the profiles table.
/// 
/// IMPORTANT: The profiles table is the canonical source of truth for all profile data.
/// The users table remains for private/internal data only and is NOT queried or updated here.
/// 
/// Profile fields managed:
/// - username
/// - full_name
/// - avatar_url
/// - bio
/// - is_private
@lazySingleton
class ProfileService {
  final SupabaseClient _supabase;

  ProfileService(this._supabase);

  /// Fetches the current authenticated user's profile from the profiles table.
  /// 
  /// Uses auth.uid() to identify the logged-in user.
  /// Returns null if the profile row doesn't exist yet (graceful handling).
  /// 
  /// Data source: profiles table (NOT users table)
  Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    final logger = getIt<Talker>();
    
    try {
      // Get authenticated user ID
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        logger.warning('⚠️ [ProfileService] No authenticated user found');
        return null;
      }

      logger.info('🔍 [ProfileService] Fetching profile for user: $userId');

      // Query profiles table using auth.uid()
      // profiles table is the canonical source for profile data
      final response = await _supabase
          .from('profiles')
          .select('id, username, full_name, avatar_url, bio, is_private')
          .eq('id', userId)
          .maybeSingle(); // Returns null if no row found instead of throwing

      if (response == null) {
        logger.warning('⚠️ [ProfileService] Profile not found for user: $userId');
        return null; // Gracefully handle missing profile
      }

      logger.info('✅ [ProfileService] Profile fetched successfully');
      logger.debug('📦 [ProfileService] Profile data: $response');
      
      return response;
    } catch (e) {
      logger.error('❌ [ProfileService] Error fetching profile: $e');
      throw ServerException(
        'Failed to fetch user profile: ${e.toString()}',
        'FETCH_PROFILE_ERROR',
      );
    }
  }

  /// Fetches any user's profile by their user ID from the profiles table.
  /// 
  /// Data source: profiles table (NOT users table)
  /// Throws NotFoundException if profile doesn't exist.
  Future<Map<String, dynamic>> getProfileById(String userId) async {
    final logger = getIt<Talker>();
    logger.info('🔍 [ProfileService] Fetching profile for user: $userId');
    
    try {
      // Query profiles table - canonical source for profile data
      final response = await _supabase
          .from('profiles')
          .select('id, username, full_name, avatar_url, bio, is_private')
          .eq('id', userId)
          .single(); // Throws if not found

      logger.info('✅ [ProfileService] Profile fetched successfully');
      logger.debug('📦 [ProfileService] Profile data: $response');
      
      return response;
    } catch (e) {
      logger.error('❌ [ProfileService] Error fetching profile: $e');
      if (e.toString().contains('406') || e.toString().contains('not found')) {
        throw NotFoundException(
          'Profile not found',
          'PROFILE_NOT_FOUND',
        );
      }
      throw ServerException(
        'Failed to fetch profile: ${e.toString()}',
        'FETCH_PROFILE_ERROR',
      );
    }
  }

  /// Updates the current authenticated user's profile in the profiles table.
  /// 
  /// Only updates provided (non-null) fields.
  /// Uses auth.uid() to ensure users can only update their own profile.
  /// 
  /// Data destination: profiles table ONLY (users table is NOT updated)
  Future<void> updateCurrentUserProfile({
    String? username,
    String? fullName,
    String? avatarUrl,
    String? bio,
    bool? isPrivate,
  }) async {
    final logger = getIt<Talker>();
    
    try {
      // Get authenticated user ID
      final userId = _supabase.auth.currentUser?.id;
      if (userId == null) {
        logger.error('❌ [ProfileService] No authenticated user found');
        throw Exception('Not authenticated');
      }

      logger.info('📝 [ProfileService] Updating profile for user: $userId');

      // Build update map with only provided fields
      final updates = <String, dynamic>{};
      
      if (username != null) {
        updates['username'] = username;
      }
      if (fullName != null) {
        updates['full_name'] = fullName;
      }
      if (bio != null) {
        updates['bio'] = bio;
      }
      if (avatarUrl != null) {
        updates['avatar_url'] = avatarUrl;
      }
      if (isPrivate != null) {
        updates['is_private'] = isPrivate;
      }

      if (updates.isEmpty) {
        logger.info('ℹ️ [ProfileService] No fields to update');
        return; // Nothing to update
      }

      updates['updated_at'] = DateTime.now().toIso8601String();

      logger.debug('📦 [ProfileService] Update payload: $updates');

      // Update profiles table ONLY - canonical source for profile data
      // Do NOT update users table anymore
      await _supabase
          .from('profiles')
          .update(updates)
          .eq('id', userId);

      logger.info('✅ [ProfileService] Profile updated successfully');
    } catch (e) {
      logger.error('❌ [ProfileService] Error updating profile: $e');
      throw ServerException(
        'Failed to update profile: ${e.toString()}',
        'UPDATE_PROFILE_ERROR',
      );
    }
  }

  /// Fetches public user profiles from the profiles table with pagination.
  /// 
  /// Excludes the current authenticated user.
  /// Returns a list of profiles with basic information.
  /// 
  /// Parameters:
  /// - limit: Maximum number of profiles to fetch
  /// - offset: Number of profiles to skip (for pagination)
  /// 
  /// Data source: profiles table (NOT users table)
  Future<List<Map<String, dynamic>>> fetchPublicProfiles({
    required int limit,
    required int offset,
  }) async {
    final logger = getIt<Talker>();
    logger.info('🔍 [ProfileService] Fetching public profiles (limit: $limit, offset: $offset)');
    
    try {
      // Get authenticated user ID to exclude from results
      final userId = _supabase.auth.currentUser?.id;
      
      // Query profiles table - canonical source for profile data
      final query = _supabase
          .from('profiles')
          .select('id, username, full_name, avatar_url')
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      final response = await query;
      
      // Filter out current user if authenticated
      List<Map<String, dynamic>> profiles = List<Map<String, dynamic>>.from(response);
      if (userId != null) {
        profiles = profiles.where((profile) => profile['id'] != userId).toList();
      }

      logger.info('✅ [ProfileService] Fetched ${profiles.length} public profiles');
      
      return profiles;
    } catch (e) {
      logger.error('❌ [ProfileService] Error fetching public profiles: $e');
      throw ServerException(
        'Failed to fetch public profiles: ${e.toString()}',
        'FETCH_PUBLIC_PROFILES_ERROR',
      );
    }
  }

  /// Searches for profiles by username or full name in the profiles table.
  /// 
  /// Data source: profiles table (NOT users table)
  Future<List<Map<String, dynamic>>> searchProfiles(String query) async {
    final logger = getIt<Talker>();
    logger.info('🔍 [ProfileService] Searching profiles with query: $query');
    
    try {
      // Query profiles table - canonical source for profile data
      final response = await _supabase
          .from('profiles')
          .select('id, username, full_name, avatar_url, bio, is_private')
          .or('username.ilike.%$query%,full_name.ilike.%$query%')
          .limit(20);

      logger.info('✅ [ProfileService] Found ${(response as List).length} profiles');
      
      return List<Map<String, dynamic>>.from(response);
    } catch (e) {
      logger.error('❌ [ProfileService] Error searching profiles: $e');
      throw ServerException(
        'Failed to search profiles: ${e.toString()}',
        'SEARCH_PROFILES_ERROR',
      );
    }
  }
}
