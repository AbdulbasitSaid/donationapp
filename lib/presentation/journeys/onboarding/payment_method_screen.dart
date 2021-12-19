import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/common/assest.dart';
import 'package:idonatio/common/enums/payment_options.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboarding_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/data_preference_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

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
        actions: [
          TextButton(onPressed: () {}, child: Text('Skip'.toUpperCase()))
        ],
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
                  const Level4Headline(
                      text: 'Add a payment method to use for your donations'),
                  const SizedBox(
                    height: 32,
                  ),
                  Platform.isIOS
                      ? ListTile(
                          title: SizedBox(
                            height: 30,
                            child: Row(
                              children: const [
                                Image(
                                  image: AssetImage(AppAssest.applePayIcon),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                BaseLabelText(text: 'Apple Pay'),
                              ],
                            ),
                          ),
                          leading: Radio<PaymentOptions>(
                            value: PaymentOptions.googlePay,
                            groupValue: paymentOptions,
                            onChanged: (PaymentOptions? value) {
                              setState(() {
                                paymentOptions = value;
                              });
                            },
                          ),
                        )
                      : ListTile(
                          title: SizedBox(
                            height: 30,
                            child: Row(
                              children: const [
                                Image(
                                  image: AssetImage(AppAssest.googlPayIcon),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                BaseLabelText(text: 'Google Pay'),
                              ],
                            ),
                          ),
                          leading: Radio<PaymentOptions>(
                            value: PaymentOptions.googlePay,
                            groupValue: paymentOptions,
                            onChanged: (PaymentOptions? value) {
                              setState(() {
                                paymentOptions = value;
                              });
                            },
                          ),
                        ),
                  const SizedBox(
                    height: 24,
                  ),
                  ListTile(
                    title: Row(
                      children: const [
                        BaseLabelText(text: 'Credit / Debit Card'),
                      ],
                    ),
                    leading: Radio<PaymentOptions>(
                      value: PaymentOptions.creditCard,
                      groupValue: paymentOptions,
                      onChanged: (PaymentOptions? value) {
                        setState(() {
                          paymentOptions = value;
                        });
                      },
                    ),
                  ),
                  paymentOptions == PaymentOptions.creditCard
                      ? Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.number,
                              controller: cardNumber,
                              validator:
                                  RequiredValidator(errorText: 'Card Number '),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.payment,
                                ),
                                hintText: 'Card number',
                                labelText: 'Card number',
                              ),
                            ),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: RequiredValidator(
                                        errorText: 'required'),
                                    controller: expryDate,
                                    decoration: const InputDecoration(
                                      hintText: 'Expiry',
                                      labelText: 'Expiry',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: RequiredValidator(
                                        errorText: 'required'),
                                    controller: cvc,
                                    decoration: const InputDecoration(
                                      hintText: 'CVC',
                                      labelText: 'CVC',
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Flexible(
                                  child: TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: RequiredValidator(
                                        errorText: 'required'),
                                    controller: postCode,
                                    decoration: const InputDecoration(
                                      hintText: 'Postcode',
                                      labelText: 'Postcode',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Container(),
                  const SizedBox(
                    height: 48,
                  ),
                  BlocListener<OnboardingCubit, OnboardingState>(
                    listener: (context, state) {
                      if (state is OnboardingSuccess) {
                        Navigator.push(
                            context,
                            AppRouter.routeToPage(
                                const OnboardingDataPreferencesScreen()));
                      }
                    },
                    child: ElevatedNextIconButton(
                        text: 'Continue'.toUpperCase(),
                        onPressed: () {
                          context.read<OnboardingCubit>().onBoardUser({
                            'payment_method':
                                paymentOptions == PaymentOptions.applePay
                                    ? ''
                                    : paymentOptions == PaymentOptions.googlePay
                                        ? 'google'
                                        : 'card'
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
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
