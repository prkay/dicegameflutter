import 'package:equatable/equatable.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class EmptyState extends HomeState {
  final isLoading;

  EmptyState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class HomePageReadyState extends HomeState {
  final bool landingDone;
  final isLoading;

  HomePageReadyState(this.landingDone,this.isLoading);

  @override
  List<Object> get props => [landingDone,isLoading];
}

class GetAllUserListStartState extends HomeState {
  final isLoading;

  GetAllUserListStartState(this.isLoading);

  @override
  List<Object> get props => [isLoading];
}

class GetAllUserListSuccessState extends HomeState {
  final isLoading;
  final List<UserModel> userList;

  GetAllUserListSuccessState(this.isLoading,this.userList);

  @override
  List<Object> get props => [isLoading,userList];
}

class GetAllUserListFailedState extends HomeState {
  final isLoading;
  final String errorMessageKey;

  GetAllUserListFailedState(this.isLoading,this.errorMessageKey);

  @override
  List<Object> get props => [isLoading,errorMessageKey];
}