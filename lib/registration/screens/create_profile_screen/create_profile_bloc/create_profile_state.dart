part of 'create_profile_bloc.dart';

@immutable
abstract class CreateProfileState {}

class CreateProfileInitial extends CreateProfileState {}
class NextPage extends CreateProfileState {}
class Error extends CreateProfileState {
  Error(this.errorText);
  final String errorText;
}
class InProgress extends CreateProfileState {}

