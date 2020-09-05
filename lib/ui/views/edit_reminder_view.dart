import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/ui/views/daily_reminder_view.dart';
import 'package:habitbuddyvvmm/ui/views/reminder_view.dart';
import 'package:habitbuddyvvmm/ui/views/weekly_reminder_view.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_reflection_view_model.dart';
import 'package:habitbuddyvvmm/viewmodels/edit_reminder_view_model.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/ui/components/input_field.dart';

import 'delete_reminder_view.dart';
import 'edit_daily_reminder_view.dart';
import 'edit_weekly_reminder_view.dart';

class EditReminderView extends StatefulWidget {
  final Habit habit;
  final IconData habitIcon;
  List<bool> isSelected = [false, true, false];

  EditReminderView({Key key, this.habit, this.habitIcon}) : super(key: key);

  @override
  _EditReminderViewState createState() => _EditReminderViewState();
}

class _EditReminderViewState extends State<EditReminderView> {
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditReminderViewModel>.reactive(
      viewModelBuilder: () => EditReminderViewModel(),
      builder: (context, model, child) => KeyboardDismisser(
        child: Scaffold(
          appBar: AppBar(
            title: AutoSizeText.rich(
              TextSpan(
                text: 'Erinnerung ',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                children: <TextSpan>[
                  TextSpan(
                      text: 'editieren ', style: TextStyle(color: accentColor)),
//            TextSpan(
//              text: 'Leben',
//            ),
                ],
              ),
              maxLines: 1,
            ),
            backgroundColor: primaryBlue,
          ),
          body: SafeArea(
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 10),
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: dynamicImage(widget.habit.name)),
                  ReusableCard(
                    center: true,
                    color1: primaryBlue,
                    color2: primaryBlue,
                    cardChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: AutoSizeText(
                        reminder,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey,
                                blurRadius: 3,
                                offset: Offset(0, 2))
                          ],
                          color: primaryBlue,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: LayoutBuilder(builder: (context, constraints) {
                        return ToggleButtons(
                          constraints: BoxConstraints.expand(
                              width: (constraints.maxWidth - (4)) / 3),
                          selectedBorderColor: accentColor,
                          selectedColor: Colors.white,
                          fillColor: accentColor,
                          borderRadius: BorderRadius.circular(10),
                          onPressed: (int index) {
                            setState(() {
                              for (int buttonIndex = 0;
                                  buttonIndex < widget.isSelected.length;
                                  buttonIndex++) {
                                if (buttonIndex == index) {
                                  widget.isSelected[buttonIndex] = true;
                                } else {
                                  widget.isSelected[buttonIndex] = false;
                                }
                                model.pageControllerFunction(index);
                              }
                            });
                          },
                          isSelected: widget.isSelected,
                          children: <Widget>[
                            Container(
                              child: Text(
                                'Täglich',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Nie',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              child: Text(
                                'Wöchentlich',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        );
                      }),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 140,
                    child: PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: model.pageViewController,
                      children: <Widget>[
                        EditDailyReminderView(
                          pageControllerFunction: model.pageControllerFunction,
                        ),
                        DeleteReminderView(
                          pageControllerFunction: model.pageControllerFunction,
                        ),
                        EditWeeklyReminderView(
                          pageControllerFunction: model.pageControllerFunction,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0, 8, 0),
                    child: SizedBox(
                      width: 370,
                      height: 40,
                      child: RaisedButton(
                        elevation: 5,
                        color: accentColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () async {
                          model.setReminder(widget.habit);
                          model.popScreen();
                        },
                        child: Text('Speichern',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
