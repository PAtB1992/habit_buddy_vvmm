import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/models/user.dart';
import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/models/habit.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _messagesCollectionReference =
      Firestore.instance.collection('messages');
  final CollectionReference _habitsCollectionReference =
      Firestore.instance.collection('habits');
  final StreamController<List<Message>> _messagesController =
      StreamController<List<Message>>.broadcast();

  CollectionReference get usersCollectionReference => _usersCollectionReference;

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

  Future<Habit> getHabitTemplate(String habitName) async {
    var habitTemplate =
        await _habitsCollectionReference.document(habitName).get();
    return Habit.fromData(habitTemplate.data);
  }

  Future saveMilestone(User user, Milestone milestone) async {
    try {
      await _usersCollectionReference
          .document(user.id)
          .collection('milestones')
          .add(milestone.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }

  Future getChartData(User user, String habitName) async {
    var sevenDays = DateTime.now().subtract(Duration(days: 7));
    var chartDataSnapshot = await _usersCollectionReference
        .document(user.id)
        .collection('milestones')
        .where('timestamp', isLessThanOrEqualTo: DateTime.now())
        .where('timestamp', isGreaterThan: sevenDays)
        .getDocuments();

    List chartDataList = [];

    for (var document in chartDataSnapshot.documents) {
      var tempChartData = ChartData.fromData(document.data);
      chartDataList.add(tempChartData);
    }
    return chartDataList;
  }

//  Future<String> getHabitBuddyId(currentUser) async {
//    var habitBuddyId = await _usersCollectionReference.document(currentUser);
//  }
// TODO write function streak()
}
