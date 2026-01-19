import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/features/stories/domain/entities/story.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/services/profile_storage_service.dart';
import 'package:myitihas/services/follow_service.dart';
import 'package:myitihas/core/di/injection_container.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../models/user_model.dart';

/// Implementation of UserRepository
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource dataSource;
  final ProfileStorageService storageService;
  final FollowService followService;

  UserRepositoryImpl({
    required this.dataSource,
    required this.storageService,
    required this.followService,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Get authenticated user ID from Supabase Auth
      final authUser = SupabaseService.authService.getCurrentUser();
      if (authUser == null) {
        return Left(AuthFailure('Not authenticated', 'NOT_AUTH'));
      }

      // Fetch from profiles table - canonical source for profile data
      final userModel = await dataSource.getUserById(authUser.id);
      return Right(userModel.copyWith(isCurrentUser: true).toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setCurrentUser(String userId) async {
    try {
      // Verify user exists in profiles table
      await dataSource.getUserById(userId);
      // Note: Current user is managed by Supabase Auth, not manually set
      return const Right(null);
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUserProfile(String userId) async {
    try {
      final currentUserResult = await getCurrentUser();
      String? currentUserId;
      currentUserResult.fold((l) => null, (user) => currentUserId = user.id);

      // Fetch from profiles table - canonical source for profile data
      final userModel = await dataSource.getUserById(userId);

      // Fetch real follower/following counts
      final followersCount = await followService.getFollowersCount(userId);
      final followingCount = await followService.getFollowingCount(userId);

      // Check if current user is following this user
      bool isFollowing = false;
      if (currentUserId != null && currentUserId != userId) {
        isFollowing = await followService.isFollowing(userId);
      }

      return Right(
        userModel
            .copyWith(
              isCurrentUser: currentUserId == userId,
              followerCount: followersCount,
              followingCount: followingCount,
              isFollowing: isFollowing,
            )
            .toEntity(),
      );
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> searchUsers(String query) async {
    try {
      // Search in profiles table - canonical source for profile data
      final users = await dataSource.searchUsers(query);
      return Right(users.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> followUser(String userId) async {
    try {
      await followService.followUser(userId);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, e.code));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unfollowUser(String userId) async {
    try {
      await followService.unfollowUser(userId);
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(e.message, e.code));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFollowers(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // Fetch followers with profile data from FollowService
      final followers = await followService.getFollowers(userId);

      // Convert to User entities
      final users = followers.map((profile) {
        return UserModel(
          id: profile['id'] as String,
          username: profile['username'] as String? ?? '',
          displayName: profile['full_name'] as String? ?? 'Unknown',
          avatarUrl: profile['avatar_url'] as String? ?? '',
          bio: '', // Bio not included in follower list query
          followerCount: 0,
          followingCount: 0,
          isFollowing: false,
          isCurrentUser: false,
        ).toEntity();
      }).toList();

      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getFollowing(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      // Fetch following with profile data from FollowService
      final following = await followService.getFollowing(userId);

      // Convert to User entities
      final users = following.map((profile) {
        return UserModel(
          id: profile['id'] as String,
          username: profile['username'] as String? ?? '',
          displayName: profile['full_name'] as String? ?? 'Unknown',
          avatarUrl: profile['avatar_url'] as String? ?? '',
          bio: '', // Bio not included in following list query
          followerCount: 0,
          followingCount: 0,
          isFollowing: false,
          isCurrentUser: false,
        ).toEntity();
      }).toList();

      return Right(users);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
      // Fetch from profiles table - canonical source for profile data
      final users = await dataSource.getAllUsers();
      return Right(users.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserProfile({
    required String userId,
    String? displayName,
    String? bio,
    String? avatarUrl,
  }) async {
    try {
      // Update profiles table ONLY - canonical source for profile data
      // Do NOT update users table anymore
      await dataSource.updateUser(
        userId: userId,
        displayName: displayName,
        bio: bio,
        avatarUrl: avatarUrl,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePhoto({
    required String userId,
    required File imageFile,
  }) async {
    final logger = getIt<Talker>();
    logger.info(
      '🗂️ [Repository] Starting uploadProfilePhoto for user: $userId',
    );

    try {
      // Upload image to Supabase Storage and get public URL
      logger.info('📤 [Repository] Calling storage service...');
      final String publicUrl = await storageService.uploadProfilePhoto(
        userId: userId,
        imageFile: imageFile,
      );
      logger.info('✅ [Repository] Storage upload successful. URL: $publicUrl');

      // Update user's avatar_url in profiles table - canonical source for profile data
      logger.info('💾 [Repository] Updating profile record in database...');
      await dataSource.updateUser(userId: userId, avatarUrl: publicUrl);
      logger.info('✅ [Repository] Database updated successfully');

      return Right(publicUrl);
    } on ServerException catch (e) {
      logger.error('❌ [Repository] ServerException: ${e.message}', e);
      return Left(ServerFailure(e.message));
    } catch (e) {
      logger.error('❌ [Repository] Unexpected error', e);
      return Left(UnexpectedFailure(e.toString()));
    }
  }
  
  @override
  Future<Either<Failure, List<Story>>> getSavedStories() async {
    try {
      final user = SupabaseService.client.auth.currentUser;

      if (user == null) {
        return Left(AuthFailure('Not authenticated', 'NOT_AUTH'));
      }

      final userModel = await dataSource.getUserById(user.id);
      List<Story> savedStories = [];
      for (final storyId in userModel.savedStories) {
        final storyResult = await dataSource.getStoryById(storyId);
        storyResult.fold(
          (failure) {
            // Log and skip if story not found
            final logger = getIt<Talker>();
            logger.warning(
              'Saved story $storyId not found for user: ${failure.message}',
            );
          },
          (story) {
            savedStories.add(story);
          },
        );
      }
      return Right(savedStories);
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

}