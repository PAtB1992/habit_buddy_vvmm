import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class MotivationStreak extends StatefulWidget {
  @override
  _MotivationStreakState createState() => _MotivationStreakState();
}

class _MotivationStreakState extends State<MotivationStreak> {
  @override
//  TODO extensible list
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.favorite, color: accentColor),
        Icon(Icons.favorite, color: accentColor),
        Icon(Icons.favorite, color: accentColor),
      ],
    );
  }
}
