import 'package:equatable/equatable.dart';

abstract class LeaderBoardState extends Equatable {
  const LeaderBoardState();
}

class EmptyState extends LeaderBoardState {
  final isLoading;

  EmptyState(this.isLoading);
  @override
  List<Object> get props => [isLoading];
}

class LeaderBoardPageReadyState extends LeaderBoardState {
  final bool landingDone;
  final isLoading;

  LeaderBoardPageReadyState(this.landingDone,this.isLoading);

  @override
  List<Object> get props => [landingDone,isLoading];
}