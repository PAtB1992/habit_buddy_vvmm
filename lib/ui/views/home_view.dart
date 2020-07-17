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

class HomeView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      disposeViewModel: true,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                ReusableCard(
                  color1: accentColor,
                  color2: accentColor,
                  onPress: () {
                    _navigationService.navigateTo(BuddyViewRoute);
                  },
                  cardChild: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Motiviere Dich und Deinen Habit Buddy!',
                          style: TextStyle(color: Colors.white),
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
                      'Füge eine Habit hinzu und starte durch!',
                      style: TextStyle(color: primaryText),
                    )
                  : Text(
                      'Derzeit verfolgst Du ${model.habitList.habitCount} Ziele, bleib dran und wachse an Dir!',
                      style: TextStyle(color: primaryText),
                    ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final habit = model.habitList.habitList[index];
                    return HabitTile(
                      name: habit.name,
                      repetitions: habit.repetitions,
                      description: habit.customDescription,
                      habitIcon: Icon(
                        habit.habitIcon,
                        color: Colors.white,
                      ),
                      onPress: () async {
                        await _navigationService.navigateTo(
                          HabitDetailViewRoute,
                          arguments: Habit(
                            name: habit.name,
                            repetitions: habit.repetitions,
                            description: habit.description,
                            listIndex: index,
                            customDescription: habit.customDescription,
                            habitIcon: habit.habitIcon,
                          ),
                        );
                        model.setBusy(false);
                      },
                    );
                  },
                  itemCount: model.habitList.habitCount,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
