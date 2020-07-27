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

  HabitTile(
      {this.customName,
      this.name,
      this.onPress,
      this.repetitions,
      this.habitIcon,
      this.description,
      this.onLongPress,
      this.buddyEvaluation});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onLongPress: onLongPress,
      child: Container(
        height: 170,
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text(
                  customName,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Flexible(
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
                      Text('$description',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14)),
                    ],
                    mainAxisAlignment: MainAxisAlignment.start,
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '$repetitions',
                        style: TextStyle(color: Colors.white, fontSize: 45),
                      ),
                      Text('Wiederholungen',
                          style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Flexible(
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
                      Text(
                        buddyEvaluation ??
                            'Dein Buddy hat noch keinen Meilenstein absolviert.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ],
            ),
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
