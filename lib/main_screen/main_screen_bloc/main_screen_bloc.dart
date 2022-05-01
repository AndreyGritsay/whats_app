import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:whats_app/registration/data_provider/data_provider.dart';
import 'package:whats_app/security_storage/security_storage.dart';

part 'main_screen_event.dart';

part 'main_screen_state.dart';

class MainBloc extends Bloc<MainScreenEvent, MainScreenState> {
  MainBloc(this.dataProvider) : super(Progress()) {
    on<RegistrationChecked>(_registrationChecked);
    on<UserDeleted>(_userDeleted);
  }

  final DataProvider dataProvider;

  Future<void> _registrationChecked(
      RegistrationChecked event, Emitter<MainScreenState> emit) async {
    emit(Progress());
    String? tokenId = await SecurityStorage().getTokenId();
    if (tokenId != null) {
      final userName = await dataProvider.userName();
      emit(UserRegistration(userName!));
    } else {
      emit(UserNotRegistration());
    }
  }

  Future<void> _userDeleted(
      UserDeleted event, Emitter<MainScreenState> emit) async {
    SecurityStorage().setTokenId(null);
    emit(UserNotRegistration());
  }
}
