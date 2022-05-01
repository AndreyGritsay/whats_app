import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whats_app/registration/screens/input_phone_screen/list_country.dart';

part 'input_phone_event.dart';

part 'input_phone_state.dart';

class InputPhoneBloc extends Bloc<InputPhoneEvent, InputPhoneState> {
  InputPhoneBloc()
      : super(const InputPhoneInitial(ListCountry.countryDefault)) {
    on<PhoneIntroduced>(_phoneIntroduced);
    on<CountrySelected>(_countrySelected);
    on<ResetPhoneNumber>(_resetPhoneNumber);
  }

  Country country = ListCountry.countryDefault;

  void _phoneIntroduced(PhoneIntroduced event, Emitter<InputPhoneState> emit) {
    emit(ConfirmPhone(phoneNumber: event.phoneNumber, newCountry: country));
  }

  void _countrySelected(CountrySelected event, Emitter<InputPhoneState> emit) {
    country = event.country;
    emit(InputPhoneInitial(event.country));
  }
  void _resetPhoneNumber(ResetPhoneNumber event, Emitter<InputPhoneState> emit) {
    emit(InputPhoneInitial(country));
  }

  @override
  void onChange(Change<InputPhoneState> change) {
    super.onChange(change);
    print(change);
  }

  @override
  void onTransition(Transition<InputPhoneEvent, InputPhoneState> transition) {
    super.onTransition(transition);
    print(transition);
  }
}
