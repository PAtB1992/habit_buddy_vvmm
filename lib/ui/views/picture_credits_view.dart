import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';

class PictureCreditsView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bilder Credits'),
        backgroundColor: primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Alle Habit Grafiken unterliegen der Freien Lizenz von www.vecteezy.com',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://www.vecteezy.com/vector-art/375247-healthy-eating-balanced-diet-concept',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://www.vecteezy.com/vector-art/377485-healthy-eating-balanced-diet-concept',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://www.vecteezy.com/vector-art/161122-man-fishing-piranha-illustration-vector',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://www.vecteezy.com/vector-art/296795-wordcard-for-have-a-drink',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://www.vecteezy.com/vector-art/268403-guy-reading-a-book',
              textAlign: TextAlign.center,
            ),
            Text(
              'https://www.vecteezy.com/vector-art/296115-girl-doing-ab-bicycle-exercise',
              textAlign: TextAlign.center,
            ),
            FlatButton(
                child: Text('Zurück'),
                onPressed: () {
                  _navigationService.pop();
                })
          ],
        ),
      ),
    );
  }
}
