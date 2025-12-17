import 'dart:math';
import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import 'package:myitihas/core/errors/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_data_source.dart';

/// Implementation of UserRepository
@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDataSource dataSource;
  final SharedPreferences sharedPreferences;

  static const String _currentUserIdKey = 'current_user_id';

  UserRepositoryImpl({
    required this.dataSource,
    required this.sharedPreferences,
  });

  @override
  Future<Either<Failure, User>> getCurrentUser() async {
    try {
      String? currentUserId = sharedPreferences.getString(_currentUserIdKey);

      if (currentUserId == null) {
        // First time - randomly select a user
        final allUsers = await dataSource.getAllUsers();
        final random = Random();
        final selectedUser = allUsers[random.nextInt(allUsers.length)];
        currentUserId = selectedUser.id;
        await sharedPreferences.setString(_currentUserIdKey, currentUserId);
      }

      final userModel = await dataSource.getUserById(currentUserId);
      return Right(userModel.copyWith(isCurrentUser: true).toEntity());
    } on NotFoundException catch (e) {
      return Left(NotFoundFailure(e.message, e.code));
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message, e.code));
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setCurrentUser(String userId) async {
    try {
      await dataSource.getUserById(userId);
      await sharedPreferences.setString(_currentUserIdKey, userId);
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

      bool isFollowing = false;
      if (currentUserId != null && currentUserId != userId) {
        final following = await dataSource.getFollowing(currentUserId!);
        isFollowing = following.any((u) => u.id == userId);
      }

      final followers = await dataSource.getFollowers(userId);
      final following = await dataSource.getFollowing(userId);

      return Right(
        userModel
            .copyWith(
              isFollowing: isFollowing,
              isCurrentUser: currentUserId == userId,
              followerCount: followers.length,
              followingCount: following.length,
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
    try {
      final currentUserResult = await getCurrentUser();
      return currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.followUser(currentUser.id, userId);
        return const Right(null);
      });
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> unfollowUser(String userId) async {
    try {
      final currentUserResult = await getCurrentUser();
      return currentUserResult.fold((failure) => Left(failure), (
        currentUser,
      ) async {
        await dataSource.unfollowUser(currentUser.id, userId);
        return const Right(null);
      });
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
      final followers = await dataSource.getFollowers(userId);
      final paginated = followers.skip(offset).take(limit).toList();
      return Right(paginated.map((model) => model.toEntity()).toList());
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
      final following = await dataSource.getFollowing(userId);
      final paginated = following.skip(offset).take(limit).toList();
      return Right(paginated.map((model) => model.toEntity()).toList());
    } catch (e) {
      return Left(UnexpectedFailure(e.toString()));
    }
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
}
