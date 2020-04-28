import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class Message {
  final String text;
  final String userID;
  final String receiverID;
  final String documentID;
  final timestamp;

  Message({
    @required this.text,
    @required this.receiverID,
    @required this.userID,
    this.documentID,
    this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userID': userID,
      'receiverID': receiverID,
      'timestamp': timestamp,
    };
  }

  static Message fromMap(
    Map<String, dynamic> map,
    String documentID,
  ) {
    if (map == null) return null;

    return Message(
      text: map['text'],
      receiverID: map['receiverID'],
      userID: map['userID'],
      documentID: documentID,
    );
  }
}
