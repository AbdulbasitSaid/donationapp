import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/data/core/validator.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/reset_password/bloc/resetpassword_bloc.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Level2Headline(text: 'Reset your password'),
            SizedBox(
              height: 48,
            ),
            BaseLabelText(text: 'Enter a new password for your account below.'),
            SizedBox(
              height: 32,
            ),
            NewPasswordForm(),
          ],
        ),
      )),
    );
  }
}

class NewPasswordForm extends StatefulWidget {
  const NewPasswordForm({Key? key}) : super(key: key);

  @override
  _NewPasswordFormState createState() => _NewPasswordFormState();
}

class _NewPasswordFormState extends State<NewPasswordForm> {
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  bool hidePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordBloc, ResetpasswordState>(
      listener: (context, state) {
        if (state is ResetpasswordSuccess) {
          Navigator.of(context, rootNavigator: true).pop();

          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.successMessage)));
          Navigator.push(context, AppRouter.routeToPage(const AuthGaurd()));
        }
        if (state is ResetpasswordFailed) {
          AppErrorDialogWidget(
            message: state.errorMessage,
            title: state.errorTitle,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword,
                onChanged: (value) =>
                    Validator.validateField(formKey: _formKey),
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Password is required'),
                  MinLengthValidator(8,
                      errorText: 'Password should be a mininum of 8 characters')
                ]),
                decoration: InputDecoration(
                  hintText: TranslationConstants.password,
                  labelText: TranslationConstants.password,
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(hidePassword
                        ? Icons.remove_red_eye_sharp
                        : Icons.panorama_fish_eye),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              //

              TextFormField(
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
                obscureText: hidePassword,
                onChanged: (value) =>
                    Validator.validateField(formKey: _formKey),
                validator: (value) {
                  if (value != _passwordController.text) {
                    return 'Must be same as password';
                  }
                  if (value == null || value.isEmpty) {
                    return "Confirm password is required";
                  }
                },
                decoration: InputDecoration(
                  hintText: 'Confirm password',
                  labelText: 'Confirm password',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(hidePassword
                        ? Icons.remove_red_eye_sharp
                        : Icons.panorama_fish_eye),
                    onPressed: () {
                      setState(() {
                        hidePassword = !hidePassword;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(
                height: 40,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ResetpasswordBloc>().add(
                              ChangeToNewPassword(
                                  password: _passwordController.text));
                        }
                      },
                      child: const Text('Reset Password')),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
