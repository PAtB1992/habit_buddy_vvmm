import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/ui/components/message_bubble.dart';
import 'package:habitbuddyvvmm/ui/views/profile_sub_view.dart';
import 'package:stacked/stacked.dart';
import 'package:habitbuddyvvmm/viewmodels/buddy_view_model.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';

class BuddyView extends StatelessWidget {
  final controller = PageController(
    initialPage: 0,
  );
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                height: 350,
                child: PageView(
                  controller: controller,
                  children: <Widget>[
                    ProfileSubView(),
                  ],
                ),
              ),
              Expanded(
                child: model.messages != null
//                TODO List throws error if smaller than 3
                    ? ListView.builder(
                        itemCount: 3,
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
    );
  }
}
