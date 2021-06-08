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