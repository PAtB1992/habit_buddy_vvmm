import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class HabitTile extends StatelessWidget {
  final String customName;
  final String name;
  final Function onPress;
  final Function onLongPress;
  final int repetitions;
  final IconData habitIcon;
  final String description;
  final String buddyEvaluation;
  final bool hasHabitBuddy;

  HabitTile(
      {this.customName,
      this.name,
      this.onPress,
      this.repetitions,
      this.habitIcon,
      this.description,
      this.onLongPress,
      this.buddyEvaluation,
      this.hasHabitBuddy});

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
                            Text('Ziel: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3,
                            ),
                            Flexible(
                              child: AutoSizeText(
                                '$description',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                maxLines: 3,
                              ),
                            ),
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
                            Text(
                              '$repetitions',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 45),
                            ),
                            Flexible(
                              child: AutoSizeText(
                                'Wiederholungen',
                                style: TextStyle(color: Colors.white),
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: <Widget>[
                            Text('BuddyInfo: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 5,
                            ),
                            Flexible(
                              child: AutoSizeText(
                                buddyEvaluation ??
                                    'Dein Buddy hat noch keinen Meilenstein absolviert.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                                maxLines: 3,
                              ),
                            ),
                          ],
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
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
                            Text('Ziel: ',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3,
                            ),
                            Flexible(
                              child: AutoSizeText(
                                '$description',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                                maxLines: 3,
                              ),
                            ),
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
                            Text(
                              '$repetitions',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 45),
                            ),
                            Flexible(
                              child: AutoSizeText(
                                'Wiederholungen',
                                style: TextStyle(color: Colors.white),
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
              colors: [Color(0xFF303f9f), Color(0xFF3f51b5)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
