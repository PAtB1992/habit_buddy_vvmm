import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/constants/route_names.dart';
import 'package:habitbuddyvvmm/services/navigation_service.dart';
import 'package:habitbuddyvvmm/ui/components/rounded_button.dart';
import 'package:habitbuddyvvmm/viewmodels/start_view_model.dart';
import 'package:provider_architecture/provider_architecture.dart';
import 'package:habitbuddyvvmm/locator.dart';

class StartView extends StatelessWidget {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return ViewModelProvider<StartViewModel>.withConsumer(
      viewModel: StartViewModel(),
      onModelReady: (model) => model.handleStartUpLogic(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: 'icon',
                    child: Container(
                      child: Icon(
                        Icons.child_care,
                        size: 45.0,
                        color: accentColor,
                      ),
                      height: 60.0,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Habit Buddy',
                    style: TextStyle(
                      color: primaryText,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: primaryBlue,
                onPressed: () {
                  _navigationService.navigateTo(LoginViewRoute);
                },
              ),
              RoundedButton(
                title: 'Register',
                colour: primaryGrey,
                onPressed: () {
                  _navigationService.navigateTo(RegistrationViewRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
