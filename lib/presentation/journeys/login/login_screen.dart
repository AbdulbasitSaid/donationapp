import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/login/login_form.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_1_headline.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
        childWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Level1Headline(text: 'Sign in'),
              SizedBox(
                height: 16,
              ),
              Text('Enter your login details to continue.'),
              SizedBox(
                height: 8,
              ),
              LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
