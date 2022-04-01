import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:idonatio/common/assest.dart';
import 'package:idonatio/common/enums/payment_options.dart';
import 'package:idonatio/data/core/unauthorized_exception.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/create_setup_intent_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboarding_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

import '../../widgets/dialogs/app_error_dailog.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({Key? key}) : super(key: key);

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  PaymentOptions? paymentOptions = PaymentOptions.googlePay;
  final _formKey = GlobalKey<FormState>();
  late TextEditingController cardNumber;
  late TextEditingController expryDate;
  late TextEditingController cvc;
  late TextEditingController postCode;
  @override
  void initState() {
    cardNumber = TextEditingController();
    expryDate = TextEditingController();
    cvc = TextEditingController();
    postCode = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [],
      ),
      body: SafeArea(
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Label10Medium(text: '3/4'),
                  const SizedBox(
                    height: 8,
                  ),
                  const Level2Headline(text: 'Payment method'),
                  const SizedBox(
                    height: 40,
                  ),
                  BlocBuilder<CreateSetupIntentCubit, CreateSetupIntentState>(
                    builder: (context, state) {
                      if (state is CreateSetupIntentFailed) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: AppErrorDialogWidget(
                              title: "Login Failed",
                              message: state.errorMessage),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const Level4Headline(
                      text: 'Add a payment method to use for your donations'),
                  const SizedBox(
                    height: 32,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                              customerEphemeralKeySecret: state
                                  .setUpIntentEnitityData.data.ephemeralKey,
                            ));
                            try {
                              await Stripe.instance.presentPaymentSheet();
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(' succesfully completed'),
                                ),
                              );
                              final onboardingState = context
                                  .read<OnboardingdataholderCubit>()
                                  .state;
                              if (onboardingState is OnboardingdataUpdated) {
                                try {
                                  context.read<OnboardingCubit>().onBoardUser({
                                    "gift_aid_enabled": onboardingState
                                        .onboardingEntity.giftAidEnabled,
                                    "address": onboardingState
                                        .onboardingEntity.address,
                                    "city":
                                        onboardingState.onboardingEntity.city,
                                    "county":
                                        onboardingState.onboardingEntity.county,
                                    "postal_code": onboardingState
                                        .onboardingEntity.postalCode,
                                    "country_id": onboardingState
                                        .onboardingEntity.countryId,
                                    "payment_method": "card",
                                    "send_marketing_mail": onboardingState
                                        .onboardingEntity.sendMarketingMail,
                                    "is_onboarded": true,
                                    "donate_anonymously": onboardingState
                                        .onboardingEntity.donateAnonymously,
                                    "stripe_customer_id": state
                                        .setUpIntentEnitityData
                                        .data
                                        .stripeCustomerId
                                  });
                                  context.read<UserCubit>().setUserState(
                                      getItInstance(),
                                      AuthStatus.authenticated);
                                } on UnprocessableEntity {
                                  throw UnprocessableEntity();
                                } on Forbidden {
                                  throw Forbidden();
                                } on Exception {
                                  throw Exception();
                                }
                              }
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
                          if (state is CreateSetupIntentFailed) {}
                        },
                        builder: (context, state) {
                          if (state is CreateSetupIntentLoading) {
                            return const CircularProgressIndicator();
                          }
                          return ElevatedButton(
                              onPressed: () async {
                                await context
                                    .read<CreateSetupIntentCubit>()
                                    .createSetupIntent();
                              },
                              child: const Text('Add a Payment method'));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  BlocListener<OnboardingCubit, OnboardingState>(
                    listener: (context, state) {
                      if (state is OnboardingSuccess) {
                        context.read<UserCubit>().setUserState(
                            getItInstance(), AuthStatus.authenticated);
                        Navigator.pushAndRemoveUntil(
                            context,
                            AppRouter.routeToPage(const AuthGaurd()),
                            (route) => false);
                      }
                    },
                    child: Container(
                      height: 50,
                      padding: const EdgeInsets.all(8),
                      child: const Image(
                        image: AssetImage(AppAssest.poweredByStripe),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
