import 'package:flutter/material.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/login/login_form.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_1_headline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manage_account/cubit/logout_cubit.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
        childWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Level1Headline(text: 'Sign in'),
                  IconButton(
                      onPressed: () {
                        context.read<LogoutCubit>().logoutUser();
                        context.read<UserCubit>().setUserState(
                            getItInstance(), AuthStatus.appStarted);
                        Navigator.pushAndRemoveUntil(context, AppRouter.routeToPage(const AuthGaurd()), (route) => false);
                      },
                      icon: const Icon(
                        Icons.power_settings_new_outlined,
                        size: 36,
                      ))
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Enter your login details to continue.'),
              const SizedBox(
                height: 8,
              ),
              const LoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
