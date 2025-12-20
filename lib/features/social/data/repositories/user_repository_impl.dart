import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/errors/failures.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/services/profile_storage_service.dart';
import 'package:myitihas/core/di/injection_container.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

/// Implementation of UserRepository
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource dataSource;
  final ProfileStorageService storageService;

  UserRepositoryImpl({
    required this.dataSource,
    required this.storageService,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      // Get authenticated user ID from Supabase Auth
      final authUser = SupabaseService.authService.getCurrentUser();
      if (authUser == null) {
        return Left(AuthFailure('Not authenticated', 'NOT_AUTH'));
      }

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
      // Verify user exists
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

      final userModel = await dataSource.getUserById(userId);

      return Right(
        userModel
            .copyWith(
              isCurrentUser: currentUserId == userId,
              followerCount: 0, // TODO: Implement when follows table is ready
              followingCount: 0,
              isFollowing: false,
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
      final users = await dataSource.searchUsers(query);
      return Right(users.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> followUser(String userId) async {
    // TODO: Implement when follows table is created
    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> unfollowUser(String userId) async {
    // TODO: Implement when follows table is created
    return const Right(null);
  }

  @override
  Future<Either<Failure, List<User>>> getFollowers(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    // TODO: Implement when follows table is created
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<User>>> getFollowing(
    String userId, {
    int limit = 20,
    int offset = 0,
  }) async {
    // TODO: Implement when follows table is created
    return const Right([]);
  }

  @override
  Future<Either<Failure, List<User>>> getAllUsers() async {
    try {
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
    logger.info('🗂️ [Repository] Starting uploadProfilePhoto for user: $userId');
    
    try {
      // Upload image to Supabase Storage and get public URL
      logger.info('📤 [Repository] Calling storage service...');
      final String publicUrl = await storageService.uploadProfilePhoto(
        userId: userId,
        imageFile: imageFile,
      );
      logger.info('✅ [Repository] Storage upload successful. URL: $publicUrl');

      // Update user's avatar_url in database
      logger.info('💾 [Repository] Updating user record in database...');
      await dataSource.updateUser(
        userId: userId,
        avatarUrl: publicUrl,
      );
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
}
