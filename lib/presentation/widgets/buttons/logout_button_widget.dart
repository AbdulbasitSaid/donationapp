import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../di/get_it.dart';
import '../../../enums.dart';
import '../../journeys/auth_guard.dart';
import '../../journeys/manage_account/cubit/logout_cubit.dart';
import '../../journeys/user/cubit/user_cubit.dart';
import '../../router/app_router.dart';

class LogoutButton extends StatelessWidget {
  const LogoutButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogoutCubit, LogoutState>(
      listener: (context, state) {
        if (state is LogoutSuccessful) {
          context
              .read<UserCubit>()
              .setUserState(getItInstance(), AuthStatus.unauthenticated);
          Navigator.pushAndRemoveUntil(context,
              AppRouter.routeToPage(const AuthGaurd()), (route) => false);
        }
      },
      child: TextButton(
          onPressed: () {
            context.read<LogoutCubit>().logoutUser();
          },
          child: const Text(
            'Logout',
            style: TextStyle(fontWeight: FontWeight.w700),
          )),
    );
  }
}
