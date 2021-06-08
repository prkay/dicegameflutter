import 'package:equatable/equatable.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationPageReadyEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}