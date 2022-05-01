// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i7;

import '../main_screen/main_screen.dart' as _i1;
import '../registration/screens/check_screen/check_screen.dart' as _i3;
import '../registration/screens/create_profile_screen/create_profile_screen.dart'
    as _i5;
import '../registration/screens/hello_screen/hello_screen.dart' as _i4;
import '../registration/screens/input_phone_screen/input_phone_screen.dart'
    as _i2;

class AppRouter extends _i6.RootStackRouter {
  AppRouter([_i7.GlobalKey<_i7.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    MainScreen.name: (routeData) {
      return _i6.MaterialPageX<_i1.MainScreen>(
          routeData: routeData, child: const _i1.MainScreen());
    },
    InputPhoneScreen.name: (routeData) {
      return _i6.MaterialPageX<_i2.InputPhoneScreen>(
          routeData: routeData, child: const _i2.InputPhoneScreen());
    },
    CheckScreen.name: (routeData) {
      final args = routeData.argsAs<CheckScreenArgs>();
      return _i6.MaterialPageX<_i3.CheckScreen>(
          routeData: routeData,
          child: _i3.CheckScreen(key: args.key, phoneNumber: args.phoneNumber));
    },
    HelloScreen.name: (routeData) {
      return _i6.MaterialPageX<_i4.HelloScreen>(
          routeData: routeData, child: const _i4.HelloScreen());
    },
    CreateProfileScreen.name: (routeData) {
      return _i6.MaterialPageX<_i5.CreateProfileScreen>(
          routeData: routeData, child: const _i5.CreateProfileScreen());
    }
  };

  @override
  List<_i6.RouteConfig> get routes => [
        _i6.RouteConfig(MainScreen.name, path: '/'),
        _i6.RouteConfig(InputPhoneScreen.name, path: '/input-phone-screen'),
        _i6.RouteConfig(CheckScreen.name, path: '/check-screen'),
        _i6.RouteConfig(HelloScreen.name, path: '/hello-screen'),
        _i6.RouteConfig(CreateProfileScreen.name,
            path: '/create-profile-screen')
      ];
}

/// generated route for
/// [_i1.MainScreen]
class MainScreen extends _i6.PageRouteInfo<void> {
  const MainScreen() : super(MainScreen.name, path: '/');

  static const String name = 'MainScreen';
}

/// generated route for
/// [_i2.InputPhoneScreen]
class InputPhoneScreen extends _i6.PageRouteInfo<void> {
  const InputPhoneScreen()
      : super(InputPhoneScreen.name, path: '/input-phone-screen');

  static const String name = 'InputPhoneScreen';
}

/// generated route for
/// [_i3.CheckScreen]
class CheckScreen extends _i6.PageRouteInfo<CheckScreenArgs> {
  CheckScreen({_i7.Key? key, required String phoneNumber})
      : super(CheckScreen.name,
            path: '/check-screen',
            args: CheckScreenArgs(key: key, phoneNumber: phoneNumber));

  static const String name = 'CheckScreen';
}

class CheckScreenArgs {
  const CheckScreenArgs({this.key, required this.phoneNumber});

  final _i7.Key? key;

  final String phoneNumber;

  @override
  String toString() {
    return 'CheckScreenArgs{key: $key, phoneNumber: $phoneNumber}';
  }
}

/// generated route for
/// [_i4.HelloScreen]
class HelloScreen extends _i6.PageRouteInfo<void> {
  const HelloScreen() : super(HelloScreen.name, path: '/hello-screen');

  static const String name = 'HelloScreen';
}

/// generated route for
/// [_i5.CreateProfileScreen]
class CreateProfileScreen extends _i6.PageRouteInfo<void> {
  const CreateProfileScreen()
      : super(CreateProfileScreen.name, path: '/create-profile-screen');

  static const String name = 'CreateProfileScreen';
}
