import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/habit_tile.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/viewmodels/home_view_model.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/models/habit.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/ui/components/dynamic_components.dart';

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
//          Header
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 4, offset: Offset(0, 2.5))
                ],
                color: primaryBlue,
              ),
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
                  Text(
                    'Habit Buddy',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 370,
                  height: 40,
                  child: RaisedButton(
                    color: accentColor,
                    elevation: 7,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    onPressed: hasHabitBuddy
                        ? () {
                            model.averageBuddyFeeling();
                            _navigationService.navigateTo(BuddyViewRoute,
                                arguments: model.habitBuddy.myHabitBuddy);
                          }
                        : () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        hasHabitBuddy
                            ? Text(
                                'Schaue hier, was Dein Habit Buddy macht!',
                                style: TextStyle(color: Colors.white),
                              )
                            : Text(
                                'Hallo, ich bin dein Habit Buddy, lass uns loslegen!',
                                style: TextStyle(color: Colors.white)),
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
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              padding: EdgeInsets.only(left: 15, right: 15, bottom: 10),
              color: Colors.white,
              child: model.habitList.habitCount == 0
                  ? Text(
                      'Füge auf dem Plusbutton eine Habit hinzu und starte durch!',
                      style: TextStyle(color: primaryText),
                    )
                  : Text(
                      'Derzeit verfolgst Du ${model.habitList.habitCount} Ziele, bleib dran und wachse an Dir!',
                      style: TextStyle(color: primaryText),
                    ),
            ),
            Flexible(
              child: Container(
//                padding: EdgeInsets.symmetric(horizontal: ),
                color: Colors.white,
                child: Center(
                    child: ListView.builder(
                  itemBuilder: (context, index) {
                    final habit = model.habitList.habitList[index];
                    return HabitTile(
                      customName: habit.customName,
                      name: dynamicCategory(habit.name),
                      repetitions: habit.repetitions,
                      description: habit.customDescription,
                      habitIcon: habitIcon(habit.name),
                      buddyEvaluation: hasHabitBuddy
                          ? model.buddyEvaluation(
                                  model.milestones, habit.name) ??
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
                            customDescription: habit.customDescription,
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
            ),
          ],
        ),
      ),
    );
  }
}
