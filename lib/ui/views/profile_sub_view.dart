import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habitbuddyvvmm/models/habit_buddy_info.dart';
import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/viewmodels/profile_sub_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';

// ignore: must_be_immutable
class ProfileSubView extends StatelessWidget {
  final HabitBuddyInfo habitBuddyInfo;
  Message firstMessage;
  ProfileSubView({Key key, this.habitBuddyInfo, this.firstMessage})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileSubViewModel>.reactive(
      viewModelBuilder: () => ProfileSubViewModel(),
      onModelReady: (model) =>
          model.reduceBuddyLevel(firstMessage, habitBuddyInfo),
      disposeViewModel: true,
      builder: (context, model, child) => Container(
        child: ReusableCard(
          color1: Color(0xFF303f9f),
          color2: Color(0xFF3f51b5),
          cardChild: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: accentColor,
                    child: Image.asset('images/bot2.png'),
                  ),
                  SizedBox(
                    width: 25,
                  ),
                  Text(
                    habitBuddyInfo.habitBuddy.username,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
              Divider(
                color: Color(0xFFBDBDBD),
              ),
              Row(
                children: <Widget>[
                  Flexible(child: model.showHabitBuddyMood(habitBuddyInfo)),
                  //TODO Tooltip designen?
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 6,
                spacing: 6,
                children: <Widget>[
                  ReusableCard(
                    height: 45,
                    color1: secondaryBlue,
                    color2: primaryBlue,
                    cardChild: Text(
                      'Gut gemacht!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {
                      model.sendMessage(
                          text: 'Gut gemacht!',
                          receiverID: habitBuddyInfo.habitBuddy.id);
                    },
                  ),
                  ReusableCard(
                    height: 45,
                    color1: secondaryBlue,
                    color2: primaryBlue,
                    cardChild: Text(
                      'Bleib dran!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {
                      model.sendMessage(
                          text: 'Bleib dran!',
                          receiverID: habitBuddyInfo.habitBuddy.id);
                    },
                  ),
                  ReusableCard(
                    height: 45,
                    color1: secondaryBlue,
                    color2: primaryBlue,
                    cardChild: Text(
                      'Alles klar?',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {
                      model.sendMessage(
                          text: 'Alles klar?',
                          receiverID: habitBuddyInfo.habitBuddy.id);
                    },
                  ),
                  ReusableCard(
                    height: 45,
                    color1: secondaryBlue,
                    color2: primaryBlue,
                    cardChild: Text(
                      'Alles gut bei mir.',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {
                      model.sendMessage(
                          text: 'Alles gut bei mir.!',
                          receiverID: habitBuddyInfo.habitBuddy.id);
                    },
                  ),
                  ReusableCard(
                    height: 45,
                    color1: secondaryBlue,
                    color2: primaryBlue,
                    cardChild: Text(
                      'Gut gemacht!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {
                      model.sendMessage(
                          text: 'Gut gemacht!',
                          receiverID: habitBuddyInfo.habitBuddy.id);
                    },
                  ),
                  ReusableCard(
                    height: 45,
                    color1: secondaryBlue,
                    color2: primaryBlue,
                    cardChild: Text(
                      'Gut gemacht!',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPress: () {
                      model.sendMessage(
                          text: 'Gut gemacht!',
                          receiverID: habitBuddyInfo.habitBuddy.id);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Buddy Level:',
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  model.buddyLevel(habitBuddyInfo),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
