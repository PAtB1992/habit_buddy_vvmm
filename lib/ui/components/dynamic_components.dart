import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

// AppBar Variables
AppBar appBarStyle(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: 'Gesünder ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Ernähren ', style: TextStyle(color: accentColor)),
//            TextSpan(
//              text: 'Leben',
//            ),
          ],
        ),
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'weniger-fleisch-essen') {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: 'Weniger ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Fleisch ', style: TextStyle(color: accentColor)),
            TextSpan(
              text: 'Essen',
            ),
          ],
        ),
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'fähigkeiten-lernen') {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: 'Fähigkeit ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Verbessern ', style: TextStyle(color: accentColor)),
//            TextSpan(
//              text: 'Verbessern',
//            ),
          ],
        ),
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'sich-mehr-bewegen') {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: 'Mehr ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Bewegung ', style: TextStyle(color: accentColor)),
//            TextSpan(
//              text: 'Essen',
//            ),
          ],
        ),
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'mehr-wasser-trinken') {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: 'Mehr ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Wasser ', style: TextStyle(color: accentColor)),
            TextSpan(
              text: 'Trinken',
            ),
          ],
        ),
      ),
      backgroundColor: primaryBlue,
    );
  } else {
    return AppBar(
      title: RichText(
        text: TextSpan(
          text: 'Weniger ',
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Abgelenkt ', style: TextStyle(color: accentColor)),
            TextSpan(
              text: 'Sein',
            ),
          ],
        ),
      ),
      backgroundColor: primaryBlue,
    );
  }
}

// AddHabit Images
Widget dynamicImage(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/envio-53.jpg',
        fit: BoxFit.fitWidth,
      ),
    );
  }
  if (habitName == 'weniger-fleisch-essen') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/envio-55.jpg',
        fit: BoxFit.fitWidth,
      ),
    );
  }
  if (habitName == 'fähigkeiten-lernen') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/piranha2-01.jpg',
        fit: BoxFit.fitWidth,
      ),
    );
  }
  if (habitName == 'sich-mehr-bewegen') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/training-girl.jpg',
//        fit: BoxFit.fitWidth,
      ),
    );
  }
  if (habitName == 'mehr-wasser-trinken') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/mjo5_ltxu_180316.jpg',
        fit: BoxFit.fitWidth,
      ),
    );
  } else {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/BOOKWORM 01.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

// AddHabit Descriptions
Widget dynamicDescription(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return Text(gesuenderErnaehren,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'weniger-fleisch-essen') {
    return Text(wenigerFleischEssen,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'fähigkeiten-lernen') {
    return Text(faehigkeitVerbessern,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'sich-mehr-bewegen') {
    return Text(mehrBewegen,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'mehr-wasser-trinken') {
    return Text(mehrWasserTrinken,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  } else {
    return Text(konzentrationSteigern,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
}

IconData habitIcon(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return Icons.fastfood;
  }
  if (habitName == 'weniger-fleisch-essen') {
    return Icons.local_dining;
  }
  if (habitName == 'fähigkeiten-lernen') {
    return Icons.palette;
  }
  if (habitName == 'sich-mehr-bewegen') {
    return Icons.directions_run;
  }
  if (habitName == 'mehr-wasser-trinken') {
    return Icons.invert_colors;
  } else {
    return Icons.school;
  }
}

String dynamicCategory(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return 'Gesünder ernähren';
  }
  if (habitName == 'weniger-fleisch-essen') {
    return 'Weniger Fleisch essen';
  }
  if (habitName == 'fähigkeiten-lernen') {
    return 'Fähigkeit verbessern';
  }
  if (habitName == 'sich-mehr-bewegen') {
    return 'Mehr Bewegung';
  }
  if (habitName == 'mehr-wasser-trinken') {
    return 'Mehr wasser trinken';
  } else {
    return 'Konzentration steigern';
  }
}
