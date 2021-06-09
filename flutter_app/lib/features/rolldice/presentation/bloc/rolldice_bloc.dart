import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/firebase_repositroy.dart';
import 'package:flutter_app/features/login/model/login_request_model.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class RollDiceBloc extends Bloc<RollDiceEvent, RollDiceState> {
  @override
  RollDiceState get initialState => EmptyState(false);
  final FireBaseRepository fireBaseRepository;
  RollDiceBloc({@required this.fireBaseRepository,});

  @override
  Stream<RollDiceState> mapEventToState(RollDiceEvent event) async* {
    if (event is RollDicePageReadyEvent) {
      yield RollDicePageReadyState(true,false);
    }else if(event is UpdateNewRecordEvent){
      yield* updateData(event.userModel);
    }else if(event is LoginUserDataStart){
      print("dfdsafs");
      yield* authenticateUser(event.loginRequest);
    }
  }

  Stream<RollDiceState> updateData(UserModel userModel) async* {
    yield UpdateNewRecordStartState(true);
    try{
      var message = await fireBaseRepository.updateStoredDate(userModel: userModel);
      yield UpdateNewRecordSuccessState(false,message);
    }catch(e){
      UpdateNewRecordFailedState(false,StringKeys.somethingWentWrong);
    }
  }

  Stream<RollDiceState> authenticateUser(LoginRequest loginRequest) async* {
    yield UserLoginStartState(true);
    try{
      var message = await fireBaseRepository.authenticateUser(userModel: loginRequest);
      yield UserLoginSuccessState(false,message);
    }catch(e){
      UserLoginFailedState(false,StringKeys.somethingWentWrong);
    }
  }
}