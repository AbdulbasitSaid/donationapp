import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:idonatio/presentation/journeys/email_verification/email_varification_screen.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/login/login_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/journeys/user/start_screen.dart';



class AuthGaurd extends StatelessWidget {
  const AuthGaurd({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is AuthenticationInitial) {
          return const Center(
            child: PageLoaderWidget(),
          );
        } else if (state is UnAuthenticated) {
          return const LoginScreen();
        } else if (state is Authenticated) {
       
          return const HomeScreen();
        } else if (state is EmailNotVerified) {
          return const EmailVerificationScreen();
        } else if (state is NotBoarded) {
          return OnboardingScreen(
            localUserObject: state.localUserObject,
          );
        } else if (state is UnSaved) {
          return const StartScreen();
        } else {
          return const StartScreen();
        }
      },
    );
  }
}

class PageLoaderWidget extends StatelessWidget {
  const PageLoaderWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
