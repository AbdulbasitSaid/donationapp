import 'dart:io';

import 'package:flutter/material.dart';
import 'package:idonatio/common/assest.dart';
import 'package:idonatio/common/enums/payment_options.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/input_fields/creadit_card.dart';
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
                      // Icon(Icons.),
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
                    ? const CreaditCard()
                    : Container(),
                const SizedBox(
                  height: 48,
                ),
                ElevatedNextIconButton(
                  text: 'Continue'.toUpperCase(),
                  onPressed: () => Navigator.pushNamed(
                      context, RouteList.onboardDataPreferenceScreen),
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
    );
  }
}
