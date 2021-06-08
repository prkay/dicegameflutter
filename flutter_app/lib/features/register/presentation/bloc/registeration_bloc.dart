import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, Registrationstate> {
  @override
  Registrationstate get initialState => EmptyState(false);
  RegistrationBloc();

  @override
  Stream<Registrationstate> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationPageReadyEvent) {
      yield* fetchRandomData();
    }
  }

  Stream<Registrationstate> fetchRandomData() async* {
    yield RegistrationPageReadyState(true,false);
  }
}