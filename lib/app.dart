import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:whats_app/main_screen/main_screen_bloc/main_screen_bloc.dart';
import 'package:whats_app/registration/data_provider/data_provider.dart';
import 'package:whats_app/registration/screens/check_screen/check_bloc/check_bloc.dart';
import 'package:whats_app/registration/screens/create_profile_screen/create_profile_bloc/create_profile_bloc.dart';
import 'package:whats_app/registration/screens/input_phone_screen/input_phone_bloc/input_phone_bloc.dart';

import 'package:whats_app/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    final dataProvider = DataProvider();
    return MultiBlocProvider(
      providers: [
        BlocProvider<InputPhoneBloc>(create: (context) => InputPhoneBloc()),
        BlocProvider<CheckBloc>(create: (context) => CheckBloc()),
        BlocProvider<CreateProfileBloc>(
          create: (context) => CreateProfileBloc(),
        ),
        BlocProvider<MainBloc>(
          ///именуй так что он делает
          ///  final перед конструктором остальные переменные после
          create: (context) =>
              MainBloc(dataProvider)..add(RegistrationChecked()),
        ),
      ],
      child: MaterialApp.router(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData(
          /// вынести тему в отдельный файл
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Colors.teal,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          textTheme: TextTheme(
            subtitle1: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
            subtitle2: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 16,
              fontWeight: FontWeight.w900,
            ),
            headline5: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          textSelectionTheme: const TextSelectionThemeData(
            cursorColor: Colors.teal,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              primary: Colors.teal,
              onPrimary: Colors.white,
              textStyle: const TextStyle(fontSize: 15),
              padding: const EdgeInsets.symmetric(
                horizontal: 50,
                vertical: 15,
              ), // foreground (text) color
            ),
          ),
        ),
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
