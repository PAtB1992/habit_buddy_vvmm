import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';

class BuddyViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<Message> _messages;
  List<Message> get messages => _messages;

  void listenToMessages() {
    setBusy(true);

    _firestoreService.listenToMessagesRealTime().listen((messagesData) {
      List<Message> updatedMessages = messagesData;
      updatedMessages.forEach((message) {
        if (message.userID != currentUser.id) {
          if (message.receiverID != currentUser.id) {
            updatedMessages.remove(message);
          }
        }
      });
      if (updatedMessages != null && updatedMessages.length >= 0) {
        _messages = updatedMessages;
        notifyListeners();
      }
      setBusy(false);
    });
  }

  bool isMe({int index}) {
    return currentUser.id == messages[index].userID;
  }
}
