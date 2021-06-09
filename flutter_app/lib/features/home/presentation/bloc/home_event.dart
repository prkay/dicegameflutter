import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomePageReadyEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}

class GetAllUserListEvent extends HomeEvent {
  @override
  List<Object> get props => [];
}