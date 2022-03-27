import 'package:flutter/material.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/login/login_form.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_1_headline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manage_account/cubit/logout_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (() async {
        context.read<LoginCubit>().initializeLogin();
        return true;
      }),
      child: Scaffold(
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
                          Navigator.pushAndRemoveUntil(
                              context,
                              AppRouter.routeToPage(const AuthGaurd()),
                              (route) => false);
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
