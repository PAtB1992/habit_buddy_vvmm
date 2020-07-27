import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';

class BuddyViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  List chartItems = [];
  List<Message> _messages = [];
  List<Message> get messages => _messages;

  void listenToMessages() {
    setBusy(true);
    _firestoreService
        .listenToMessagesRealTime(currentUser)
        .listen((messagesData) {
      List<Message> updatedMessages = messagesData;
      if (updatedMessages != null && updatedMessages.length > 0) {
        _messages = updatedMessages;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  giveFirstMessage() {
    if (busy != true) {
      if (_messages.length > 0) {
        Message firstMessage = _messages.last;
        return firstMessage;
      }
    }
  }

  bool isMe({int index}) {
    return currentUser.id == messages[index].userID;
  }
}
