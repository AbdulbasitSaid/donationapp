import 'package:flutter/material.dart';

import '../loaders/primary_app_loader_widget.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    Key? key,
    required this.loadingMessage,
  }) : super(key: key);
  final String loadingMessage;
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          // child: Image.asset(AppAssest.logo),
          child: PrimaryAppLoader(),
        ),
      ),
    );
  }
}
