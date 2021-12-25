import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';

class PasswordWidget extends StatefulWidget {
  const PasswordWidget(
      {Key? key, required this.passwordController, required this.formKey})
      : super(key: key);
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  @override
  _PasswordWidgetState createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<PasswordWidget> {
  bool hidePassword = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BaseLabelText(text: 'Password'),
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
            controller: widget.passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: hidePassword,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Password is required'),
              MinLengthValidator(8,
                  errorText: 'Password should be a mininum of 8 characters')
            ]),
            decoration: InputDecoration(
              hintText: TranslationConstants.password,
              prefixIcon: const Icon(Icons.lock_outline),
              suffixIcon: IconButton(
                icon: const Icon(Icons.remove_red_eye_sharp),
                onPressed: () {
                  setState(() {
                    hidePassword = !hidePassword;
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
