import 'package:equatable/equatable.dart';
import 'package:flutter_app/features/login/model/login_request_model.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginPageReadyEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}

class LoginUserStart extends LoginEvent {
  final LoginRequest loginRequest;

  LoginUserStart(this.loginRequest);
  @override
  List<Object> get props => [loginRequest];
}