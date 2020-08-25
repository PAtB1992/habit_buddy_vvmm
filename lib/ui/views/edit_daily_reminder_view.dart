import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_reflection_view_model.dart';
import 'package:habitbuddyvvmm/viewmodels/edit_reminder_view_model.dart';
import 'package:stacked/stacked.dart';

class EditDailyReminderView extends StatelessWidget {
  EditDailyReminderView({this.pageControllerFunction});
  final void Function(int) pageControllerFunction;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditReminderViewModel>.reactive(
      builder: (context, model, child) => ReusableCard(
        color1: primaryBlue,
        color2: primaryBlue,
        cardChild: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Flexible(
                child: AutoSizeText("Erinnere mich bitte täglich um:",
                    textAlign: TextAlign.justify,
                    maxLines: 1,
                    style: TextStyle(color: Colors.white, fontSize: 17))),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Flexible(
                    child: CupertinoTheme(
                      data: CupertinoThemeData(
                        barBackgroundColor: Colors.white,
                        primaryColor: Colors.white,
                        primaryContrastingColor: Colors.white,
                        textTheme: CupertinoTextThemeData(
                          dateTimePickerTextStyle:
                              TextStyle(color: Colors.white),
                        ),
                      ),
                      child: CupertinoDatePicker(
                          use24hFormat: true,
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime newdate) {
                            model.fetchNewDailyDate(newdate);
                          },
                          mode: CupertinoDatePickerMode.time),
                    ),
                  ),
                  Flexible(
                      child: AutoSizeText(
                    'Uhr',
                    maxLines: 1,
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => EditReminderViewModel(),
    );
  }
}
