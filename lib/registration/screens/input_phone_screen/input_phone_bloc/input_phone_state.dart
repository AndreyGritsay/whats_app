part of 'input_phone_bloc.dart';

@immutable
abstract class InputPhoneState {
  final Country country;

  const InputPhoneState(this.country);
}

class InputPhoneInitial extends InputPhoneState {
  final Country newCountry;

  const InputPhoneInitial(this.newCountry) : super(newCountry);
}

class ConfirmPhone extends InputPhoneState {
  final String phoneNumber;
  final Country newCountry;

  const ConfirmPhone({
    required this.phoneNumber,
    required this.newCountry,
  }) : super(newCountry);
}
