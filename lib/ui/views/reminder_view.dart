import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';

class ReminderView extends StatefulWidget {
  ReminderView({this.pageControllerFunction});
  final Function(int) pageControllerFunction;
  List<bool> isSelected = [false, false, false];

  @override
  _ReminderViewState createState() => _ReminderViewState();
}

class _ReminderViewState extends State<ReminderView> {
  @override
  Widget build(BuildContext context) {
    return ReusableCard(
      color1: primaryBlue,
      color2: primaryBlue,
      cardChild: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: AutoSizeText(reminder,
            textAlign: TextAlign.justify,
            style: TextStyle(color: Colors.white, fontSize: 17)),
      ),
    );
  }
}
