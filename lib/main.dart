import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:myitihas/config/routes.dart';
import 'package:myitihas/config/theme/app_theme.dart';
import 'package:myitihas/core/di/injection_container.dart';
import 'package:myitihas/core/logging/talker_setup.dart';
import 'package:myitihas/core/storage/hive_service.dart';
import 'package:myitihas/i18n/strings.g.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/utils/theme.dart';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // -------- Infra (main branch) --------
  initTalker();
  talker.info('Starting MyItihas app...');

  Bloc.observer = createBlocObserver();

  await initHive();
  await configureDependencies();
  talker.info('Dependencies configured');

  LocaleSettings.useDeviceLocale();

  // -------- Auth (your branch) --------
  await SupabaseService.initialize(
    url: 'https://xmbygaeixvzlyhbtkbnp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhtYnlnYWVpeHZ6bHloYnRrYm5wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE1NDAzODAsImV4cCI6MjA3NzExNjM4MH0.dqcdiUaixiuFoy5YJ0tmN34M7IBSp8JmiEhYuLKUCKI',
  );

  // Deep links / reset-password / OAuth
  SupabaseService.authService.startDeepLinkListener();

  final SharedPreferences storage = await SharedPreferences.getInstance();
  final GoRouter router = MyItihasRouter().router;

  runApp(
    TranslationProvider(
      child: BlocProvider<ThemeBloc>(
        create: (context) => ThemeBloc(storage: storage)..loadSavedTheme(),
        child: MyItihas(router: router),
      ),
    ),
  );
}

class MyItihas extends StatelessWidget {
  final GoRouter router;

  const MyItihas({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'MyItihas',
              debugShowCheckedModeBanner: false,

              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,

              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,

              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
