import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitbuddyvvmm/models/user.dart';
import 'package:habitbuddyvvmm/models/message.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _messagesCollectionReference =
      Firestore.instance.collection('messages');
  final StreamController<List<Message>> _messagesController =
      StreamController<List<Message>>.broadcast();

  Future createUser(User user) async {
    try {
      await _usersCollectionReference.document(user.id).setData(user.toJson());
    } catch (e) {
      return e.message;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _usersCollectionReference.document(uid).get();
      return User.fromData(userData.data);
    } catch (e) {
      return e.message;
    }
  }

  Future sendMessage(Message message) async {
    try {
      await _messagesCollectionReference.add(message.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Stream listenToMessagesRealTime() {
    // Register the handler for when the posts data changes
    _messagesCollectionReference
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((messagesSnapshot) {
      if (messagesSnapshot.documents.isNotEmpty) {
        var messages = messagesSnapshot.documents
            .map((snapshot) =>
                Message.fromMap(snapshot.data, snapshot.documentID))
            .where((mappedItem) => mappedItem.text != null)
            .toList();
        // Add the posts onto the controller
        _messagesController.add(messages);
      }
    });

    return _messagesController.stream;
  }
}
