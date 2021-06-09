import 'package:flutter/material.dart';
import 'package:flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:flutter_app/features/leaderboard/presentation/bloc/bloc.dart';
import 'package:flutter_app/features/register/model/registration_request_model.dart';
import 'package:flutter_app/injection/injection_container.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/margin_keys.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';
import 'package:flutter_app/resources/widgets/input_field_widget.dart';
import 'package:flutter_app/resources/widgets/progress_loader_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LeaderBoardPage extends StatefulWidget {
  final List<UserModel> userList;
  final UserModel currentUser;
  LeaderBoardPage({Key key, this.userList, this.currentUser}) : super(key: key);

  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState(userList,currentUser);
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  final List<UserModel> userList;
  final UserModel currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool landingDone = false;
  LeaderBoardBloc _leaderBoardBloc;
  var _landingDone = false;
  bool _isLoading = true;

  _LeaderBoardPageState(this.userList, this.currentUser);

  @override
  void initState() {
    _leaderBoardBloc = di<LeaderBoardBloc>();
    _leaderBoardBloc.add(LeaderBoardPageReadyEvent());
    super.initState();
  }

  @override
  void dispose() {
    _leaderBoardBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _leaderBoardBloc,
      listener: (context, state) {
        if (state is LeaderBoardPageReadyState) {
          print(state.landingDone);
          print(state.isLoading);
          _landingDone = state.landingDone;
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

  _buildLeadeBoard(BuildContext context, UserModel userModel,int ranking) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
                padding: new EdgeInsets.only(
                    left: MarginKeys.homeIconOptionsMargin)),
            Padding(
                padding: EdgeInsets.only(
                    top: MarginKeys.buttonTextMarginTopBottom,
                    bottom: MarginKeys.buttonTextMarginTopBottom),
                child: Text(
                  "#" + (ranking + 1).toString(),
                  style: TextStyles.inputFieldLabelTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.0,
                )),
            Padding(
                padding: new EdgeInsets.only(
                    left: MarginKeys.homeIconOptionsMargin)),
            Padding(
                padding: EdgeInsets.only(
                    top: MarginKeys.buttonTextMarginTopBottom,
                    bottom: MarginKeys.buttonTextMarginTopBottom),
                child: Text(
                  userModel.name,
                  style: TextStyles.inputFieldLabelTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.0,
                )),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  userModel.totalPoints.toString()+ "/60",
                  style: TextStyles.inputFieldLabelTextStyle,
                  textAlign: TextAlign.start,
                  textScaleFactor: 1.0,
                ),
              ),
            ),
            Padding(
                padding: new EdgeInsets.only(right: MarginKeys.homeIconOptionsMargin)),
          ],
        ),
        _getSeparator(context),
      ],);
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
          InputFieldsContainer(
              bodyContent: Container(
                  decoration: BoxDecoration(
                    color: DiceGameAppColors.white,
                    borderRadius: BorderRadius.all(
                        Radius.circular((BorderSideKeys.inputFieldContainerRadius))),
                  ),
                  child: _buildLeadeBoard(context,currentUser,userList.indexWhere((element) => element.email== currentUser.email)))),
          InputFieldsContainer(
              bodyContent: Container(
                height: MediaQuery.of(context).size.height*0.7,
                  child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, i) {
                  return _buildLeadeBoard(context,userList[i],i);
                },
              ))),
        ],
      ),
    );
  }

  _navigateBack() {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => HomePage()), (route) => false);
  }
}