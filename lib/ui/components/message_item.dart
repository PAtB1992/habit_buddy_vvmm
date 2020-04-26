import 'package:habitbuddyvvmm/models/message.dart';
import 'package:flutter/material.dart';

//class MessageItem extends StatelessWidget {
//  final Message message;
//  final Function onDeleteItem;
//  const MessageItem({
//    Key key,
//    this.message,
//    this.onDeleteItem,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      height: 60,
//      margin: const EdgeInsets.only(top: 20),
//      alignment: Alignment.center,
//      child: Row(
//        children: <Widget>[
//          Expanded(
//              child: Padding(
//            padding: const EdgeInsets.only(left: 15.0),
//            child: Text(message.text),
//          )),
//          IconButton(
//            icon: Icon(Icons.close),
//            onPressed: () {
//              if (onDeleteItem != null) {
//                onDeleteItem();
//              }
//            },
//          ),
//        ],
//      ),
//      decoration: BoxDecoration(
//          color: Colors.white,
//          borderRadius: BorderRadius.circular(5),
//          boxShadow: [
//            BoxShadow(blurRadius: 8, color: Colors.grey[200], spreadRadius: 3)
//          ]),
//    );
//  }
//}

class MessageBubble extends StatelessWidget {
  MessageBubble({this.message, this.isMe = true});

  final bool isMe;
  final Message message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: <Widget>[
          Material(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0))
                : BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Color(0xFF3F51B5) : Color(0xFFFCFBFB),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                message.text,
                style: TextStyle(
                  color: isMe ? Color(0xFFFFFFFF) : Color(0xFF757575),
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
