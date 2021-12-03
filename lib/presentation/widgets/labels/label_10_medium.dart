import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

class Label10Medium extends StatelessWidget {
  const Label10Medium({Key? key, required this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    
    return Text(
      text,
      style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: AppColor.darkSecondaryGreen,
          fontSize: 10,
          fontWeight: FontWeight.w500),
    );
  }
}
