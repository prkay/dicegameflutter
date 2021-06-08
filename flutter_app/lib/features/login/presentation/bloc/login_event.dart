import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginPageReadyEvent extends LoginEvent {
  @override
  List<Object> get props => [];
}