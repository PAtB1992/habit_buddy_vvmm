import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/models/message.dart';
import 'package:habitbuddyvvmm/ui/components/reusable_card.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_view_model.dart';
import 'package:stacked/_viewmodel_builder.dart';

// ignore: must_be_immutable
class ProfileSubView extends StatefulWidget {
  HabitBuddy habitBuddy;
  Message firstMessage;
  ProfileSubView({Key key, this.habitBuddy, this.firstMessage})
      : super(key: key);

  @override
  _ProfileSubViewState createState() => _ProfileSubViewState();
}

class _ProfileSubViewState extends State<ProfileSubView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuddyViewModel>.reactive(
      viewModelBuilder: () => BuddyViewModel(),
      onModelReady: (model) => model.reduceBuddyLevel(widget.firstMessage),
      disposeViewModel: true,
      builder: (context, model, child) => Container(
        child: Stack(
          children: <Widget>[
            ReusableCard(
              color1: Color(0xFF303f9f),
              color2: Color(0xFF3f51b5),
              cardChild: Container(
                padding: EdgeInsets.all(9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: accentColor,
                          child: Image.asset('images/bot2.png'),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        Text(
                          model.habitBuddy.myHabitBuddy.username,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                    Divider(
                      color: accentColor,
                      thickness: 0.8,
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(child: model.showHabitBuddyMood()),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Flexible(
                      child: GridView.count(
                        childAspectRatio: 2,
                        physics: NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 3,
                        crossAxisCount: 3,
                        shrinkWrap: true,
                        children: <Widget>[
                          ReusableCard(
                            boxShadow: false,
                            center: true,
//                          height: 45,
                            color1: secondaryBlue,
                            color2: primaryBlue,
                            cardChild: Text(
                              'Hallo!',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPress: () {
                              model.sendMessage(
                                  text: 'Hallo!',
                                  receiverID: model.habitBuddy.myHabitBuddy.id);
                            },
                          ),
                          ReusableCard(
                            boxShadow: false,
                            center: true,
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
                                  receiverID: model.habitBuddy.myHabitBuddy.id);
                            },
                          ),
                          ReusableCard(
                            boxShadow: false,
                            center: true,
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
                                  receiverID: model.habitBuddy.myHabitBuddy.id);
                            },
                          ),
                          ReusableCard(
                            boxShadow: false,
                            center: true,
                            height: 45,
                            color1: secondaryBlue,
                            color2: primaryBlue,
                            cardChild: Wrap(
                              children: <Widget>[
                                Text(
                                  'Alles gut bei mir.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            onPress: () {
                              model.sendMessage(
                                  text: 'Alles gut bei mir.',
                                  receiverID: model.habitBuddy.myHabitBuddy.id);
                            },
                          ),
                          ReusableCard(
                            boxShadow: false,
                            center: true,
                            height: 45,
                            color1: secondaryBlue,
                            color2: primaryBlue,
                            cardChild: Text(
                              'Keine Lust mehr..',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPress: () {
                              model.sendMessage(
                                  text: 'Keine Lust mehr',
                                  receiverID: model.habitBuddy.myHabitBuddy.id);
                            },
                          ),
                          ReusableCard(
                            boxShadow: false,
                            center: true,
                            height: 45,
                            color1: secondaryBlue,
                            color2: primaryBlue,
                            cardChild: Text(
                              'Gut gemacht!',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                            onPress: () {
                              model.sendMessage(
                                  text: 'Gut gemacht!',
                                  receiverID: model.habitBuddy.myHabitBuddy.id);
                            },
                          ),
                        ],
                      ),
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
                        model.buddyLevel(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
              ),
              right: 10,
              top: 160,
            ),
          ],
        ),
      ),
    );
  }
}
