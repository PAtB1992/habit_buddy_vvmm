import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/texts.dart';

// AppBar Variables
AppBar appBarStyle(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return AppBar(
      title: AutoSizeText.rich(
        TextSpan(
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
        maxLines: 1,
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'besser-organisieren') {
    return AppBar(
      title: AutoSizeText.rich(
        TextSpan(
          text: 'Besser ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(
                text: 'Organisieren ', style: TextStyle(color: accentColor)),
          ],
        ),
        maxLines: 1,
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'fähigkeiten-lernen') {
    return AppBar(
      title: AutoSizeText.rich(
        TextSpan(
          text: 'Fähigkeit ',
          style: TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Verbessern ', style: TextStyle(color: accentColor)),
          ],
        ),
        maxLines: 1,
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'sich-mehr-bewegen') {
    return AppBar(
      title: AutoSizeText.rich(
        TextSpan(
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
        maxLines: 1,
      ),
      backgroundColor: primaryBlue,
    );
  }
  if (habitName == 'mehr-wasser-trinken') {
    return AppBar(
      title: AutoSizeText.rich(
        TextSpan(
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
        maxLines: 1,
      ),
      backgroundColor: primaryBlue,
    );
  } else {
    return AppBar(
      title: AutoSizeText.rich(
        TextSpan(
          text: 'Am ',
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold),
          children: <TextSpan>[
            TextSpan(text: 'Charakter ', style: TextStyle(color: accentColor)),
            TextSpan(
              text: 'arbeiten',
            ),
          ],
        ),
        maxLines: 1,
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
  if (habitName == 'besser-organisieren') {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.asset(
        'images/orgaa.jpg',
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
    return AutoSizeText(gesuenderErnaehren,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'besser-organisieren') {
    return AutoSizeText(besserOrganisieren,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'fähigkeiten-lernen') {
    return AutoSizeText(faehigkeitVerbessern,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'sich-mehr-bewegen') {
    return AutoSizeText(mehrBewegen,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
  if (habitName == 'mehr-wasser-trinken') {
    return AutoSizeText(mehrWasserTrinken,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  } else {
    return AutoSizeText(amCharakterArbeiten,
        textAlign: TextAlign.justify,
        style: TextStyle(color: Colors.white, fontSize: 17));
  }
}

IconData habitIcon(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return Icons.fastfood;
  }
  if (habitName == 'besser-organisieren') {
    return Icons.access_time;
  }
  if (habitName == 'fähigkeiten-lernen') {
    return Icons.palette;
  }
  if (habitName == 'sich-mehr-bewegen') {
    return Icons.directions_run;
  }
  if (habitName == 'mehr-wasser-trinken') {
    return Icons.local_drink;
  } else {
    return CupertinoIcons.profile_circled;
  }
}

String dynamicCategory(String habitName) {
  if (habitName == 'gesünder-ernähren') {
    return 'Gesünder ernähren';
  }
  if (habitName == 'besser-organisieren') {
    return 'Besser organisieren';
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
    return 'Am Charakter arbeiten';
  }
}

IconData reminderIcon(String reminderType) {
  if (reminderType == 'no reminder') {
    return Icons.alarm_off;
  }
  if (reminderType == 'daily' || reminderType == 'weekly') {
    return Icons.alarm_on;
  } else {
    return Icons.alarm_off;
  }
}
