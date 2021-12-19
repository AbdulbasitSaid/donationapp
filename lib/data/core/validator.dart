import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Validator extends Equatable {
  const Validator._();
  static void validateField({required GlobalKey<FormState> formKey}) {
    if (formKey.currentState!.validate()) {}
  }

  @override
  List<Object?> get props => [validateField];
}
