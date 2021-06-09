import 'package:equatable/equatable.dart';

abstract class Registrationstate extends Equatable {
  const Registrationstate();
}

class EmptyState extends Registrationstate {
  final isLoading;

  EmptyState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class RegistrationPageReadyState extends Registrationstate {
  final bool landingDone;
  final isLoading;

  RegistrationPageReadyState(this.landingDone,this.isLoading);

  @override
  List<Object> get props => [landingDone,isLoading];
}

class UserRegistrationStartState extends Registrationstate {
  final isLoading;

  UserRegistrationStartState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class UserRegistrationSuccessState extends Registrationstate {
  final isLoading;
  final message;

  UserRegistrationSuccessState(this.isLoading,this.message);

  @override
  List<Object> get props => [isLoading,message];
}

class UserRegistrationFailedState extends Registrationstate {
  final isLoading;
  final String errorMessageKey;

  UserRegistrationFailedState(this.isLoading,this.errorMessageKey);

  @override
  List<Object> get props => [isLoading,errorMessageKey];
}