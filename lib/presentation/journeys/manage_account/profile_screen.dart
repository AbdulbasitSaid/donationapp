import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/logout_cubit.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../../di/get_it.dart';
import '../../../enums.dart';
import '../../bloc/login/login_cubit.dart';
import '../../reusables.dart';
import '../../router/app_router.dart';
import '../auth_guard.dart';
import '../user/cubit/user_cubit.dart';

class ManageAccountScreen extends StatelessWidget {
  const ManageAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColor.appBackground),
        child: SingleChildScrollView(
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
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Level6Headline(text: 'Account information'),
              ),
              Container(
                decoration: defaultContainerDecoration(),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My profile',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Manage your login, contact and other preferences.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const Divider(),
                    Text(
                      'Payment method',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Add, edit or remove a payment method.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Level6Headline(text: 'Get help'),
              ),
              Container(
                decoration: defaultContainerDecoration(),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'FAQs',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Answers to the most common user questions.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const Divider(),
                    Text(
                      'Contact support',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Reach out to the iDonatio support team.',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Level6Headline(text: 'Legal information'),
              ),
              Container(
                decoration: defaultContainerDecoration(),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About iDonatio',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const Divider(),
                    Text(
                      'Terms & conditions',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const Divider(),
                    Text(
                      'Privacy policy',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Level6Headline(text: 'Other actions'),
              ),
              Container(
                decoration: defaultContainerDecoration(),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Close account',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    const Divider(),
                    BlocConsumer<LogoutCubit, LogoutState>(
                      listener: (context, state) {
                        if (state is LogoutSuccessful) {
                          context.read<UserCubit>().setUserState(
                              getItInstance(), AuthStatus.unauthenticated);
                          Navigator.pushAndRemoveUntil(
                              context,
                              AppRouter.routeToPage(const AuthGaurd()),
                              (route) => false);
                        }
                      },
                      builder: (context, state) {
                        if (state is LogoutLoading) {
                          return const CircularProgressIndicator();
                        }
                        return GestureDetector(
                          onTap: () {
                            context.read<LogoutCubit>().logoutUser();
                          },
                          child: Text(
                            'Logout',
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(32),
                child: Text(
                  '©2021 iDonatio UK Ltd. Company No. 127227109 Chapel Place, London, UK, EC2A 3DQ.All rights reserved.',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
