part of 'input_phone_bloc.dart';

@immutable
abstract class InputPhoneEvent {}

class PhoneIntroduced extends InputPhoneEvent {
  final String phoneNumber;

  PhoneIntroduced(this.phoneNumber);
}

class CountrySelected extends InputPhoneEvent {
  final Country country;

  CountrySelected(this.country);
}

class ResetPhoneNumber extends InputPhoneEvent {}
