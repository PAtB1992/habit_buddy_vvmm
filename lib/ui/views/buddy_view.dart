import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/message_item.dart';
import 'package:habitbuddyvvmm/ui/components/input_field.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:provider_architecture/viewmodel_provider.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_view_model.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class BuddyView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<BuddyViewModel>.withConsumer(
      viewModel: BuddyViewModel(),
      onModelReady: (model) => model.listenToMessages(),
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Text(
                    'Dein Habit Buddy',
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  CircleAvatar(
                    child: Hero(
                      tag: 'icon',
                      child: Icon(
                        Icons.child_care,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                    backgroundColor: accentColor,
                    radius: 25.0,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                ],
              ),
              Text(
                'Send Message',
                style: TextStyle(fontSize: 26),
              ),
              ReusableCard(
                color1: primaryBlue,
                color2: secondaryBlue,
                cardChild: Text('Lalelulilo'),
                onPress: () {
                  model.sendMessage(
                      text: 'lalelulilo', receiverID: 'The Patriots');
                },
              ),
              ReusableCard(
                color1: primaryBlue,
                color2: secondaryBlue,
                cardChild: Text('Lalelulilo1'),
                onPress: () {
                  model.sendMessage(
                      text: 'lalelulilo1', receiverID: 'The Patriots');
                },
              ),
              ReusableCard(
                color1: primaryBlue,
                color2: secondaryBlue,
                cardChild: Text('Lalelulilo2'),
                onPress: () {
                  model.sendMessage(
                      text: 'lalelulilo2', receiverID: 'The Patriots');
                },
              ),
              Expanded(
                child: model.messages != null
                    ? ListView.builder(
                        itemCount: 3,
                        itemBuilder: (context, index) => MessageBubble(
                          message: model.messages[index],
                          isMe: model.isMe(index: index) ? true : false,
                        ),
                      )
                    : Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
