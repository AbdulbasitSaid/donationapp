import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_cart_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/makedonation_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import 'cubit/donation_process_cubit.dart';
import 'entities/donation_process_entity.dart';

class DonationSuccessScreen extends StatelessWidget {
  const DonationSuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColor.appBackground),
        child: BlocBuilder<MakedonationCubit, MakedonationState>(
          builder: (context, state) {
            if (state is MakedonationSuccess) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Level2Headline(text: 'Donation successful'),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.done,
                            size: 36,
                            color: AppColor.darkSecondaryGreen,
                          ),
                          const SizedBox(
                            width: 18,
                          ),
                          Flexible(
                            child: BlocBuilder<DonationProcessCubit,
                                DonationProcessEntity>(
                              builder: (context, state) {
                                return Column(
                                  children: [
                                    Text(
                                      'Your donation has been successfully processed.',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline2!
                                          .copyWith(
                                              color:
                                                  AppColor.darkSecondaryGreen),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    // Text(
                                    //   'You included the transaction fee of £${sta} in your payment.  ${state.paymentSuccessModel.data.donee.firstName}  ${state.paymentSuccessModel.data.donee.lastName} will get 100% of your donation amount.A confirmation email has been sent to your email address.',
                                    // ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 56,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              context.read<DonationCartCubit>().emptyCart();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  AppRouter.routeToPage(const AuthGaurd()),
                                  (route) => false);
                            },
                            child: Text('close'.toUpperCase()))
                      ],
                    ),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
