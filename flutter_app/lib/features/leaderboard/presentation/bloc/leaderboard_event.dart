import 'package:equatable/equatable.dart';

abstract class LeaderBoardEvent extends Equatable {
  const LeaderBoardEvent();
}

class LeaderBoardPageReadyEvent extends LeaderBoardEvent {
  @override
  List<Object> get props => [];
}