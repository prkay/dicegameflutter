import 'package:flutter_app/core/repository/firebase_repositroy.dart';
import 'package:flutter_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_app/features/leaderboard/presentation/bloc/bloc.dart';
import 'package:flutter_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_app/features/register/presentation/bloc/registeration_bloc.dart';
import 'package:flutter_app/features/rolldice/presentation/bloc/bloc.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {
  // BLoC
  di.registerFactory(() => LoginBloc(fireBaseRepository: FireBaseRepository()));
  di.registerFactory(() => RegistrationBloc(fireBaseRepository: FireBaseRepository()));
  di.registerFactory(() => HomeBloc(fireBaseRepository: FireBaseRepository()));
  di.registerFactory(() => LeaderBoardBloc());
  di.registerFactory(() => RollDiceBloc(fireBaseRepository: FireBaseRepository()));
}