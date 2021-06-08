import 'package:flutter/material.dart';
import 'package:flutter_app/resources/margin_keys.dart';
import 'package:flutter_app/resources/styles/text_styles.dart';

class DefaultHyperLinkButton extends StatelessWidget {
  @override
  final String label;
  final VoidCallback onPressed;

  DefaultHyperLinkButton({
    this.label,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MarginKeys.zeroMargin),
      child: Container(
        width:  MediaQuery.of(context).size.width,
        child: getTextContainer(),
      ),
    );
  }

  getTextContainer() {
    return Padding(
      padding: EdgeInsets.only(bottom: MarginKeys.buttonTextMarginTopBottom),
      child: InkWell(
          child: Text(
            label,
            style: TextStyles.hyperlinkButtonTextStyle,
            textAlign: TextAlign.center,
            textScaleFactor: 1.0,
          ),
          onTap: onPressed
      ),);
  }
}