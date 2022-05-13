import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/change_password_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/reset_password_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:line_icons/line_icons.dart';

import '../../../common/words.dart';
import '../../../data/core/validator.dart';

class EditPasswordFormWidget extends StatefulWidget {
  const EditPasswordFormWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<EditPasswordFormWidget> createState() => _EditPasswordFormWidgetState();
}

class _EditPasswordFormWidgetState extends State<EditPasswordFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _enableFormSubmit = false;
  late final TextEditingController _currentPasswordEditingController,
      _newPasswordEditingController,
      _confirmPasswordEditingController;
  bool hideCurrentPassword = true;
  bool hideNewPassword = true;
  bool hideConfirmPassword = true;

  @override
  void initState() {
    _currentPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _confirmPasswordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordEditingController.dispose();
    _newPasswordEditingController.dispose();
    _confirmPasswordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _currentPasswordEditingController,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) => Validator.validateField(formKey: _formKey),
              obscureText: hideCurrentPassword,
              validator: MultiValidator([
                RequiredValidator(errorText: 'Password is required'),
                MinLengthValidator(8,
                    errorText: 'Password should be a mininum of 8 characters')
              ]),
              decoration: InputDecoration(
                hintText: TranslationConstants.password,
                labelText: TranslationConstants.password,
                prefixIcon: const Icon(LineIcons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                      hideCurrentPassword ? LineIcons.eyeSlash : LineIcons.eye),
                  onPressed: () {
                    setState(() {
                      hideCurrentPassword = !hideCurrentPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
                'Can’t remember your current password? Use the link below to reset it.'),
            const SizedBox(
              height: 16,
            ),
            TextButton(
                onPressed: () {
                  Navigator.push(context,
                      AppRouter.routeToPage(const ResetPasswordScreen()));
                },
                child: Row(
                  children: const [
                    Icon(Icons.refresh),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Reset Password')
                  ],
                )),
            const SizedBox(
              height: 24,
            ),
            TextFormField(
              controller: _newPasswordEditingController,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) => Validator.validateField(formKey: _formKey),
              obscureText: hideNewPassword,
              validator: MultiValidator([
                RequiredValidator(errorText: 'New password is required'),
                MinLengthValidator(8,
                    errorText: 'Password should be a mininum of 8 characters')
              ]),
              decoration: InputDecoration(
                hintText: 'New password',
                labelText: 'New password',
                prefixIcon: const Icon(LineIcons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                      hideNewPassword ? LineIcons.eyeSlash : LineIcons.eye),
                  onPressed: () {
                    setState(() {
                      hideNewPassword = !hideNewPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _confirmPasswordEditingController,
              keyboardType: TextInputType.visiblePassword,
              onChanged: (value) {
                Validator.validateField(formKey: _formKey);
                setState(() {
                  _enableFormSubmit = _formKey.currentState!.validate();
                });
              },
              obscureText: hideNewPassword,
              validator: MultiValidator([
                RequiredValidator(errorText: 'New password is required'),
                MinLengthValidator(8,
                    errorText: 'Password should be a mininum of 8 characters')
              ]),
              decoration: InputDecoration(
                hintText: 'Confirm new password',
                labelText: 'Confirm new password',
                prefixIcon: const Icon(LineIcons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                      hideNewPassword ? LineIcons.eyeSlash : LineIcons.eye),
                  onPressed: () {
                    setState(() {
                      hideNewPassword = !hideNewPassword;
                    });
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 58,
            ),
            BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
              builder: (context, state) {
                if (state is ChangePasswordLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                return ElevatedButton(
                    onPressed: _enableFormSubmit == true
                        ? () {
                            context.read<ChangePasswordCubit>().changePassword(
                                  currentPassword:
                                      _currentPasswordEditingController.text,
                                  newPassword:
                                      _newPasswordEditingController.text,
                                  confirmPassword:
                                      _confirmPasswordEditingController.text,
                                );
                          }
                        : null,
                    child: const Text('Change Password'));
              },
            )
          ],
        ));
  }
}
