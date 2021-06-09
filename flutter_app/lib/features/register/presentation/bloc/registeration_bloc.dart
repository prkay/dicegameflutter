import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/firebase_repositroy.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc.dart';

class RegistrationBloc extends Bloc<RegistrationEvent, Registrationstate> {
  @override
  Registrationstate get initialState => EmptyState(false);
  final FireBaseRepository fireBaseRepository;
  RegistrationBloc({@required this.fireBaseRepository,});

  @override
  Stream<Registrationstate> mapEventToState(RegistrationEvent event) async* {
    if (event is RegistrationPageReadyEvent) {
      yield* fetchRandomData();
    }else if(event is RegistrationStart){
      yield* registerUser(event.userModel);
    }
  }

  Stream<Registrationstate> fetchRandomData() async* {
    yield RegistrationPageReadyState(true,false);
  }

  Stream<Registrationstate> registerUser(UserModel userModel) async* {
    yield UserRegistrationStartState(true);
      try{
        var message = await fireBaseRepository.storeUserData(userModel: userModel);
        yield UserRegistrationSuccessState(false,message);
      }catch(e){
        UserRegistrationFailedState(false,StringKeys.somethingWentWrong);
      }
  }
}