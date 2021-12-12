import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/router/app_router.dart';

import 'package:idonatio/presentation/themes/app_color.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late TextEditingController _emailAddressController, _passwordController;
  bool enalbleSignIn = false;
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
          BlocBuilder<LoadingCubit, LoadingState>(builder: (context, state) {
            if (state is ShowloadingState) {
              return const CircularProgressIndicator();
            }
          }),
          BlocConsumer<LoginCubit, LoginState>(
            buildWhen: (previous, current) => current is LoginFailed,
            builder: (context, state) {
              if (state is LoginFailed) {
                return ListTile(
                  leading: const Icon(Icons.cancel_outlined),
                  title: const Text('Incorrect email / password combination'),
                  subtitle: Text(state.errorMessage),
                );
              }
              return const SizedBox.shrink();
            },
            listenWhen: (previous, current) => current is LoginSuccess,
            listener: (context, state) {
              Navigator.pushAndRemoveUntil(context,
                  AppRouter.routeToPage(const HomeScreen()), (route) => false);
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
            keyboardType: TextInputType.visiblePassword,
            controller: _passwordController,
            obscureText: true,
            validator: RequiredValidator(errorText: 'Password is required'),
            onChanged: (value) => _formKey.currentState!.validate(),
            decoration: const InputDecoration(
              hintText: 'Password',
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock_outline),
              suffixIcon: Icon(Icons.remove_red_eye_sharp),
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
