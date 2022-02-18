import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';

class EmailField extends StatelessWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  const EmailField({
    Key? key,
    required this.emailController,
    required this.formKey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseLabelText(text: 'Email address'),
        const SizedBox(
          height: 8,
        ),
        TextFormField(
          controller: emailController,
          onEditingComplete: () {
            formKey.currentState!.validate();
          },
          validator: MultiValidator([
            RequiredValidator(errorText: 'Email is required'),
            EmailValidator(errorText: 'Please Enter a valid email Address'),
          ]),
          decoration: const InputDecoration(
            hintText: 'Email address',
            prefixIcon: Icon(Icons.person_outline_outlined),
          ),
        ),
      ],
    );
  }
}
