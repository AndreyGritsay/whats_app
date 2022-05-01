import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whats_app/registration/data_provider/data_provider.dart';

part 'check_event.dart';

part 'check_state.dart';

class CheckBloc extends Bloc<CheckEvent, CheckState> {
  CheckBloc() : super(CheckInitial()) {
    on<ToGetTheCode>(_toGetTheCode);
    on<ResendCode>(_resendCode);
  }

  final dataProvider = DataProvider();

  void _toGetTheCode(ToGetTheCode event, Emitter<CheckState> emit) async {
    String exception = await dataProvider.toGetTheCode(
      event.sendCode,
      event.phoneNumber,
    );
    if (exception == '') {
      emit(CheckInitial());
    } else {
      emit(Error(exception));
    }
  }

  void _resendCode(ResendCode event, Emitter<CheckState> emit) async {
    emit(InProgress());
    await dataProvider.resendCode(event.smsCode);
    emit(TheCodeIsCorrect());
  }
}
