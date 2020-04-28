import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/habit_selection_card.dart';
import 'package:habitbuddyvvmm/viewmodels/add_habit_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class AddHabitView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddHabitViewModel>.reactive(
      viewModelBuilder: () => AddHabitViewModel(),
      builder: (context, model, child) => Scaffold(
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
                RichText(
                  text: TextSpan(
                    text: 'Verbessere ',
                    style: TextStyle(
                        fontSize: 35,
                        color: primaryText,
                        fontWeight: FontWeight.bold),
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Dein ', style: TextStyle(color: accentColor)),
                      TextSpan(
                        text: 'Leben',
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'Habits, oder zu Deutsch Gewohnheiten, sind Dinge im Alltag, die man unbewusst erledigt. Zähneputzen gehört zum Beispiel dazu. Sie helfen und blablabla weil blabla, wusstest du das schon? Blabla.. Suche Dir also eine von diesen Habits aus, welche Dein Leben bereichern würden.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: primaryText,
                  ),
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
                        color: fourthrateBlue,
                        onPress: () {},
                        habitIcon: Icons.invert_colors,
                        cardText: 'Ich möchte mehr Wasser trinken.',
                      ),
                      HabitSelectionCard(
                        color: thirdrateBlue,
                        habitIcon: Icons.favorite_border,
                        cardText: 'Ich möchte mich gesünder ernähren.',
                      ),
                      HabitSelectionCard(
                        color: secondaryBlue,
                        habitIcon: Icons.child_friendly,
                        cardText: 'Ich möchte weniger Fleisch essen.',
                      ),
                      HabitSelectionCard(
                        color: primaryBlue,
                        habitIcon: Icons.school,
                        cardText: 'Ich möchte diese Masterarbeit beenden.',
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
