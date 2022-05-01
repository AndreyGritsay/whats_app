part of 'main_screen_bloc.dart';

abstract class MainScreenEvent {
  const MainScreenEvent();
}

class RegistrationChecked extends MainScreenEvent {}
class UserDeleted extends MainScreenEvent {}
