import 'package:flutter/material.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';

import '../margin_keys.dart';

class DefaultButton extends StatelessWidget {
  @override
  final String label;
  final VoidCallback onPressed;

  DefaultButton(
      {
        this.label,
        this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MarginKeys.zeroMargin),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: DiceGameAppColors.primaryBodyColor,
          borderRadius:
          BorderRadius.all(Radius.circular(BorderSideKeys.buttonRadius)),
        ),
        child: RaisedButton(
          elevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          highlightElevation: 0,
          key: key,
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(BorderSideKeys.buttonRadius)),
          ),
          color: DiceGameAppColors.primaryButtonColor,
          child: _getButtonBody(),
        ),
      ),
    );
  }

  _getButtonBody() {
    return Padding(
        padding: EdgeInsets.only(
            top: MarginKeys.buttonTextMarginTopBottom,
            bottom: MarginKeys.buttonTextMarginTopBottom),
        child: Text(
          label,
          style: TextStyles.buttonTextStyle,
          textAlign: TextAlign.center,
          textScaleFactor: 1.0,
        ));
  }
}