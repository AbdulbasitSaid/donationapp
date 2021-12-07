import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';

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
    _emailAddressController.addListener(() {
      setState(() {
        enalbleSignIn = _emailAddressController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
    _passwordController.addListener(() {
      setState(() {
        enalbleSignIn = _emailAddressController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _emailAddressController.clear();
    _passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Enter your login details to continue.'),
        const SizedBox(
          height: 16,
        ),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailAddressController,
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
            Checkbox(value: false, onChanged: (fasle) {}),
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
              onPressed: enalbleSignIn
                  ? () {
                      BlocProvider.of<LoginCubit>(context).initiateLogin(
                          _emailAddressController.text,
                          _passwordController.text);
                    }
                  : null,
              child: const Text('Sign in'),
            ),
          ],
        ),
      ],
    );
  }
}
