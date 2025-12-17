import 'package:injectable/injectable.dart';
import 'package:myitihas/core/errors/exceptions.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUserById(String userId);
  Future<List<UserModel>> searchUsers(String query);
  Future<void> cacheUsers(List<UserModel> users);
  Future<UserModel?> getCachedUser(String userId);
  Future<void> followUser(String currentUserId, String targetUserId);
  Future<void> unfollowUser(String currentUserId, String targetUserId);
  Future<List<UserModel>> getFollowers(String userId);
  Future<List<UserModel>> getFollowing(String userId);
}

/// Implementation of user data source with mock data
@LazySingleton(as: UserDataSource)
class UserDataSourceImpl implements UserDataSource {
  // Hardcoded mythological characters as users
  static final List<UserModel> _mockUsers = [
    UserModel(
      id: 'user_001',
      username: 'sage_vyasa',
      displayName: 'Sage Vyasa',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=vyasa',
      bio:
          'Compiler of Vedas and author of Mahabharata. Spreading ancient wisdom through stories.',
      followerCount: 15420,
      followingCount: 8,
    ),
    UserModel(
      id: 'user_002',
      username: 'narada_muni',
      displayName: 'Narada Muni',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=narada',
      bio:
          'Traveling sage and devotee of Lord Krishna. Spreading bhakti across the universe.',
      followerCount: 12890,
      followingCount: 12,
    ),
    UserModel(
      id: 'user_003',
      username: 'draupadi',
      displayName: 'Draupadi',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=draupadi',
      bio:
          'Queen of Hastinapura. Embodiment of dharma, courage, and forgiveness.',
      followerCount: 18750,
      followingCount: 15,
    ),
    UserModel(
      id: 'user_004',
      username: 'arjuna',
      displayName: 'Arjuna',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=arjuna',
      bio: 'Greatest archer and warrior. Student of Lord Krishna.',
      followerCount: 21340,
      followingCount: 10,
    ),
    UserModel(
      id: 'user_005',
      username: 'kunti_devi',
      displayName: 'Kunti Devi',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=kunti',
      bio: 'Mother of the Pandavas. Devoted to Lord Krishna and dharma.',
      followerCount: 14560,
      followingCount: 7,
    ),
    UserModel(
      id: 'user_006',
      username: 'bhima',
      displayName: 'Bhima',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=bhima',
      bio: 'Strongest of the Pandavas. Lover of food and justice.',
      followerCount: 16780,
      followingCount: 9,
    ),
    UserModel(
      id: 'user_007',
      username: 'uttara',
      displayName: 'Uttara',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=uttara',
      bio: 'Wife of Abhimanyu. Mother of Emperor Parikshit.',
      followerCount: 11230,
      followingCount: 11,
    ),
    UserModel(
      id: 'user_008',
      username: 'yudhishthira',
      displayName: 'Yudhishthira',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=yudhishthira',
      bio: 'Emperor of Hastinapura. Always truthful and righteous.',
      followerCount: 19870,
      followingCount: 6,
    ),
    UserModel(
      id: 'user_009',
      username: 'sukadeva_gosvami',
      displayName: 'Sukadeva Gosvami',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=sukadeva',
      bio: 'Son of Vyasa. Narrator of Srimad Bhagavatam to King Parikshit.',
      followerCount: 13450,
      followingCount: 5,
    ),
    UserModel(
      id: 'user_010',
      username: 'parikshit',
      displayName: 'King Parikshit',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=parikshit',
      bio: 'Emperor who saw Lord Krishna in the womb. Listener of Bhagavatam.',
      followerCount: 12670,
      followingCount: 8,
    ),
    UserModel(
      id: 'user_011',
      username: 'nakula',
      displayName: 'Nakula',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=nakula',
      bio: 'Twin of Sahadeva. Expert in horse-keeping and swordsmanship.',
      followerCount: 10890,
      followingCount: 7,
    ),
    UserModel(
      id: 'user_012',
      username: 'sahadeva',
      displayName: 'Sahadeva',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=sahadeva',
      bio: 'Twin of Nakula. Astrologer and wise counselor.',
      followerCount: 10560,
      followingCount: 6,
    ),
    UserModel(
      id: 'user_013',
      username: 'dronacharya',
      displayName: 'Dronacharya',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=drona',
      bio: 'Master teacher of the Pandavas and Kauravas. Military expert.',
      followerCount: 17890,
      followingCount: 4,
    ),
    UserModel(
      id: 'user_014',
      username: 'kripa',
      displayName: 'Kripacharya',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=kripa',
      bio: 'Royal teacher and brahmana. Expert in vedic rituals.',
      followerCount: 9870,
      followingCount: 5,
    ),
    UserModel(
      id: 'user_015',
      username: 'upabarhana',
      displayName: 'Upabarhana',
      avatarUrl: 'https://api.dicebear.com/7.x/avataaars/svg?seed=upabarhana',
      bio: 'Former Gandharva. Learned humility through service.',
      followerCount: 7560,
      followingCount: 9,
    ),
  ];

  // In-memory storage for follows
  final Map<String, Set<String>> _following =
      {}; // userId -> set of followed user IDs
  final Map<String, Set<String>> _followers =
      {}; // userId -> set of follower user IDs

  @override
  Future<List<UserModel>> getAllUsers() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_mockUsers);
  }

  @override
  Future<UserModel> getUserById(String userId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _mockUsers.firstWhere((user) => user.id == userId);
    } catch (e) {
      throw const NotFoundException('User not found');
    }
  }

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final lowerQuery = query.toLowerCase();
    return _mockUsers.where((user) {
      return user.username.toLowerCase().contains(lowerQuery) ||
          user.displayName.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<void> cacheUsers(List<UserModel> users) async {
    // In mock implementation, we don't persist to Hive yet
    await Future.delayed(const Duration(milliseconds: 100));
  }

  @override
  Future<UserModel?> getCachedUser(String userId) async {
    await Future.delayed(const Duration(milliseconds: 100));
    try {
      return _mockUsers.firstWhere((user) => user.id == userId);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> followUser(String currentUserId, String targetUserId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _following.putIfAbsent(currentUserId, () => {}).add(targetUserId);
    _followers.putIfAbsent(targetUserId, () => {}).add(currentUserId);
  }

  @override
  Future<void> unfollowUser(String currentUserId, String targetUserId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _following[currentUserId]?.remove(targetUserId);
    _followers[targetUserId]?.remove(currentUserId);
  }

  @override
  Future<List<UserModel>> getFollowers(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final followerIds = _followers[userId] ?? {};
    return _mockUsers.where((user) => followerIds.contains(user.id)).toList();
  }

  @override
  Future<List<UserModel>> getFollowing(String userId) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final followingIds = _following[userId] ?? {};
    return _mockUsers.where((user) => followingIds.contains(user.id)).toList();
  }
}
