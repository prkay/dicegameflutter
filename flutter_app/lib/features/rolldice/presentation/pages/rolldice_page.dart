import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/local_user_data.dart';
import 'package:flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_app/features/login/model/login_request_model.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/features/rolldice/presentation/bloc/bloc.dart';
import 'package:flutter_app/injection/injection_container.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/margin_keys.dart';
import 'package:flutter_app/resources/string_keys.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';
import 'package:flutter_app/resources/widgets/default_button.dart';
import 'package:flutter_app/resources/widgets/input_field_widget.dart';
import 'package:flutter_app/resources/widgets/progress_loader_widget.dart';
import 'package:flutter_app/resources/widgets/snack_bar_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RollDicePage extends StatefulWidget {
  final UserModel currentUser;
  RollDicePage({Key key, this.currentUser}) : super(key: key);

  @override
  _RollDicePageState createState() => _RollDicePageState(currentUser);
}

class _RollDicePageState extends State<RollDicePage> {
   UserModel currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool landingDone = false;
  RollDiceBloc _rollDiceBloc;
  var _landingDone = false;
  bool _isLoading = true;
  AssetImage one = AssetImage("images/one.png");
  AssetImage two = AssetImage("images/two.png");
  AssetImage three = AssetImage("images/three.png");
  AssetImage four = AssetImage("images/four.png");
  AssetImage five = AssetImage("images/five.png");
  AssetImage six = AssetImage("images/six.png");
  AssetImage diceImage;

  _RollDicePageState(this.currentUser);

  @override
  void initState() {
    _rollDiceBloc = di<RollDiceBloc>();
    _rollDiceBloc.add(RollDicePageReadyEvent());
    super.initState();
    setState(() {
      diceImage = one;
    });
  }

  @override
  void dispose() {
    _rollDiceBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _rollDiceBloc,
      listener: (context, state) {
        if (state is RollDicePageReadyState) {
          print(state.landingDone);
          print(state.isLoading);
          _landingDone = state.landingDone;
        }else if(state is UpdateNewRecordFailedState){
          SnackBarMessageWidget(state.errorMessageKey,_scaffoldKey).buildSnackBar();
        }else if(state is UpdateNewRecordSuccessState){
          _rollDiceBloc.add(LoginUserDataStart(LoginRequest(email: currentUser.email,password: currentUser.password)));
          SnackBarMessageWidget(state.message,_scaffoldKey).buildSnackBar();
        }else if(state is UserLoginFailedState){
          SnackBarMessageWidget(translate(context, StringKeys.somethingWentWrong),_scaffoldKey).buildSnackBar();
        }else if(state is UserLoginSuccessState){
          _updateLocalData();
        }
      },
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
              key: _scaffoldKey,
              children: <Widget>[
                GestureDetector(
                  child: ProgressHUD(
                      inAsyncCall: state.isLoading,
                      child: Container(
                        color: DiceGameAppColors.primaryBodyColor,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        child: SingleChildScrollView(
                          child: SafeArea(child: _getBodyContent(context)),
                        ),
                      )),
                ),
              ]),
        );
      },
    );
  }

  _getSeparator(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(MarginKeys.zeroMargin),
      color: DiceGameAppColors.inputFieldSeparatorColor,
      height: DimensionKeys.heightOfInputFieldSeparator,
    );
  }

  _getBodyContent(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MarginKeys.zeroMargin,
          left: MarginKeys.commonHorizontalMarginForScreenContent,
          right: MarginKeys.commonHorizontalMarginForScreenContent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: ()=>_navigateBack(),
            child: Icon(
              Icons.arrow_back_ios,
              color: DiceGameAppColors.primaryButtonColor,
              size: DimensionKeys.arrowHeight,
            ),
          ),
          Padding(
              padding: new EdgeInsets.only(
                  bottom: MarginKeys.homeIconOptionsMargin)),
          _getUserInfo(context),
          Align(
            alignment: Alignment.center,
            child: Image(
              image: diceImage,
              width: DimensionKeys.diceImageSize,
              height: DimensionKeys.diceImageSize,
            ),
          ),
          currentUser.numberOfGame < 10 ?_getRollDiceButton(context) : Padding(padding: EdgeInsets.zero)
        ],
      ),
    );
  }

  _getRollDiceButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: MarginKeys.zeroMargin,
        bottom: MarginKeys.topBottomMarginToButton,
      ),
      child: DefaultButton(
        label: translate(context, StringKeys.rolldice),
        onPressed: () {
          rollDiceRandomly();
        },
      ),
    );
  }

  _navigateBack() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => HomePage()), (route) => false);
  }

  _getLabelValue(String label, String value) {
    return Row(
      children: [
        Padding(
            padding: new EdgeInsets.only(
                left: MarginKeys.homeIconOptionsMargin)),
        Padding(
            padding: EdgeInsets.only(
                top: MarginKeys.buttonTextMarginTopBottom,
                bottom: MarginKeys.buttonTextMarginTopBottom),
            child: Text(
              label,
              style: TextStyles.inputFieldLabelTextStyle,
              textAlign: TextAlign.start,
              textScaleFactor: 1.0,
            )),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              value,
              style: TextStyles.inputFieldLabelTextStyle,
              textAlign: TextAlign.start,
              textScaleFactor: 1.0,
            ),
          ),
        ),
        Padding(
            padding: new EdgeInsets.only(right: MarginKeys.homeIconOptionsMargin))
      ],
    );
  }

  void rollDiceRandomly(){
    int finalResult = (1+Random().nextInt(6));
    AssetImage diceOutputImage;
    switch (finalResult) {
      case 1:
        diceOutputImage = one;
        break;
      case 2:
        diceOutputImage = two;
        break;
      case 3:
        diceOutputImage = three;
        break;
      case 4:
        diceOutputImage = four;
        break;
      case 5:
        diceOutputImage = five;
        break;
      case 6:
        diceOutputImage = six;
        break;
    }
    setState(() {
      diceImage = diceOutputImage;
    });
    UserModel userModel = UserModel(
      email: currentUser.email,
      name: currentUser.name,
      password: currentUser.password,
      numberOfGame: currentUser.numberOfGame + 1,
      totalPoints: currentUser.totalPoints + finalResult,
    );
    _rollDiceBloc.add(UpdateNewRecordEvent(userModel));
  }

  _getUserInfo(BuildContext context) {
    return InputFieldsContainer(
        bodyContent: Container(
            decoration: BoxDecoration(
              color: DiceGameAppColors.white,
              borderRadius: BorderRadius.all(
                  Radius.circular((BorderSideKeys.inputFieldContainerRadius))),
            ),
            child: Column(
              children: [
                _getLabelValue(translate(context, StringKeys.firstName),currentUser.name),
                _getSeparator(context),
                _getLabelValue(translate(context, StringKeys.usernameTextFieldLabelText),currentUser.email),
                _getSeparator(context),
                _getLabelValue(translate(context, StringKeys.gamesPlayed),currentUser.numberOfGame.toString()),
                _getSeparator(context),
                _getLabelValue(translate(context, StringKeys.totalScore),currentUser.totalPoints.toString()),
              ],
            )));
  }

  Future<void> _updateLocalData() async {
    UserModel user = await LocalUserDB.getUserData();
    setState(() {
      currentUser = user;
    });
  }
}