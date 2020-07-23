import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Milestone {
  final int repetitions;
  final String habitName;
  final timestamp;
  final int evaluation;
  final String userId;

  Milestone({
    @required this.repetitions,
    @required this.habitName,
    @required this.timestamp,
    @required this.evaluation,
    @required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'repetitions': repetitions,
      'habitName': habitName,
      'timestamp': timestamp,
      'evaluation': evaluation,
      'userId': userId,
    };
  }

  static Milestone fromMap(
    Map<String, dynamic> map,
    String documentID,
  ) {
    if (map == null) return null;

    return Milestone(
      habitName: map['habitName'],
      repetitions: map['repetitions'],
      timestamp: map['timestamp'],
      evaluation: map['evaluation'],
      userId: map['userId'],
    );
  }
}
