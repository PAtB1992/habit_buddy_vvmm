class HabitBuddy {
  final String username;
  final String id;
  var timestampReduced;
  var timestampIncreased;
  HabitBuddy myHabitBuddy;
  int buddyLevel;
  List evaluationData;

  HabitBuddy({
    this.username,
    this.id,
    this.buddyLevel,
    this.evaluationData,
  });

  HabitBuddy.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        buddyLevel = data['buddyLevel'],
        timestampReduced = data['timestampReduced'],
        timestampIncreased = data['timestampIncreased'],
        evaluationData = data['evaluationData'];

  saveHabitBuddy(HabitBuddy habitBuddy) {
    myHabitBuddy = habitBuddy;
  }

  Map<String, dynamic> toMap() {
    return {
      'timestampReduced': timestampReduced,
      'timestampIncreased': timestampIncreased,
      'buddyLevel': buddyLevel,
    };
  }
}
