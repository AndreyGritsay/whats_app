part of 'main_screen_bloc.dart';

abstract class MainScreenState {}

class Progress extends MainScreenState {}

class UserRegistration extends MainScreenState {
  UserRegistration(this.userName);

  final String userName;
}

class UserNotRegistration extends MainScreenState {}

class CheckRegistrationUser extends MainScreenState {}
