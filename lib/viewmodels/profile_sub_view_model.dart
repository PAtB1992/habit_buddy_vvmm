import 'package:flutter/cupertino.dart';
import 'package:habitbuddyvvmm/viewmodels/base_model.dart';
import 'package:habitbuddyvvmm/locator.dart';
import 'package:habitbuddyvvmm/services/firestore_service.dart';
import 'package:habitbuddyvvmm/services/dialog_service.dart';
import 'package:habitbuddyvvmm/models/message.dart';

class ProfileSubViewModel extends BaseModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final DialogService _dialogService = locator<DialogService>();

  Future sendMessage(
      {@required String text, @required String receiverID}) async {
    setBusy(true);
    var result = await _firestoreService.sendMessage(Message(
      text: text,
      userID: currentUser.id,
      receiverID: receiverID,
      timestamp: DateTime.now(),
    ));
    setBusy(false);

    if (result is String) {
      await _dialogService.showDialog(
        title: 'Could not sent Post',
        description: result,
      );
//    } else {
//      await _dialogService.showDialog(
//        title: 'Message successfully sent',
//        description: 'Your message has been sent',
//      );
    }
  }
}
