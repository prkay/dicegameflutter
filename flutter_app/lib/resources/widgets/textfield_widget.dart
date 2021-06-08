import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';
import 'package:flutter_app/resources/margin_keys.dart';

class TextFieldWidgets extends StatelessWidget {
  @override
  final String inputPlaceHolder;
  final TextEditingController controller;
  final String inputText;
  final TextInputType inputType;
  final VoidCallback onPressed;
  final bool isVisible;
  final FormFieldValidator validator;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final Function onSaved;
  final Function onFieldSubmitted;
  final TextStyle labelStyle;
  final TextStyle inputStyle;

  // ignore: deprecated_member_use
  final WhitelistingTextInputFormatter whitelistingTextInputFormatter;

  TextFieldWidgets(
      {this.inputPlaceHolder,
        this.controller,
        this.inputText,
        this.inputType,
        this.onPressed,
        this.isVisible = false,
        this.validator,
        this.focusNode,
        this.textInputAction,
        this.onSaved,
        this.onFieldSubmitted,
        this.labelStyle,
        this.inputStyle,
        this.whitelistingTextInputFormatter,});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: MarginKeys.floatingLabelMargin),
      child: Padding(
        padding: EdgeInsets.only(right: MarginKeys.zeroMargin),
        child: TextFormField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          textInputAction: textInputAction,
          style: inputStyle,
          validator: validator,
          onSaved: onSaved,
          cursorColor: DiceGameAppColors.primaryInputFieldLabelColor,
          obscureText: isVisible,
          inputFormatters: [
            // ignore: deprecated_member_use
            whitelistingTextInputFormatter,
          ],
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(BorderSideKeys.inputFieldContainerRadius)),
              borderSide: BorderSide(
                  width: BorderSideKeys.borderSideWidth,
                  color: DiceGameAppColors.primaryBodyColor),
            ),
            contentPadding: EdgeInsets.only(
                left: MarginKeys.inputFieldLabelLeftRightMargin,
                top: MarginKeys.inputFieldLabelTopMargin,
                bottom: MarginKeys.inputFieldLabelBottomMargin),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(BorderSideKeys.inputFieldContainerRadius)),
              borderSide: BorderSide(
                  width: BorderSideKeys.borderSideWidth,
                  color: DiceGameAppColors.primaryBodyColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(BorderSideKeys.inputFieldContainerRadius)),
              borderSide: BorderSide(
                  width: BorderSideKeys.borderSideWidth,
                  color: DiceGameAppColors.primaryBodyColor),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(BorderSideKeys.inputFieldContainerRadius)),
              borderSide: BorderSide(
                  width: BorderSideKeys.borderSideWidth,
                  color: DiceGameAppColors.primaryBodyColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(BorderSideKeys.inputFieldContainerRadius)),
              borderSide: BorderSide(
                  width: BorderSideKeys.borderSideWidth,
                  color: DiceGameAppColors.primaryBodyColor),
            ),
            labelText: inputPlaceHolder,
            labelStyle: labelStyle,
          ),
          keyboardType: inputType,
          onTap: onPressed,
        ),
      ),
    );
  }
}