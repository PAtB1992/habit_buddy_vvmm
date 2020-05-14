import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/ui/components/rounded_button.dart';
import 'package:habitbuddyvvmm/viewmodels/habit_detail_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class HabitDetailView extends StatelessWidget {
  final Habit habit;
  HabitDetailView({Key key, this.habit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      viewModelBuilder: () => HabitDetailViewModel(),
      builder: (context, model, child) => Scaffold(
        body: Column(
          children: <Widget>[
            Container(
              color: primaryBlue,
              padding: EdgeInsets.only(top: 60.0, bottom: 30.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    child: Icon(
                      Icons.child_care,
                      size: 30.0,
                      color: accentColor,
                    ),
                    backgroundColor: Colors.white,
                    radius: 30.0,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Wrap(
                    children: <Widget>[
                      Text(
                        habit.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Flexible(
              child: ListView(
                children: <Widget>[
                  ReusableCard(
                    height: 100,
                    color1: accentColor,
                    color2: accentColor,
                    cardChild: Center(
                      child: Text(
                        'Meilenstein abschließen',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    onPress: () {
                      model.completeMilestone(habit.listIndex);
                      model.getRepetitions(habit.listIndex);
                    },
                  ),
                  ReusableCard(
                    height: 200,
                    color1: primaryBlue,
                    color2: primaryBlue,
                    cardChild: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'So oft hast du schon deinen Meilenstein erreicht:',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          model.repetitions.toString() == null
                              ? model.getRepetitions
                              : model.initialRepetitions(habit.listIndex),
                          style: TextStyle(fontSize: 70, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  ReusableCard(
                    height: 150,
                    color1: primaryBlue,
                    color2: primaryBlue,
                    cardChild: Center(
                      child: Text(
                        '${habit.description}',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                  ReusableCard(
                    height: 150,
                    color1: primaryBlue,
                    color2: primaryBlue,
                    cardChild: Center(
                      child: Text(
                        'Statistiken',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
