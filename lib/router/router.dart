import 'package:auto_route/auto_route.dart';

import '../main_screen/main_screen.dart';
import '../registration/screens/check_screen/check_screen.dart';
import '../registration/screens/create_profile_screen/create_profile_screen.dart';
import '../registration/screens/hello_screen/hello_screen.dart';
import '../registration/screens/input_phone_screen/input_phone_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute<HelloScreen>(page: HelloScreen),
    AutoRoute<InputPhoneScreen>(page: InputPhoneScreen),
    AutoRoute<CheckScreen>(page: CheckScreen),
    AutoRoute<CreateProfileScreen>(page: CreateProfileScreen),
    AutoRoute<MainScreen>(page: MainScreen, initial: true),
  ],
)
class $AppRouter {}
