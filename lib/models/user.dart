class User {
  final String id;
  final String email;
  final String username;

  User({this.id, this.email, this.username});

  User.fromData(Map<String, dynamic> data)
      : id = data['id'],
        email = data['email'],
        username = data['username'];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
    };
  }
}
