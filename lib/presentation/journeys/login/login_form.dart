import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/reset_password/reset_password.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';

import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_loader_dialog.dart';
import 'package:idonatio/presentation/widgets/input_fields/email_form_field.dart';
import 'package:idonatio/presentation/widgets/input_fields/password_widget.dart';

import '../../widgets/input_fields/get_remember_me_email_cubit.dart';
import '../../widgets/labels/base_label_text.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailAddressController, _passwordController;
  bool enableSignIn = false;
  bool hidePassword = true;
  String _email = '';

  @override
  void initState() {
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    context.read<GetRememberMeEmailCubit>().getRememberMeEmail();
    super.initState();
  }

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool rememberEmail = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      onChanged: () {
        setState(() {
          enableSignIn = _formKey.currentState!.validate();
        });
      },
      key: _formKey,
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            showDialog(
                context: context,
                builder: (context) {
                  return const AppLoader(
                    loadingMessage: 'Sending request please wait..',
                  );
                });
          } else if (state is LoginSuccess) {
            context
                .read<UserCubit>()
                .setUserState(getItInstance(), AuthStatus.authenticated);

            Navigator.push(context, AppRouter.routeToPage(const AuthGaurd()));
          } else {
            Navigator.of(context, rootNavigator: true).pop();
          }
        },
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 16,
              ),
              state is LoginFailed
                  ? AppErrorDialogWidget(
                      title: "Login Failed", message: state.errorMessage)
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 16,
              ),
              BlocBuilder<GetRememberMeEmailCubit, GetRememberMeEmailState>(
                builder: (context, state) {
                  if (state is GetRememberMeEmailSuccessful) {
                    _email = state.email;
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
                              _formKey.currentState!.validate();
                            }
                          },
                          child: TextFormField(
                            initialValue: _email,
                            onChanged: (value) {
                              setState(() {
                                _email = value;
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            // initialValue: email,
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Email is required'),
                              EmailValidator(
                                  errorText:
                                      'Please Enter a valid email Address'),
                            ]),
                            decoration: const InputDecoration(
                              hintText: 'Email address',
                              prefixIcon: Icon(Icons.person_outline_outlined),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return EmailField(
                      emailController: _emailAddressController,
                      formKey: _formKey,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 16,
              ),
              PasswordWidget(
                formKey: _formKey,
                passwordController: _passwordController,
              ),
              const SizedBox(
                height: 16,
              ),
              TextButton(
                onPressed: () => Navigator.push(context,
                    AppRouter.routeToPage(const ResetPasswordEmailScreen())),
                child: Row(
                  children: const [
                    Flexible(
                      child: Icon(
                        Icons.restart_alt,
                        color: AppColor.basePrimary,
                      ),
                    ),
                    Text(
                      'Reset Password',
                      style: TextStyle(color: AppColor.basePrimary),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Checkbox(
                      value: rememberEmail,
                      onChanged: (value) {
                        setState(() {
                          rememberEmail = value!;
                        });
                      }),
                  const Flexible(
                    child: Text(
                      'Remember my email address on this device.',
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: enableSignIn
                        ? () {
                            if (_formKey.currentState!.validate()) {
                              context.read<LoginCubit>().initiateLogin(
                                  _email.isEmpty
                                      ? _emailAddressController.text
                                      : _email,
                                  _passwordController.text,
                                  rememberEmail);
                            }
                          }
                        : null,
                    child: const Text('Sign in'),
                  ),
                ],
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Text('loading');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
