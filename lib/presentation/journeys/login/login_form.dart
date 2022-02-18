import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/data/core/validator.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/router/app_router.dart';

import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';

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
    _emailAddressController.clear();
    _passwordController.clear();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool? rememberEmail = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Enter your login details to continue.'),
          const SizedBox(
            height: 8,
          ),
          BlocConsumer<LoginCubit, LoginState>(
            builder: (context, state) {
              if (state is LoginLoading) {
                return const AlertDialog(
                  content: Center(child: CircularProgressIndicator()),
                );
              }
              if (state is LoginFailed) {
                return AppErrorDialogWidget(
                    title: 'login failed', message: state.errorMessage);
              }
              return const SizedBox.shrink();
            },
            listenWhen: (previous, current) => current is LoginSuccess,
            listener: (context, state) {
              context
                  .read<AuthBloc>()
                  .add(const ChangeAuth(AuthStatus.authenticated));
              Navigator.push(
                context,
                AppRouter.routeToPage(const AuthGaurd()),
              );
            },
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            controller: _emailAddressController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Email is required'),
              EmailValidator(errorText: 'Enter a valid Email')
            ]),
            onChanged: (value) {
              _formKey.currentState!.validate();
            },
            decoration: const InputDecoration(
              hintText: 'Email address',
              labelText: 'Email address',
              prefixIcon: Icon(Icons.mail_outline),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            obscureText: hidePassword,
            onChanged: (value) => Validator.validateField(formKey: _formKey),
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
            height: 16,
          ),
          Row(
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
                        _emailAddressController.text, _passwordController.text);
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
      ),
    );
  }
}

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: const [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }
}
