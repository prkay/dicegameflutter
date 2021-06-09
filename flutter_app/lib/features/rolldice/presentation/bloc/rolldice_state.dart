import 'package:equatable/equatable.dart';

abstract class RollDiceState extends Equatable {
  const RollDiceState();
}

class EmptyState extends RollDiceState {
  final isLoading;

  EmptyState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class RollDicePageReadyState extends RollDiceState {
  final bool landingDone;
  final isLoading;

  RollDicePageReadyState(this.landingDone,this.isLoading);

  @override
  List<Object> get props => [landingDone,isLoading];
}

class UpdateNewRecordStartState extends RollDiceState {
  final isLoading;

  UpdateNewRecordStartState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class UpdateNewRecordSuccessState extends RollDiceState {
  final isLoading;
  final message;

  UpdateNewRecordSuccessState(this.isLoading,this.message);

  @override
  List<Object> get props => [isLoading,message];
}

class UpdateNewRecordFailedState extends RollDiceState {
  final isLoading;
  final String errorMessageKey;

  UpdateNewRecordFailedState(this.isLoading,this.errorMessageKey);

  @override
  List<Object> get props => [isLoading,errorMessageKey];
}

class UserLoginStartState extends RollDiceState {
  final isLoading;

  UserLoginStartState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class UserLoginSuccessState extends RollDiceState {
  final isLoading;
  final message;

  UserLoginSuccessState(this.isLoading,this.message);

  @override
  List<Object> get props => [isLoading,message];
}

class UserLoginFailedState extends RollDiceState {
  final isLoading;
  final String errorMessageKey;

  UserLoginFailedState(this.isLoading,this.errorMessageKey);

  @override
  List<Object> get props => [isLoading,errorMessageKey];
}