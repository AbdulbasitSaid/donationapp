
import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColor.appBackground),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Level2Headline(text: 'Manage account'),
            ),
            const SizedBox(
              height: 8,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Level6Headline(text: 'Account information'),
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              padding: const EdgeInsets.all(16),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
    // return Center(
    //   child: BlocConsumer<LogoutCubit, LogoutState>(
    //     listener: (context, state) {
    //       if (state is LogoutSuccessful) {
    //         context
    //             .read<UserCubit>()
    //             .setUserState(getItInstance(), AuthStatus.unauthenticated);
    //         Navigator.pushAndRemoveUntil(context,
    //             AppRouter.routeToPage(const AuthGaurd()), (route) => false);
    //       }
    //     },
    //     builder: (context, state) {
    //       if (state is LoginLoading) {
    //         return const CircularProgressIndicator();
    //       } else {
    //         return ElevatedButton(
    //             onPressed: () {
    //               log('hey');
    //               context.read<LogoutCubit>().logoutUser();
    //             },
    //             child: const Text('Loggout'));
    //       }
    //     },
    //   ),
    // );
  }
}
