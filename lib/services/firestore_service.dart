import 'dart:async';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:habitbuddyvvmm/models/chart_data.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/models/milestone.dart';
import 'package:habitbuddyvvmm/models/user.dart';
import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/models/habit.dart';

import '../locator.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _messagesCollectionReference =
      Firestore.instance.collection('messages');
  final CollectionReference _habitsCollectionReference =
      Firestore.instance.collection('habits');
  final StreamController<List<Message>> _messagesController =
      StreamController<List<Message>>.broadcast();
  final StreamController<List<Milestone>> _milestonesController =
      StreamController<List<Milestone>>.broadcast();
  final HabitBuddy _habitBuddy = locator<HabitBuddy>();

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

  Stream listenToMessagesRealTime(User currentUser) {
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
        List<Message> filteredMessages = [];
        for (Message message in messages) {
          if (message.userID == currentUser.id) {
            filteredMessages.add(message);
          }

          if (message.receiverID == currentUser.id) {
            filteredMessages.add(message);
          }
        }
        if (filteredMessages.length > 4) {
          int n = filteredMessages.length - 4;
          filteredMessages.removeRange(4, 4 + n);
        }
        // Add the messages onto the controller
        _messagesController.add(filteredMessages);
      }
    });
    //local stream
    return _messagesController.stream;
  }

  Stream listenToBuddyRealTime() {
    _usersCollectionReference
        .document(_habitBuddy.myHabitBuddy.id)
        .collection('milestones')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((milestonesSnapshot) {
      if (milestonesSnapshot.documents.isNotEmpty) {
        var milestones = milestonesSnapshot.documents
            .map((snapshot) =>
                Milestone.fromMap(snapshot.data, snapshot.documentID))
            .toList();
        _milestonesController.add(milestones);
      }
    });
    return _milestonesController.stream;
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

  Future getChartData(String userId) async {
    var sevenDays = DateTime.now().subtract(Duration(days: 7));
    var chartDataSnapshot = await _usersCollectionReference
        .document(userId)
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

  Future hasHabitBuddy(User user) async {
    var hasBuddy = await _usersCollectionReference.document(user.id).get();
    return User.fromData(hasBuddy.data).hasHabitBuddy;
  }

  Future addHabitBuddy(User user) async {
    var tempData = await _usersCollectionReference
        .document(user.id)
        .collection('habit_buddy')
        .document('habit_buddy')
        .get();
    return HabitBuddy.fromData(tempData.data);
  }

  Future updateBuddyTimestamp(HabitBuddy habitBuddy, String userID) async {
    try {
      await _usersCollectionReference
          .document(userID)
          .collection('habit_buddy')
          .document('habit_buddy')
          .updateData(habitBuddy.toMap());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }
      return e.toString();
    }
  }
}
