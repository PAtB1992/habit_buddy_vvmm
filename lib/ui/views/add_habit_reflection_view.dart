import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/ui/views/daily_reminder_view.dart';
import 'package:habitbuddyvvmm/ui/views/reminder_view.dart';
import 'package:habitbuddyvvmm/ui/views/weekly_reminder_view.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_reflection_view_model.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';
import 'package:habitbuddyvvmm/ui/components/input_field.dart';

class AddHabitReflectionView extends StatefulWidget {
  final String habitName;
  final IconData habitIcon;
  List<bool> isSelected = [false, true, false];

  AddHabitReflectionView({Key key, this.habitName, this.habitIcon})
      : super(key: key);

  @override
  _AddHabitReflectionViewState createState() => _AddHabitReflectionViewState();
}

class _AddHabitReflectionViewState extends State<AddHabitReflectionView> {
  final descriptionController = TextEditingController();
  final nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddHabitReflectionViewModel>.reactive(
      viewModelBuilder: () => AddHabitReflectionViewModel(),
      builder: (context, model, child) => KeyboardDismisser(
        child: Scaffold(
          appBar: appBarStyle(widget.habitName),
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
                      child: dynamicImage(widget.habitName)),
                  ReusableCard(
                    center: true,
                    color1: primaryBlue,
                    color2: primaryBlue,
                    cardChild: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 16),
                      child: dynamicDescription(widget.habitName),
                    ),
                  ),
//                  SizedBox(
//                    height: 10,
//                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputField(
                      formatter: LengthLimitingTextInputFormatter(25),
                      smallVersion: true,
                      placeholder: 'Schreibe hier den Namen Deiner Habit.',
                      controller: nameController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InputField(
                      formatter: LengthLimitingTextInputFormatter(100),
                      smallVersion: false,
                      placeholder:
                          'Beschreibe hier, wann Dein Meilenstein erfüllt ist.',
                      controller: descriptionController,
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
                        DailyReminderView(
                          pageControllerFunction: model.pageControllerFunction,
                        ),
                        ReminderView(
                          pageControllerFunction: model.pageControllerFunction,
                        ),
                        WeeklyReminderView(
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
                          model.setReminder(
                              model.getHabitReminderID(widget.habitName),
                              nameController.text);
                          await model.addHabit(
                            reminderID:
                                model.getHabitReminderID(widget.habitName),
                            habitName: widget.habitName,
                            customDescription: descriptionController.text,
                            customName: nameController.text,
                          );
                          Navigator.pop(context, model.addedHabit);
                        },
                        child: Text('Loslegen!',
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
