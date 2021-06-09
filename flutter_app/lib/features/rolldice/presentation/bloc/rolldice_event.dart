import 'package:equatable/equatable.dart';
import 'package:flutter_app/features/login/model/login_request_model.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';

abstract class RollDiceEvent extends Equatable {
  const RollDiceEvent();
}

class RollDicePageReadyEvent extends RollDiceEvent {
  @override
  List<Object> get props => [];
}

class UpdateNewRecordEvent extends RollDiceEvent {
  final UserModel userModel;

  UpdateNewRecordEvent(this.userModel);
  @override
  List<Object> get props => [userModel];
}

class LoginUserDataStart extends RollDiceEvent {
  final LoginRequest loginRequest;

  LoginUserDataStart(this.loginRequest);
  @override
  List<Object> get props => [loginRequest];
}