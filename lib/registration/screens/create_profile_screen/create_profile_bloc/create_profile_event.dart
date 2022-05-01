part of 'create_profile_bloc.dart';

@immutable
abstract class CreateProfileEvent {}

class ProfileNameEntered extends CreateProfileEvent {
  ProfileNameEntered(this.profileName);

  final String profileName;
}
