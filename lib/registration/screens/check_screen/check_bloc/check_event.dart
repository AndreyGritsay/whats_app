part of 'check_bloc.dart';

enum SendCode { phone, sms }

@immutable
abstract class CheckEvent {}

class ToGetTheCode extends CheckEvent {
  final SendCode sendCode;
  final String phoneNumber;

  ToGetTheCode({required this.sendCode, required this.phoneNumber});
}

class ResendCode extends CheckEvent {
  final String smsCode;

  ResendCode(this.smsCode);
}
