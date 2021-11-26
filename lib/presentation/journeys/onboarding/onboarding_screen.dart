import 'package:flutter/material.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AppBackgroundWidget(
          childWidget: Column(),
        ),
      ),
    );
  }
}
