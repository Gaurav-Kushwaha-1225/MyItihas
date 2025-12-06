import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:myitihas/config/routes.dart';
import 'package:myitihas/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return MaterialApp.router(
          title: 'UhlLink',
          themeMode: state.isDark ? ThemeMode.dark : ThemeMode.light,
          theme: MyItihasTheme.lightTheme,
          darkTheme: MyItihasTheme.darkTheme,
          routerConfig: router,
        );
      },
    );
  }
}
