import 'package:flutter/material.dart';
import 'package:flutter_app/core/repository/local_user_data.dart';
import 'package:flutter_app/features/home/presentation/bloc/bloc.dart';
import 'package:flutter_app/features/leaderboard/presentation/pages/leaderboard_pages.dart';
import 'package:flutter_app/features/login/presentation/bloc/bloc.dart';
import 'package:flutter_app/features/login/presentation/pages/login_page.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/features/rolldice/presentation/pages/rolldice_page.dart';
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

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool landingDone = false;
  HomeBloc _homeBloc;
  var _landingDone = false;
  bool _isLoading = true;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    _homeBloc = di<HomeBloc>();
    _homeBloc.add(HomePageReadyEvent());
    super.initState();
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _homeBloc,
      listener: (context, state) {
        if (state is LoginPageReadyState) {
          print(state.landingDone);
          print(state.isLoading);
          _landingDone = state.landingDone;
        }else if(state is GetAllUserListSuccessState){
          _navigateToleaderBoard(state);
        }else if(state is GetAllUserListFailedState){
          SnackBarMessageWidget(state.errorMessageKey,_scaffoldKey).buildSnackBar();
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

  _getLogoutButton(BuildContext context) {
    return DefaultButton(
      label: translate(context, StringKeys.logut),
      onPressed: () async {
        await LocalUserDB.removeUserData();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (c) => AppLoginPage()), (route) => false);
      },
    );
  }

  _getMenuOptions(BuildContext context) {
    return Column(
      children: [
        _getButtonForOptions(
            context, translate(context, StringKeys.leaderboard), _leaderBoard),
        _getSeparator(context),
        _getButtonForOptions(
            context, translate(context, StringKeys.rolldice), _rolldice),
      ],
    );
  }

  _getButtonForOptions(BuildContext context, String title, VoidCallback actionToPerform) {
    return InkWell(
      onTap: actionToPerform,
      child: Row(
        children: [
          Padding(
              padding: new EdgeInsets.only(
                  left: MarginKeys.homeIconOptionsMargin)),
          Padding(
              padding: EdgeInsets.only(
                  top: MarginKeys.buttonTextMarginTopBottom,
                  bottom: MarginKeys.buttonTextMarginTopBottom),
              child: Text(
                title,
                style: TextStyles.inputFieldLabelTextStyle,
                textAlign: TextAlign.start,
                textScaleFactor: 1.0,
              )),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.arrow_forward_ios,
                color: DiceGameAppColors.primaryButtonColor,
                size: DimensionKeys.arrowHeight,
              ),
            ),
          ),
          Padding(
              padding: new EdgeInsets.only(right: MarginKeys.homeIconOptionsMargin)),
        ],
      ),
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
          top: MarginKeys.commonVerticallMarginForScreenContent,
          left: MarginKeys.commonHorizontalMarginForScreenContent,
          right: MarginKeys.commonHorizontalMarginForScreenContent),
      child: Column(
        children: [
          InputFieldsContainer(
              bodyContent: _getMenuOptions(context)),
          _getLogoutButton(context),
          Padding(
              padding: EdgeInsets.only(
                  top: MarginKeys.buttonTextMarginTopBottom,
                  bottom: MarginKeys.buttonTextMarginTopBottom),
              child: Text(
                "v " + _homeBloc.versiontemp,
                style: TextStyles.inputFieldLabelTextStyle,
                textAlign: TextAlign.start,
                textScaleFactor: 1.0,
              )),
        ],
      ),
    );
  }

  Future<void> _rolldice() async {
    UserModel userModel =  await LocalUserDB.getUserData();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => RollDicePage(currentUser: userModel,)), (route) => false);
  }

  void _leaderBoard() {
    _homeBloc.add(GetAllUserListEvent());
  }

  Future<void> _navigateToleaderBoard(state) async {
    UserModel userModel =  await LocalUserDB.getUserData();
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => LeaderBoardPage(userList:state.userList,currentUser: userModel,)), (route) => false);
  }
}