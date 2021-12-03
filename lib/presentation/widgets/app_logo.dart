import 'package:flutter/material.dart';
import 'package:idonatio/common/assest.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 4 / 1,
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 16),
          child: Image.asset(AppAssest.logo)),
    );
  }
}
