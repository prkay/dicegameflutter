import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => EmptyState(false);
  LoginBloc();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPageReadyEvent) {
      yield* fetchRandomData();
    }
  }

  Stream<LoginState> fetchRandomData() async* {
    yield LoginPageReadyState(true,false);
  }
}