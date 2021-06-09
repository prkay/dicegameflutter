import 'dart:ui';
import 'package:flutter/material.dart';

import '../dice_game_colors.dart';

TextTheme appTextTheme(BuildContext context) => Theme.of(context).textTheme;

TextTheme get diceGameTextStyleTheme => TextTheme(
  headline1: TextStyle(fontSize: 28, color: DiceGameAppColors.bodyText),
  // Display1 : headline2
  headline2: TextStyle(fontSize: 22, color: DiceGameAppColors.bodyText),
  // SubTitle : headline3
  headline3: TextStyle(fontSize: 20, color: DiceGameAppColors.bodyText),
  // Display 2 : headline4
  headline4: TextStyle(
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.bold,
      fontSize: 17.0,
      color: DiceGameAppColors.bodyText),
  headline5: TextStyle(fontSize: 16, color: DiceGameAppColors.bodyText),
  headline6: TextStyle(
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal,
      fontSize: 15.0,
      color: DiceGameAppColors.bodyText),
  subtitle1: TextStyle(fontSize: 13, color: DiceGameAppColors.bodyText),
  bodyText1: TextStyle(fontSize: 17, color: DiceGameAppColors.bodyText),
  bodyText2: TextStyle(fontSize: 16, color: DiceGameAppColors.bodyText),
  caption: TextStyle(fontSize: 15.0, color: DiceGameAppColors.bodyText),
  button: TextStyle(
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.normal,
    fontSize: 17.0,
  ),
  subtitle2: TextStyle(),
  overline: TextStyle(),
);

abstract class TextStyles {
  static const hyperlinkButtonTextStyle = TextStyle(
    color: DiceGameAppColors.hyperlinkButtonTextColor,
    fontWeight: FontWeight.normal,
    fontSize: 14.0,
    height: 1.72,
    letterSpacing: 0.18,
  );

  static const buttonTextStyle = TextStyle(
    color: DiceGameAppColors.buttonTextColor,
    fontWeight: FontWeight.normal,
    fontSize: 20.0,
    height: 1.20,
    letterSpacing: 0.25,
  );
  static const inputFieldLabelTextStyle = TextStyle(
    color: DiceGameAppColors.primaryInputFieldLabelColor,
    fontWeight: FontWeight.normal,
    fontSize: 16.0,
    height: 1.50,
    letterSpacing: 0.2,
  );
  static const primaryBodyTextStyle = TextStyle(
    color: DiceGameAppColors.bodyTextPrimaryColor,
    fontWeight: FontWeight.normal,
    fontSize: 18.0,
    height: 1.2,
    letterSpacing: 0.0,
  );

}
