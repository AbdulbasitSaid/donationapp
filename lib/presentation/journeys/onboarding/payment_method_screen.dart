import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/common/assest.dart';
import 'package:idonatio/common/enums/payment_options.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/create_setup_intent_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/data_preference_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

import '../../widgets/dialogs/app_error_dailog.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';

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
    final onboardingProcessState =
        context.watch<OnboardingdataholderCubit>().state;
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
                            try {
                              await Stripe.instance
                                  .initPaymentSheet(
                                      paymentSheetParameters:
                                          SetupPaymentSheetParameters(
                                    merchantDisplayName: 'Idonatio',
                                    setupIntentClientSecret: state
                                        .setUpIntentEnitityData
                                        .data
                                        .setupIntent,
                                    customerId: state.setUpIntentEnitityData
                                        .data.stripeCustomerId,
                                    customerEphemeralKeySecret: state
                                        .setUpIntentEnitityData
                                        .data
                                        .ephemeralKey,
                                  ))
                                  .whenComplete(() async => await Stripe
                                      .instance
                                      .presentPaymentSheet());
                              context
                                  .read<OnboardingdataholderCubit>()
                                  .updateOnboardingData(
                                      onboardingProcessState.copyWith(
                                    stripeCustomerId: state
                                        .setUpIntentEnitityData
                                        .data
                                        .stripeCustomerId,
                                    paymentMethod: 'card',
                                  ));

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Payment method added successfully :-) !!'),
                                ),
                              );
                              Navigator.push(
                                context,
                                AppRouter.routeToPage(
                                    const OnboardingDataPreferencesScreen()),
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

                          if (state is CreateSetupIntentFailed) {
                            Fluttertoast.showToast(
                                msg:
                                    'Failed to reach stripe!! Please try again');
                          }
                        },
                        builder: (context, state) {
                          if (state is CreateSetupIntentLoading) {
                            return const PrimaryAppLoader();
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
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(8),
                    child: const Image(
                      image: AssetImage(AppAssest.poweredByStripe),
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
