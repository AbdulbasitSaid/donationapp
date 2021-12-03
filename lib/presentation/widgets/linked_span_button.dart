import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';

TextSpan linkedSpanButton(
    {required VoidCallback? onTap, required String text}) {
  return TextSpan(
      text: text,
      style: const TextStyle(
        color: AppColor.basePrimary,
        decoration: TextDecoration.underline,
      ),
      recognizer: TapGestureRecognizer()..onTap = onTap);
}
