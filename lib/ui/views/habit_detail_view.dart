import 'package:flutter/material.dart';
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
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Text(habit.name),
        ),
        body: Padding(
          padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text('So oft hast du schon deinen Meilenstein erreicht:'),
              Text(
                model.repetitions.toString() == null
                    ? model.getRepetitions
                    : model.initialRepetitions(habit.listIndex),
                style: TextStyle(fontSize: 50),
              ),
              Flexible(
                child: RoundedButton(
                  title: 'Meilenstein abschließen',
                  color: primaryBlue,
                  onPressed: () {
                    model.completeMilestone(habit.listIndex);
                    model.getRepetitions(habit.listIndex);
                  },
                ),
              ),
              Text(habit.description),
            ],
          ),
        ),
      ),
    );
  }
}
