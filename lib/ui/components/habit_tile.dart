import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

import 'dynamic_components.dart';

class HabitTile extends StatelessWidget {
  final String customName;
  final String name;
  final Function onPress;
  final Function onLongPress;
  final int repetitions;
  final IconData habitIcon;
  final String description;
  final Widget buddyEvaluation;
  final bool hasHabitBuddy;
  final int reminderID;
  final bool wasDone;
  final String reminderType;
  final automaticity;

  HabitTile({
    this.customName,
    this.name,
    this.onPress,
    this.repetitions,
    this.habitIcon,
    this.description,
    this.onLongPress,
    this.buddyEvaluation,
    this.hasHabitBuddy,
    this.reminderID,
    this.reminderType,
    this.wasDone,
    this.automaticity,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onLongPress: onLongPress,
      child: Container(
        height: 170,
        padding: EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: AutoSizeText(
                        customName,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Rubrik: $name',
                          style: TextStyle(
                            color: Colors.white,
                          )),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        habitIcon,
                        size: 14,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 200,
                    child: Divider(
                      thickness: 0.8,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Icon(
                reminderIcon(reminderType),
                color: Colors.white,
              ),
            ]),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.fitness_center,
                              color: Colors.white,
                              size: 40,
                            ),
                            AutoSizeText(
                              '${(automaticity)}%',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      wasDone
                          ? Icon(
                              CupertinoIcons.circle_filled,
                              color: test3,
                              size: 53,
                            )
                          : Icon(
                              CupertinoIcons.circle,
                              color: accentColor,
                              size: 53,
                            ),
//                            Text(
//                              '$repetitions',
//                              style:
//                                  TextStyle(color: Colors.white, fontSize: 45),
//                            ),
                      Flexible(
                        child: wasDone
                            ? AutoSizeText(
                                'Einmal erledigt',
                                style: TextStyle(color: Colors.white),
                                maxFontSize: 12,
                                maxLines: 1,
                              )
                            : AutoSizeText(
                                'Nicht erledigt',
                                style: TextStyle(color: Colors.white),
                                maxFontSize: 12,
                                maxLines: 1,
                              ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 3),
                Expanded(
                  child: buddyEvaluation,
                ),
              ],
            )
          ],
        ),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12, blurRadius: 3, offset: Offset(0, 2))
          ],
          gradient: LinearGradient(
              colors: [primaryBlue, secondaryBlue],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
