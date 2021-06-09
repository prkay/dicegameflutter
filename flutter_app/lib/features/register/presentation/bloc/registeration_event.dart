import 'package:equatable/equatable.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';

abstract class RegistrationEvent extends Equatable {
  const RegistrationEvent();
}

class RegistrationPageReadyEvent extends RegistrationEvent {
  @override
  List<Object> get props => [];
}

class RegistrationStart extends RegistrationEvent {
  final UserModel userModel;

  RegistrationStart(this.userModel);
  @override
  List<Object> get props => [userModel];
}