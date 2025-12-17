import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/hive_registrar.g.dart';

Future<void> initHive() async {
  await Hive.initFlutter();

  Hive.registerAdapters();

  talker.info(
    'Hive CE initialized with ${Hive.isAdapterRegistered(0) ? "adapters registered" : "NO adapters"}',
  );
}

@lazySingleton
class HiveService {
  Future<Box<T>> openBox<T>(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  }

  Future<void> closeBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).close();
    }
  }

  Future<void> deleteBox(String boxName) async {
    if (Hive.isBoxOpen(boxName)) {
      await Hive.box(boxName).deleteFromDisk();
    } else {
      await Hive.deleteBoxFromDisk(boxName);
    }
  }

  Future<void> clearBox(String boxName) async {
    final box = await openBox(boxName);
    await box.clear();
  }
}

class HiveBoxNames {
  static const String stories = 'stories_box';
  static const String userPreferences = 'user_preferences_box';
  static const String chatHistory = 'chat_history_box';
  static const String generatedStories = 'generated_stories_box';

  static const String users = 'users_box';
  static const String conversations = 'conversations_box';
  static const String messages = 'messages_box';
  static const String comments = 'comments_box';
  static const String likes = 'likes_box';
  static const String shares = 'shares_box';
  static const String notifications = 'notifications_box';
}
