class HabitBuddy {
  final String username;
  final String id;
  var timestampReduced;
  var timestampIncreased;
  var lastSet;
  HabitBuddy myHabitBuddy;
  int buddyLevel;
  List motivationData;

  HabitBuddy(
      {this.username,
      this.id,
      this.buddyLevel,
      this.motivationData,
      this.timestampReduced,
      this.timestampIncreased,
      this.lastSet});

  HabitBuddy.fromData(Map<String, dynamic> data)
      : id = data['id'],
        username = data['username'],
        buddyLevel = data['buddyLevel'],
        timestampReduced = data['timestampReduced'],
        timestampIncreased = data['timestampIncreased'],
        lastSet = data['lastSet'],
        motivationData = data['motivationData'];

  saveHabitBuddy(HabitBuddy habitBuddy) {
    myHabitBuddy = habitBuddy;
  }

  Map<String, dynamic> toMap() {
    return {
      'timestampReduced': timestampReduced,
      'timestampIncreased': timestampIncreased,
      'buddyLevel': buddyLevel,
      'lastSet': lastSet,
    };
  }
}
