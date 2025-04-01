import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterboilerplateblocpattern/database/sqflite_database_service.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/router/route_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/resources/theme/theme_manager.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/login/event.dart'
    as login;

import 'package:flutterboilerplateblocpattern/presentation/screens/register/event.dart'
    as register;

import 'package:flutterboilerplateblocpattern/presentation/screens/register/bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/splash/bloc.dart';
import 'package:flutterboilerplateblocpattern/presentation/screens/splash/event.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper.instance.database;
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LoginBloc()..add(login.InitEvent())),
        BlocProvider(create: (_) => SplashBloc()..add(SplashInitEvent())),
        BlocProvider(create: (_) => RegisterBloc()..add(register.InitEvent()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.getRoute,
        initialRoute: Routes.splashPage,
        theme: getApplicationTheme(),
      ),
    );
  }
}
