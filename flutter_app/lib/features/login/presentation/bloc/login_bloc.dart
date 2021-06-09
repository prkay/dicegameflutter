import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/firebase_repositroy.dart';
import 'package:flutter_app/features/login/model/login_request_model.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  @override
  LoginState get initialState => EmptyState(false);
  final FireBaseRepository fireBaseRepository;
  LoginBloc({@required this.fireBaseRepository,});

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginPageReadyEvent) {
      yield LoginPageReadyState(true,false);
    }else if(event is LoginUserStart){
      yield* authenticateUser(event.loginRequest);
    }
  }

  Stream<LoginState> authenticateUser(LoginRequest loginRequest) async* {
    yield UserLoginStartState(true);
      try{
        var message = await fireBaseRepository.authenticateUser(userModel: loginRequest);
        yield UserLoginSuccessState(false,message);
      }catch(e){
        UserLoginFailedState(false,StringKeys.somethingWentWrong);
      }
  }
}