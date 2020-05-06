import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String name;
  final Function onPress;
  final int repetitions;
  final IconData goalIcon;

  HabitTile({this.name, this.onPress, this.repetitions, this.goalIcon});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Text(
              name,
              style: TextStyle(color: Colors.white, fontSize: 20.0),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(
                  'Wiederholungen: $repetitions',
                  style: TextStyle(color: Colors.white),
                ),
                Icon(
                  goalIcon,
                  color: Colors.white,
                  size: 60.0,
                ),
                Text(
                  'Statistik',
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
