import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({
    Key? key,
    required this.loadingMessage,
  }) : super(key: key);
  final String loadingMessage;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .6,
      child: AlertDialog(
        title: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(
              width: 16,
            ),
            Flexible(child: Text(loadingMessage)),
          ],
        ),
      ),
    );
  }
}
