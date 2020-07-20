import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String name;
  final Function onPress;
  final Function onLongPress;
  final int repetitions;
  final Icon habitIcon;
  final String description;
  final String buddyEvaluation;

  HabitTile(
      {this.name,
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
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
                SizedBox(
                  width: 5,
                ),
                habitIcon,
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Dein Meilenstein: ' + description,
                    style: TextStyle(color: Colors.white)),
                Text(
                  'Gesamte Wiederholungen: $repetitions',
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  buddyEvaluation,
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
        margin: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
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
