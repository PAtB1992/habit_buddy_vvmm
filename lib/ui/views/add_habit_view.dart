import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/habit_selection_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

class AddHabitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddHabitViewModel>.reactive(
      viewModelBuilder: () => AddHabitViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: RichText(
            text: TextSpan(
              text: 'Verbessere ',
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(text: 'Dein ', style: TextStyle(color: accentColor)),
                TextSpan(
                  text: 'Leben',
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
                    fontSize: 20.0,
                    color: primaryText,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Flexible(
                  child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[
                      HabitSelectionCard(
                        color: primaryBlue,
                        onPress: () {
                          model.navigateToReflectionView(
                            "gesünder-ernähren",
                          );
                        },
                        habitIcon: Icons.fastfood,
                        cardText: 'Ich möchte mich gesünder ernähren.',
                      ),
                      HabitSelectionCard(
                        color: primaryBlue,
                        onPress: () {
                          model.navigateToReflectionView(
                              "weniger-fleisch-essen");
                        },
                        habitIcon: Icons.local_dining,
                        cardText: 'Ich möchte weniger Fleisch essen.',
                      ),
                      HabitSelectionCard(
                        color: thirdrateBlue,
                        onPress: () {
                          model.navigateToReflectionView(
                            "fähigkeiten-lernen",
                          );
                        },
                        habitIcon: Icons.palette,
                        cardText:
                            'Ich möchte eine bestimmte Fähigkeit verbessern.',
                      ),
                      HabitSelectionCard(
                        color: thirdrateBlue,
                        onPress: () {
                          model.navigateToReflectionView("sich-mehr-bewegen");
                        },
                        habitIcon: Icons.directions_run,
                        cardText: 'Ich möchte mich mehr bewegen.',
                      ),
                      HabitSelectionCard(
                        color: fourthrateBlue,
                        onPress: () {
                          model.navigateToReflectionView("mehr-wasser-trinken");
                        },
                        habitIcon: Icons.invert_colors,
                        cardText: 'Ich möchte mehr Wasser trinken.',
                      ),
                      HabitSelectionCard(
                        color: fourthrateBlue,
                        onPress: () {
                          model.navigateToReflectionView(
                              "konzentration-steigern");
                        },
                        habitIcon: Icons.school,
                        cardText:
                            'Ich möchte beim Lernen weniger abgelenkt werden.',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
