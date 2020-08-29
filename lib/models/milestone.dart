import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Milestone {
  final int repetitions;
  final String habitName;
  final timestamp;
  final int evaluation;
  final int evaluation2;
  final String userId;
  final String habitId;
  final String customName;
  final String srhiQuestion;
  final String srhiQuestion2;

  Milestone({
    @required this.repetitions,
    @required this.habitName,
    @required this.timestamp,
    @required this.evaluation,
    @required this.evaluation2,
    @required this.userId,
    @required this.habitId,
    @required this.customName,
    @required this.srhiQuestion,
    @required this.srhiQuestion2,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'habitName': habitName,
      'customName': customName,
      'habitId': habitId,
      'repetitions': repetitions,
      'timestamp': timestamp,
      'evaluation': evaluation,
      'evaluation2': evaluation2,
      'srhiQuestion': srhiQuestion,
      'srhiQuestion2': srhiQuestion2,
    };
  }

  static Milestone fromMap(
    Map<String, dynamic> map,
    String documentID,
  ) {
    if (map == null) return null;

    return Milestone(
      userId: map['userId'],
      habitName: map['habitName'],
      customName: map['customName'],
      habitId: map['habitId'],
      repetitions: map['repetitions'],
      timestamp: map['timestamp'],
      evaluation: map['evaluation'],
      evaluation2: map['evaluation2'],
      srhiQuestion: map['srhiQuestion'],
      srhiQuestion2: map['srhiQuestion2'],
    );
  }
}
