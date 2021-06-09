import 'package:flutter/material.dart';
import 'package:flutter_app/localization/app_localization.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';

import '../margin_keys.dart';

class SnackBarMessageWidget {
  @override
  final String message;
  final GlobalKey<ScaffoldState> scaffoldKey;

  SnackBarMessageWidget(
      this.message,
      this.scaffoldKey
      );

  buildSnackBar() {
     Scaffold.of(scaffoldKey.currentContext).showSnackBar(new SnackBar(
      backgroundColor: DiceGameAppColors.primaryBodyColor,
      content: new Container(
          width: MediaQuery.of(scaffoldKey.currentContext).size.width,
          decoration: BoxDecoration(
            color: DiceGameAppColors.white,
            borderRadius: BorderRadius.all(
                Radius.circular(BorderSideKeys.inputFieldContainerRadius)),
            boxShadow: [
              BoxShadow(
                color: DiceGameAppColors.boxUpperShadowColor,
                blurRadius: BorderSideKeys.boxBlurRadius,
                spreadRadius: BorderSideKeys.boxBlurSpreadRadius,
                offset: OffsetsKey.upperShadowOffset,
              ),
              BoxShadow(
                color: DiceGameAppColors.boxLowerShadowColor,
                blurRadius: BorderSideKeys.boxBlurRadius,
                offset: OffsetsKey.lowerShadowOffset,
              ),
            ],
          ),
          child: _buildMessage(message,scaffoldKey.currentContext)),
    ));
  }

  _buildMessage(String message,BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          vertical: MarginKeys.commonMargin,
          horizontal: MarginKeys.commonMargin),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.notifications_active_outlined,
            color: DiceGameAppColors.primaryButtonColor,
            size: DimensionKeys.messageIconHeight,
          ),
          SizedBox(
            height: MarginKeys.commonMargin,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: MarginKeys.commonMargin),
              child: Text(
                translate(context, message),
                textScaleFactor: 1.0,
                textAlign: TextAlign.left,
                style: TextStyles.primaryBodyTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}