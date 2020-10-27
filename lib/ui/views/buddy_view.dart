import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/models/habit_buddy.dart';
import 'package:habitbuddyvvmm/ui/components/message_bubble.dart';
import 'package:habitbuddyvvmm/ui/views/buddy_chart_sub_view.dart';
import 'package:habitbuddyvvmm/ui/views/profile_sub_view.dart';
import 'package:stacked/stacked.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_view_model.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/models/message.dart';

class BuddyView extends StatelessWidget {
  final HabitBuddy habitBuddy;
  BuddyView({Key key, this.habitBuddy}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BuddyViewModel>.reactive(
      viewModelBuilder: () => BuddyViewModel(),
      disposeViewModel: false,
      onModelReady: (model) => model.listenToMessages(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: primaryBlue,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Dein Habit Buddy',
                style: TextStyle(
                  color: Colors.white,
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
        ),
        body: SafeArea(
          child: Scaffold(
            backgroundColor: backgroundColor,
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 350,
                  child: PageView(
                    onPageChanged: model.onPageChanged,
                    controller: model.pageViewController,
                    children: <Widget>[
                      ProfileSubView(
                        habitBuddy: habitBuddy,
                      ),
                      BuddyChartSubView(
                        habitBuddy: model.habitBuddy,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: model.messages.length != 0
                      ? ListView.builder(
                          itemCount: model.messages.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => MessageBubble(
                                message: model.messages[index],
                                isMe: model.isMe(index: index),
                              ))
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
      ),
    );
  }
}
