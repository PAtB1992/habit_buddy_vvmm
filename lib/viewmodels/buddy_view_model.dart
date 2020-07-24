import 'package:habitbuddyvvmm/models/habit_buddy_info.dart';
import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';

class BuddyViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List chartItems = [];
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  void listenToMessages(HabitBuddyInfo habitBuddyInfo) {
    setBusy(true);
    _firestoreService
        .listenToMessagesRealTime(currentUser)
        .listen((messagesData) {
      List<Message> updatedMessages = messagesData;
      if (updatedMessages != null && updatedMessages.length > 0) {
        _messages = updatedMessages;
        if (habitBuddyInfo.buddyLevel < 3) {
          habitBuddyInfo.buddyLevel += 1;
        }
        notifyListeners();
      }
      setBusy(false);
    });
  }

//  updatedMessages.forEach((message) {
//  if (message.userID != currentUser.id) {
//  if (message.receiverID != currentUser.id) {
//  updatedMessages.remove(message);
//  }
//  }
//  });

  giveFirstMessage() {
    if (busy != true) {
      Message firstMessage = _messages[0];
      return firstMessage;
    }
  }

  bool isMe({int index}) {
    return currentUser.id == messages[index].userID;
  }
}
