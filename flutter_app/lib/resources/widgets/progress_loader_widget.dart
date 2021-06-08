import 'package:flutter/material.dart';
import 'package:flutter_app/resources/dice_game_colors.dart';

class ProgressHUD extends StatelessWidget {
  final Widget child;
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Animation<Color> valueColor;

  ProgressHUD({
    Key key,
    @required this.child,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = DiceGameAppColors.primaryBodyColor,
    this.valueColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = <Widget>[];
    widgetList.add(child);
    if (inAsyncCall) {
      final modal = Stack(
        children: [
          Opacity(
            opacity: opacity,
            child: ModalBarrier(dismissible: false, color: color),
          ),
          Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(DiceGameAppColors.primaryButtonColor),
            ),
          ),
        ],
      );
      widgetList.add(modal);
    }
    return Stack(
      children: widgetList,
    );
  }
}