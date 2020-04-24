import 'package:flutter/foundation.dart';

class Message {
  final String text;
  final String userID;
  final String receiverID;
  final String documentID;

  Message({
    @required this.text,
    @required this.receiverID,
    @required this.userID,
    this.documentID,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userID': userID,
      'receiverID': receiverID,
    };
  }

  static Message fromMap(
    Map<String, dynamic> map,
    String documentID,
  ) {
    if (map == null) return null;

    return Message(
      text: map['title'],
      receiverID: map['receiverId'],
      userID: map['userId'],
      documentID: documentID,
    );
  }
}
