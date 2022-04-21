import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/reset_password_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/validate_otp_forgot_password_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../../common/words.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController confirmPasswordController;

  late TextEditingController newPasswordController;
  bool hidePassword = false;
  bool formValid = false;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
        childWidget: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: _formKey,
            onChanged: () {
              setState(() {
                formValid = _formKey.currentState!.validate();
              });
            },
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Level2Headline(text: 'Reset your password'),
                  const SizedBox(
                    height: 48,
                  ),
                  const Text('Enter a new password for your account below.'),
                  const SizedBox(
                    height: 32,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  // new password
                  TextFormField(
                    controller: newPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: hidePassword,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Password is required'),
                      MinLengthValidator(8,
                          errorText:
                              'Password should be a mininum of 8 characters')
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
                  const SizedBox(
                    height: 32,
                  ),
                  // confirm password
                  TextFormField(
                    controller: confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: hidePassword,
                    validator: (text) {
                      if (text == newPasswordController.text) return null;
                      return 'Field must be same as new password!!';
                    },
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

                  const SizedBox(
                    height: 56,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Builder(builder: (context) {
                        final validatePasswordState = context
                            .watch<ValidateOtpForgotPasswordCubit>()
                            .state;
                        return BlocConsumer<ResetPasswordCubit,
                            ResetPasswordState>(
                          listener: (context, state) {
                            if (state is ResetPasswordSuccess) {
                              Fluttertoast.showToast(msg: state.message);
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  AppRouter.routeToPage(const AuthGaurd()),
                                  (route) => false);
                            }
                            if (state is ResetPasswordFailed) {
                              Fluttertoast.showToast(msg: state.message);
                            }
                          },
                          builder: (context, state) {
                            if (state is ResetPasswordLoading) {
                              return const CircularProgressIndicator.adaptive();
                            }

                            return ElevatedButton(
                                onPressed: formValid
                                    ? () {
                                        if (validatePasswordState
                                            is ValidateOtpForgotPasswordSuccess) {
                                          context
                                              .read<ResetPasswordCubit>()
                                              .resetPassword(
                                                  password:
                                                      newPasswordController
                                                          .text,
                                                  email: validatePasswordState
                                                      .response.data.email!,
                                                  passwordToken:
                                                      validatePasswordState
                                                          .response
                                                          .data
                                                          .passwordResetToken!);
                                        }
                                      }
                                    : null,
                                child: const Text('Reset Password'));
                          },
                        );
                      }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
