import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class LeaderBoardBloc extends Bloc<LeaderBoardEvent, LeaderBoardState> {
  @override
  LeaderBoardState get initialState => EmptyState(false);
  LeaderBoardBloc();

  @override
  Stream<LeaderBoardState> mapEventToState(LeaderBoardEvent event) async* {
    if (event is LeaderBoardPageReadyEvent) {
      yield LeaderBoardPageReadyState(true,false);
    }
  }
}