import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_reflection_view_model.dart';
//import 'package:stacked/_viewmodel_builder.dart';
import 'package:stacked/stacked.dart';

class WeeklyReminderView extends StatelessWidget {
  WeeklyReminderView({this.pageControllerFunction});
  final void Function(int) pageControllerFunction;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddHabitReflectionViewModel>.reactive(
      builder: (context, model, child) => ReusableCard(
        color1: secondaryBlue,
        color2: primaryBlue,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
                child: AutoSizeText("Erinnere mich bitte wöchentlich am:",
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 17))),
            Flexible(
              child: CupertinoTheme(
                data: CupertinoThemeData(
                  barBackgroundColor: Colors.white,
                  primaryColor: Colors.white,
                  primaryContrastingColor: Colors.white,
                  textTheme: CupertinoTextThemeData(
                    dateTimePickerTextStyle: TextStyle(color: Colors.white),
                  ),
                ),
                child: CupertinoDatePicker(
                    use24hFormat: true,
                    initialDateTime: DateTime.now(),
                    onDateTimeChanged: (DateTime newdate) {
                      model.fetchNewWeeklyDate(newdate);
                    },
                    mode: CupertinoDatePickerMode.dateAndTime),
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => AddHabitReflectionViewModel(),
    );
  }
}
