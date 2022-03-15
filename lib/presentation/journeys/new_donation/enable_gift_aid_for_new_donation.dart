import 'package:flutter/material.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/donation_process_cubit.dart';
import 'package:idonatio/presentation/journeys/new_donation/entities/donation_process_entity.dart';
import 'package:idonatio/presentation/journeys/new_donation/review_and_payment.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/get_payment_methods_cubit.dart';

class EnableGiftAidForDonation extends StatefulWidget {
  const EnableGiftAidForDonation({Key? key}) : super(key: key);

  @override
  State<EnableGiftAidForDonation> createState() =>
      _EnableGiftAidForDonationState();
}

class _EnableGiftAidForDonationState extends State<EnableGiftAidForDonation> {
  bool? isTermsAndCondition = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: AppColor.appBackground,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Level2Headline(text: 'Enable GiftAid'),
                    const SizedBox(
                      height: 12,
                    ),
                    const BaseLabelText(
                        text:
                            'If you are a tax paying UK resident, the GiftAid scheme lets your favourite charities get an additional 25% on eligible donations – at no extra cost to you.'),
                    const SizedBox(
                      height: 12,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        'Learn more about GiftAid',
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: AppColor.basePrimary,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: BlocBuilder<DonationProcessCubit, DonationProcessEntity>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        //enabling gift aid to this donation
                        TextButton(
                          onPressed: () => context
                              .read<DonationProcessCubit>()
                              .updateDonationProccess(state.copyWith(
                                  applyGiftAidToDonation:
                                      !state.applyGiftAidToDonation)),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: state.applyGiftAidToDonation,
                                  onChanged: (value) {
                                    setState(() {
                                      context
                                          .read<DonationProcessCubit>()
                                          .updateDonationProccess(
                                              state.copyWith(
                                                  applyGiftAidToDonation: !state
                                                      .applyGiftAidToDonation));
                                    });
                                  }),
                              const SizedBox(
                                width: 16,
                              ),
                              const Flexible(
                                child: Text(
                                    'I’d like to enable GiftAid on this donation.'),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        //enable gift aid for future
                        TextButton(
                          onPressed: () => context
                              .read<DonationProcessCubit>()
                              .updateDonationProccess(state.copyWith(
                                  giftAidEnabled: !state.giftAidEnabled)),
                          child: Row(
                            children: [
                              Checkbox(
                                  value: state.giftAidEnabled,
                                  onChanged: (value) {
                                    setState(() {
                                      context
                                          .read<DonationProcessCubit>()
                                          .updateDonationProccess(
                                              state.copyWith(
                                                  giftAidEnabled:
                                                      !state.giftAidEnabled));
                                    });
                                  }),
                              const SizedBox(
                                width: 16,
                              ),
                              const Flexible(
                                child: Text(
                                    'I’d also like to enable GiftAid on future eligible donations.'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () => setState(() {
                  isTermsAndCondition = !isTermsAndCondition!;
                }),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                          value: isTermsAndCondition,
                          onChanged: (value) {
                            setState(() {
                              isTermsAndCondition = !isTermsAndCondition!;
                            });
                          }),
                      const SizedBox(
                        width: 16,
                      ),
                      const Flexible(
                          child: BaseLabelText(
                              text:
                                  'By enabling GiftAid on my donations, I confirm that I am a UK taxpayer and understand that if I pay less Income Tax and/or Capital Gains Tax in the current tax year than the amount of Gift Aid claimed on all my donations it is my responsibility to pay any difference.')),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocBuilder<GetPaymentMethodsCubit, GetPaymentMethodsState>(
                    builder: (context, state) {
                      if (state is GetPaymentMethodsLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return ElevatedButton(
                            onPressed: isTermsAndCondition!
                                ? () {
                                    context
                                        .read<GetPaymentMethodsCubit>()
                                        .getPaymentMethods();

                                    Navigator.push(
                                        context,
                                        AppRouter.routeToPage(
                                            const ReviewAndPayment()));
                                  }
                                : null,
                            child: Row(
                              children: [
                                Text('continue'.toUpperCase()),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(Icons.arrow_right_alt)
                              ],
                            ));
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
