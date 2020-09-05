import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

  HabitTile(
      {this.customName,
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
      this.wasDone});

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
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Flexible(
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
                    color: accentColor,
                  ),
                ),
              ],
            ),
            hasHabitBuddy
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
//                            Icon(
//                              Icons.my_location,
//                              color: Colors.white,
//                            ),
                            Icon(
                              reminderIcon(reminderType),
                              color: Colors.white,
                              size: 50,
                            ),
                            SizedBox(
                              height: 3,
                            ),
//                            Flexible(
//                              child: AutoSizeText(
//                                '$description',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 14),
//                                maxLines: 3,
//                              ),
//                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                      SizedBox(width: 3),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            wasDone
                                ? Icon(
                                    CupertinoIcons.circle_filled,
                                    color: test1,
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
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Icon(reminderIcon(reminderType),
                                color: Colors.white),
                            SizedBox(
                              height: 3,
                            ),
//                            Flexible(
//                              child: AutoSizeText(
//                                '$description',
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    color: Colors.white, fontSize: 14),
//                                maxLines: 3,
//                              ),
//                            ),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            wasDone
                                ? Icon(
                                    CupertinoIcons.circle_filled,
                                    color: test1,
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
                    ],
                  )
          ],
        ),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.grey, blurRadius: 3, offset: Offset(0, 2))
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
