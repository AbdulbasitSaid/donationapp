import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';

class EmailField extends StatefulWidget {
  final TextEditingController emailController;
  final GlobalKey<FormState> formKey;
  final String? email;

  const EmailField({
    Key? key,
    required this.emailController,
    required this.formKey, this.email,
  }) : super(key: key);

  @override
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  @override
  Widget build(BuildContext context) {


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseLabelText(
          text: 'Email address',
        ),
        const SizedBox(
          height: 8,
        ),
        Focus(
          onFocusChange: (value) {
            if (!value) {
              widget.formKey.currentState!.validate();
            }
          },
          child: TextFormField(
            controller: widget.emailController,

            keyboardType: TextInputType.emailAddress,
            // initialValue: email,

            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Please Enter a valid email Address'),
            ]),
            decoration: const InputDecoration(
              hintText: 'Email address',
              prefixIcon: Icon(Icons.person_outline_outlined),
            ),
          ),
        ),
      ],
    );
  }
}
