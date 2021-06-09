import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  const LoginState();
}

class EmptyState extends LoginState {
  final isLoading;

  EmptyState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class LoginPageReadyState extends LoginState {
  final bool landingDone;
  final isLoading;

  LoginPageReadyState(this.landingDone,this.isLoading);

  @override
  List<Object> get props => [landingDone,isLoading];
}

class UserLoginStartState extends LoginState {
  final isLoading;

  UserLoginStartState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class UserLoginSuccessState extends LoginState {
  final isLoading;
  final message;

  UserLoginSuccessState(this.isLoading,this.message);

  @override
  List<Object> get props => [isLoading,message];
}

class UserLoginFailedState extends LoginState {
  final isLoading;
  final String errorMessageKey;

  UserLoginFailedState(this.isLoading,this.errorMessageKey);

  @override
  List<Object> get props => [isLoading,errorMessageKey];
}