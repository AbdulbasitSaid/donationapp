import 'package:flutter/material.dart';

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    Key? key,
    required this.hintText,
    required this.validator, this.onChange,
  }) : super(key: key);
  final String hintText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      onChanged: onChange,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: hintText,
      ),
    );
  }
}
