import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Milestone {
  final int repetitions;
  final String habitName;
  final timestamp;
  final int evaluation;

  Milestone({
    @required this.repetitions,
    @required this.habitName,
    this.timestamp,
    this.evaluation,
  });

  Map<String, dynamic> toMap() {
    return {
      'repetitions': repetitions,
      'habitName': habitName,
      'timestamp': timestamp,
      'evaluation': evaluation,
    };
  }
}
