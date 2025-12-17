import 'package:talker_flutter/talker_flutter.dart';
import 'package:talker_bloc_logger/talker_bloc_logger.dart';
import 'package:flutter/foundation.dart';

late final Talker talker;

void initTalker() {
  talker = TalkerFlutter.init(
    settings: TalkerSettings(
      enabled: true,
      useConsoleLogs: kDebugMode,
      useHistory: true,
      maxHistoryItems: 1000,
    ),
    logger: TalkerLogger(
      settings: TalkerLoggerSettings(
        enableColors: true,
        level: kDebugMode ? LogLevel.verbose : LogLevel.error,
      ),
    ),
  );

  talker.info('Talker logging system initialized');
}

TalkerBlocObserver createBlocObserver() {
  return TalkerBlocObserver(
    talker: talker,
    settings: const TalkerBlocLoggerSettings(
      enabled: true,
      printEventFullData: true,
      printStateFullData: true,
      printChanges: true,
      printClosings: false,
      printCreations: false,
      printEvents: true,
      printTransitions: true,
    ),
  );
}
