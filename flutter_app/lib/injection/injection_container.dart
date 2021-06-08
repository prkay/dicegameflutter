import 'package:flutter_app/features/login/presentation/bloc/login_bloc.dart';
import 'package:flutter_app/features/register/presentation/bloc/registeration_bloc.dart';
import 'package:get_it/get_it.dart';

final di = GetIt.instance;

Future<void> init() async {
  // BLoC
  di.registerFactory(() => LoginBloc());
  di.registerFactory(() => RegistrationBloc());
}