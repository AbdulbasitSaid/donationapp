import 'package:flutter/material.dart';

class BaseLabelText extends StatelessWidget {
  const BaseLabelText({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
