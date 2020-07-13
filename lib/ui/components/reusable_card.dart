import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard(
      {@required this.color1,
      @required this.color2,
      this.cardChild,
      this.onPress,
      this.borderColor,
      this.height});
  final Color color1;
  final Color color2;
  final Color borderColor;
  final Widget cardChild;
  final Function onPress;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: height,
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: cardChild,
        margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [color1, color2],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(10.0),
//          border: Border.all(width: 1, color: borderColor),
        ),
      ),
    );
  }
}
