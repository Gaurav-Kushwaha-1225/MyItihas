import 'package:fpdart/fpdart.dart';
import 'package:myitihas/core/errors/failures.dart';
import '../entities/user.dart';

/// Repository interface for user profile and social operations
abstract class UserRepository {
  Future<Either<Failure, User>> getCurrentUser();

  Future<Either<Failure, void>> setCurrentUser(String userId);

  Future<Either<Failure, User>> getUserProfile(String userId);

  Future<Either<Failure, List<User>>> searchUsers(String query);

  Future<Either<Failure, void>> followUser(String userId);

  Future<Either<Failure, void>> unfollowUser(String userId);

  Future<Either<Failure, List<User>>> getFollowers(
    String userId, {
    int limit = 20,
    int offset = 0,
  });

  Future<Either<Failure, List<User>>> getFollowing(
    String userId, {
    int limit = 20,
    int offset = 0,
  });

  Future<Either<Failure, List<User>>> getAllUsers();
}
