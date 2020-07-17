class User {
  final String id;
  final String email;
  final String username;
  final bool hasHabitBuddy;

  User({this.id, this.email, this.username, this.hasHabitBuddy});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        email = data['email'],
        username = data['username'],
        hasHabitBuddy = data['has_habit_buddy'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'has_habit_buddy': hasHabitBuddy,
    };
  }
}
