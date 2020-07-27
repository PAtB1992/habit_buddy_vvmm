import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class HabitSelectionCard extends StatelessWidget {
  HabitSelectionCard({this.color, this.cardText, this.onPress, this.habitIcon});
  final Color color;
  final String cardText;
  final Function onPress;
  final IconData habitIcon;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      onPressed: onPress,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            habitIcon,
            size: 40,
            color: Colors.white,
          ),
          Text(
            cardText,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
