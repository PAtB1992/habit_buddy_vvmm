import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'habit_buddy.dart';

class HabitBuddyInfo {
  final HabitBuddy habitBuddy;
  final List evaluationData;
  int buddyLevel;

  HabitBuddyInfo({
    @required this.habitBuddy,
    @required this.evaluationData,
    this.buddyLevel = 0,
  });
}
