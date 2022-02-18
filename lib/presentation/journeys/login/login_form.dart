import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailAddressController, _passwordController;
  bool enalbleSignIn = false;
  bool hidePassword = true;

  @override
  void initState() {
    _emailAddressController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailAddressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool? rememberEmail = false;
  @override
  Widget build(BuildContext context) {
    return Form(
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
              EmailField(
                  emailController: _emailAddressController, formKey: _formKey),
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
                          rememberEmail = value;
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
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<LoginCubit>().initiateLogin(
                            _emailAddressController.text,
                            _passwordController.text);
                      }
                    },
                    child: const Text('Sign in'),
                  ),
                ],
              ),
              BlocBuilder<LoginCubit, LoginState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return const Text('loadding');
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
