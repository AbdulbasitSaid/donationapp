import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_theme_data.dart';

class Level1Headline extends StatelessWidget {
  const Level1Headline({
    Key? key,
    required this.text,
  }) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppThemeData.headLineSemiBold,
    );
  }
}
