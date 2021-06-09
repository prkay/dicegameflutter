import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/local_user_data.dart';
import 'dice_game_app.dart';
import 'features/register/model/registration_request_model.dart';
import 'injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  UserModel userModel = await LocalUserDB.getUserData();
  runApp(DiceGameApp(userModel: userModel,));
}
