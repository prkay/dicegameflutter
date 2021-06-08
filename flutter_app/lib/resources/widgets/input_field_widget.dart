import 'package:flutter/material.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/margin_keys.dart';

class InputFieldsContainer extends StatelessWidget {
  @override
  final Widget bodyContent;
  InputFieldsContainer({
    this.bodyContent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: MarginKeys.topBottomMarginToButton,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: DiceGameAppColors.primaryBodyColor,
        borderRadius: BorderRadius.all(
            Radius.circular((BorderSideKeys.inputFieldContainerRadius))),
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
      child: bodyContent,
    );
  }
}