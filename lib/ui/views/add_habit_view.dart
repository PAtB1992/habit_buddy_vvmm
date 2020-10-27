import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/ui/components/habit_selection_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/locator.dart';

class AddHabitView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddHabitViewModel>.reactive(
      viewModelBuilder: () => AddHabitViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'Wähle ',
              style: TextStyle(
                  fontSize: 29,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: 'Deine ', style: TextStyle(color: accentColor)),
                TextSpan(
                  text: 'Habit',
                ),
              ],
            ),
          ),
          backgroundColor: primaryBlue,
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Text(
                  addHabitViewText,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      HabitSelectionCard(
                        color: secondaryBlue,
                        onPress: () {
                          model.navigateToReflectionViewAndWaitForPop(
                              context, 'gesünder-ernähren');
                        },
                        habitIcon: Icons.fastfood,
                        cardText: 'Ich möchte mich gesünder ernähren.',
                      ),
                      HabitSelectionCard(
                        color: secondaryBlue,
                        onPress: () {
                          model.navigateToReflectionViewAndWaitForPop(
                              context, 'besser-organisieren');
                        },
                        habitIcon: Icons.access_time,
                        cardText: 'Ich möchte mich besser organisieren.',
                      ),
                      HabitSelectionCard(
                        color: primaryBlue,
                        onPress: () {
                          model.navigateToReflectionViewAndWaitForPop(
                              context, "fähigkeiten-lernen");
                        },
                        habitIcon: Icons.palette,
                        cardText:
                            'Ich möchte eine bestimmte Fähigkeit verbessern.',
                      ),
                      HabitSelectionCard(
                        color: primaryBlue,
                        onPress: () {
                          model.navigateToReflectionViewAndWaitForPop(
                              context, "sich-mehr-bewegen");
                        },
                        habitIcon: Icons.directions_run,
                        cardText: 'Ich möchte mich mehr bewegen.',
                      ),
                      HabitSelectionCard(
                        color: thirdrateBlue,
                        onPress: () {
                          model.navigateToReflectionViewAndWaitForPop(
                              context, "mehr-wasser-trinken");
                        },
                        habitIcon: Icons.local_drink,
                        cardText: 'Ich möchte mehr Wasser trinken.',
                      ),
                      HabitSelectionCard(
                        color: thirdrateBlue,
                        onPress: () {
                          model.navigateToReflectionViewAndWaitForPop(
                              context, "am-charakter-arbeiten");
                        },
                        habitIcon: CupertinoIcons.profile_circled,
                        cardText: 'Ich möchte an meinem Charakter arbeiten.',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          color: fourthrateBlue,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10))),
                      child: Text(
                        'Bilder Credits',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      )),
                  onTap: () {
                    _navigationService.navigateTo(PictureCreditsViewRoute);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
