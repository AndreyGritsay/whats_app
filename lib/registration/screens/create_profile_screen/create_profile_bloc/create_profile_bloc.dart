import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:whats_app/registration/data_provider/data_provider.dart';

part 'create_profile_event.dart';

part 'create_profile_state.dart';

class CreateProfileBloc extends Bloc<CreateProfileEvent, CreateProfileState> {
  CreateProfileBloc() : super(CreateProfileInitial()) {
    on<ProfileNameEntered>(_profileNameEntered);
  }
  final  dataProvider = DataProvider();


  void _profileNameEntered(
      ProfileNameEntered event, Emitter<CreateProfileState> emit) async {
    if (event.profileName != '') {
      emit(InProgress());
      await dataProvider.updateDisplayName(event.profileName);
      await dataProvider.profileCreated();
      emit(NextPage());
    } else {
      emit(Error('Введите корректное имя'));
    }
  }
}
