import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/journeys/authentication/start_screen.dart';
import 'package:idonatio/presentation/journeys/email_verification/email_varification_screen.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/login/login_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';

class AuthGaurd extends StatelessWidget {
  const AuthGaurd({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnAuthenticated) {
          return const LoginScreen();
        } else if (state is Authenticated) {
          return const HomeScreen();
        } else if (state is EmailNotVerified) {
          return const EmailVerificationScreen();
        } else if (state is NotBoarded) {
          return OnboardingScreen(
            localUserObject: state.userObject,
          );
        } else {
          return const StartScreen();
        }
      },
    );
  }
}
