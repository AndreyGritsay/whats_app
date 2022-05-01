part of 'check_bloc.dart';

@immutable
abstract class CheckState {}

class CheckInitial extends CheckState {}

class Error extends CheckState {
  final String textError;

  Error(this.textError);
}

class InProgress extends CheckState {}

class TheCodeIsCorrect extends CheckState {}
