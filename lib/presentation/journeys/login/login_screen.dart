import 'package:flutter/material.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/journeys/login/login_form.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_1_headline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../registration/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  final bool isLeading;
  final bool showRegister;
  const LoginScreen(
      {Key? key, this.isLeading = false, this.showRegister = false})
      : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    context.read<LoginCubit>().initializeLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: widget.isLeading,
        actions: [
          widget.showRegister == false
              ? const SizedBox.shrink()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) =>
                                    const RegistrationScreen()));
                      },
                      child: Text(
                        'Register'.toUpperCase(),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      )),
                ),
        ],
      ),
      body: AppBackgroundWidget(
        childWidget: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Level1Headline(text: 'Sign in'),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              const Text('Enter your login details to continue.'),
              const SizedBox(
                height: 8,
              ),
              BlocBuilder<UserCubit, UserState>(
                builder: (context, state) {
                  if (state is UnAuthenticated &&
                      state.rememberMeEmail!.isNotEmpty) {
                    return LoginForm(
                      remberEamil: true,
                      remberMeEmail: state.rememberMeEmail!,
                    );
                  }
                  return const LoginForm(
                    remberEamil: false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onTap;
  final AppBar appBar;

  const CustomAppBar(
      {required Key key, required this.onTap, required this.appBar})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: onTap, child: appBar);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
