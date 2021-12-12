import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/journeys/authentication/start_screen.dart';
import 'package:idonatio/presentation/journeys/login/login_screen.dart';

class AuthGaurd extends StatelessWidget {
  const AuthGaurd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is UnSignedAuthenticated) {
          return StartScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
