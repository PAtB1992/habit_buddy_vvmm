import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/habit_tile.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/viewmodels/home_view_model.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';

// ignore: must_be_immutable
class HomeView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  bool hasHabitBuddy = false;

  HomeView({this.hasHabitBuddy});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: true,
      onModelReady: (model) => model.homeViewInitialization(hasHabitBuddy),
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: accentColor,
          onPressed: () {
            model.navigateToAddHabitView();
          },
          child: Icon(Icons.add),
        ),
        body: Container(
          color: primaryBlue,
          child: SafeArea(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 14,
                    child: Container(
                      color: primaryBlue,
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                          Text(
                            'Habit Buddy',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              SizedBox(
                                height: 10,
                              ),
                              RaisedButton(
                                color: accentColor,
                                elevation: 3,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                onPressed: hasHabitBuddy
                                    ? () {
                                        model.averageBuddyFeeling();
                                        _navigationService.navigateTo(
                                            BuddyViewRoute,
                                            arguments:
                                                model.habitBuddy.myHabitBuddy);
                                      }
                                    : () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    hasHabitBuddy
                                        ? Text(
                                            'Schaue hier, was Dein Habit Buddy macht!',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )
                                        : Flexible(
                                            child: AutoSizeText(
                                              'Hallo, ich bin dein Habit Buddy, lass uns loslegen!',
                                              style: TextStyle(
                                                  color: Colors.white),
                                              maxLines: 1,
                                            ),
                                          ),
                                    Hero(
                                      tag: 'icon',
                                      child: Icon(
                                        Icons.child_care,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              model.habitList.habitCount == 0
                                  ? AutoSizeText(
                                      'Füge auf dem Plusbutton eine Habit hinzu und starte durch!',
                                      style: TextStyle(color: primaryText),
                                      maxLines: 1,
                                    )
                                  : AutoSizeText(
                                      'Derzeit verfolgst Du ${model.habitList.habitCount} Ziele, bleib dran und wachse an Dir!',
                                      style: TextStyle(color: primaryText),
                                      maxLines: 1,
                                    ),
                            ],
                          ),
                          Expanded(
                            //      flex: 4,
                            child: MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                child: ListView.builder(
                                  itemBuilder: (context, index) {
                                    final habit =
                                        model.habitList.habitList[index];
                                    return HabitTile(
                                      customName: habit.customName,
                                      name: dynamicCategory(habit.name),
                                      repetitions: habit.repetitions,
                                      description: habit.customDescription,
                                      habitIcon: habitIcon(habit.name),
                                      hasHabitBuddy: hasHabitBuddy,
                                      buddyEvaluation: hasHabitBuddy
                                          ? model.buddyEvaluation(
                                                  model.milestones,
                                                  habit.name) ??
                                              'Dein Habit Buddy hat diese Rubrik nicht.'
                                          : '',
                                      onLongPress: () {
                                        model.deleteHabit(habit);
                                      },
                                      onPress: () async {
                                        await _navigationService.navigateTo(
                                          HabitDetailViewRoute,
                                          arguments: Habit(
                                            habitID: habit.habitID,
                                            name: habit.name,
                                            customDescription:
                                                habit.customDescription,
                                            customName: habit.customName,
                                            listIndex: index,
                                            repetitions: habit.repetitions,
                                            habitIcon: habitIcon(habit.name),
                                          ),
                                        );
                                        model.setBusy(false);
                                      },
                                    );
                                  },
                                  itemCount: model.habitList.habitCount,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
