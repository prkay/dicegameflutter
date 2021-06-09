import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class DiceGameApp extends StatelessWidget {
  final UserModel userModel;
  const DiceGameApp({Key key,this.userModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dice Game',
      theme: ThemeData(
        scaffoldBackgroundColor: DiceGameAppColors.primaryBodyColor,
        cupertinoOverrideTheme: CupertinoThemeData(
          primaryColor: DiceGameAppColors.interactionBlue,
        ),
        primaryColor: DiceGameAppColors.primaryBodyColor,
        cursorColor: DiceGameAppColors.interactionBlue,
        accentColor: DiceGameAppColors.accentBlue,
        textTheme: diceGameTextStyleTheme,
      ),
      supportedLocales: [
        Locale('en', 'US')
      ],
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale != null) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode) {
              return supportedLocale;
            }
          }
        }
        return supportedLocales.first;
      },
      home: userModel != null ? HomePage() :AppLoginPage(),
    );
  }
}