import 'package:flutter/material.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackgroundWidget(
        childWidget: Center(
          child: Text(
            'Home',
            style: Theme.of(context).textTheme.headline1,
          ),
        ),
      ),
    );
  }
}
