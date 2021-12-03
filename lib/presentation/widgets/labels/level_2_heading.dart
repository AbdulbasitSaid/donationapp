import 'package:flutter/material.dart';

class Level2Headline extends StatelessWidget {
  const Level2Headline({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline2!
          .copyWith(fontWeight: FontWeight.w600),
    );
  }
}
