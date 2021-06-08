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