import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:idonatio/presentation/journeys/manage_account/contact_support_screen.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/logout_cubit.dart';
import 'package:idonatio/presentation/journeys/manage_account/my_profile_screen.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../../di/get_it.dart';
import '../../../enums.dart';
import '../../reusables.dart';
import '../../router/app_router.dart';
import '../auth_guard.dart';
import '../onboarding/cubit/create_setup_intent_cubit.dart';
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
                decoration: whiteContainerBackGround(),
                padding: const EdgeInsets.all(16),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          AppRouter.routeToPage(const MyProfileScreen())),
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
                        ],
                      ),
                    ),
                    const Divider(),
                    BlocConsumer<CreateSetupIntentCubit,
                        CreateSetupIntentState>(
                      listener: (context, state) async {
                        if (state is CreateSetupIntentSuccessful) {
                          await Stripe.instance.initPaymentSheet(
                              paymentSheetParameters:
                                  SetupPaymentSheetParameters(
                            merchantDisplayName: 'Idonatio',
                            setupIntentClientSecret:
                                state.setUpIntentEnitityData.data.setupIntent,
                            customerId: state
                                .setUpIntentEnitityData.data.stripeCustomerId,
                            customerEphemeralKeySecret:
                                state.setUpIntentEnitityData.data.ephemeralKey,
                          ));
                          try {
                            await Stripe.instance.presentPaymentSheet();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(' succesfully completed'),
                              ),
                            );
                          } on Exception catch (e) {
                            if (e is StripeException) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Error from Stripe: ${e.error.localizedMessage}'),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Unforeseen error: $e'),
                                ),
                              );
                            }
                          }
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            context
                                .read<CreateSetupIntentCubit>()
                                .createSetupIntent();
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
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
                        );
                      },
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
                decoration: whiteContainerBackGround(),
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
                    GestureDetector(
                      onTap: () => Navigator.push(context,
                          AppRouter.routeToPage(const ContactSupportScreen())),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                decoration: whiteContainerBackGround(),
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
                decoration: whiteContainerBackGround(),
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
