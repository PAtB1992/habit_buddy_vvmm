import 'package:flutter/material.dart';
import 'package:habitbuddyvvmm/constants/app_colors.dart';
import 'package:habitbuddyvvmm/ui/components/busy_button.dart';
import 'package:habitbuddyvvmm/ui/components/input_field.dart';
import 'package:habitbuddyvvmm/viewmodels/login_view_model.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StatelessWidget {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'icon',
                  child: Container(
                    height: 200.0,
                    child: Icon(
                      Icons.child_care,
                      size: 90.0,
                      color: accentColor,
                    ),
                  ),
                ),
              ),
              InputField(
                placeholder: 'Email',
                controller: emailController,
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 8.0,
              ),
              InputField(
                placeholder: 'Password',
                password: true,
                controller: passwordController,
              ),
              SizedBox(
                height: 24.0,
              ),
              BusyButton(
                title: 'Log In',
                trueColor: primaryBlue,
                busy: model.busy,
                onPressed: () {
                  model.login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
