import 'package:flutter/material.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/app_logo.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in'),
      ),
      body: SingleChildScrollView(
        child: AppBackgroundWidget(
          childWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AppLogo(),
              const SizedBox(
                height: 16,
              ),
              const Text('Enter your login details to continue.'),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
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
                      onPressed: () =>
                          Navigator.pushNamed(context, RouteList.verifyLogin),
                      child: const Text('Sign in'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
