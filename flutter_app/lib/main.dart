import 'package:flutter/material.dart';
import 'dice_game_app.dart';
import 'injection/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(DiceGameApp());
}
