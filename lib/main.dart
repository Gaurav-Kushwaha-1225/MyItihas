import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/config/routes.dart';
import 'package:myitihas/services/supabase_service.dart';
import 'package:myitihas/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Supabase
  // TODO: Replace with your actual Supabase project URL and anon key
  await SupabaseService.initialize(
    url: 'https://xmbygaeixvzlyhbtkbnp.supabase.co', // e.g., 'https://your-project.supabase.co'
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InhtYnlnYWVpeHZ6bHloYnRrYm5wIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjE1NDAzODAsImV4cCI6MjA3NzExNjM4MH0.dqcdiUaixiuFoy5YJ0tmN34M7IBSp8JmiEhYuLKUCKI', // Your Supabase anon/public key
  );
  
  final SharedPreferences storage = await SharedPreferences.getInstance();
  final GoRouter router = MyItihasRouter().router;
  runApp(
    BlocProvider<ThemeBloc>(
      create: (context) => ThemeBloc(storage: storage)..loadSavedTheme(),
      child: MyItihas(router: router),
    ),
  );
}

class MyItihas extends StatelessWidget {
  final GoRouter router;

  const MyItihas({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return BlocBuilder<ThemeBloc, ThemeState>(
          builder: (context, state) {
            return MaterialApp.router(
              title: 'MyItihas',
              themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
              theme: MyItihasTheme.lightTheme,
              darkTheme: MyItihasTheme.darkTheme,
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
