import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboarding_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/home_address_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:idonatio/presentation/widgets/radio_buttons/enable_gift_aid_option.dart';

class EnableGiftAidForm extends StatefulWidget {
  const EnableGiftAidForm({Key? key}) : super(key: key);

  @override
  _EnableGiftAidFormState createState() => _EnableGiftAidFormState();
}

class _EnableGiftAidFormState extends State<EnableGiftAidForm> {
  GiftAidOptions? _aidOptions = GiftAidOptions.enabled;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Label10Medium(text: '1/4'),
                const SizedBox(
                  height: 8,
                ),
                const Level2Headline(text: 'GiftAid'),
                const SizedBox(
                  height: 40,
                ),
                const Level4Headline(
                  text: 'Would you like to enable GiftAid on your donations?',
                ),
                const SizedBox(
                  height: 16,
                ),
                const BaseLabelText(
                  text:
                      'If you are a tax paying UK resident, the GiftAid scheme lets your favourite charities get an additional 25% on eligible donations – at no extra cost to you.',
                ),
                Row(
                  children: [
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          'Learn more about GiftAid',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColor.basePrimary,
                                    decoration: TextDecoration.underline,
                                  ),
                        )),
                  ],
                ),
                Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          title: const Text(
                              'Yes, I’d like to enable GiftAid on eligible donations.*'),
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: Text(
                              '*By enabling GiftAid on my donations, I confirm that I am a UK taxpayer and understand that if I pay less Income Tax and/or Capital Gains Tax in the current tax year than the amount of Gift Aid claimed on all my donations it is my responsibility to pay any difference.',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          leading: Radio<GiftAidOptions>(
                            groupValue: _aidOptions,
                            value: GiftAidOptions.enabled,
                            onChanged: (GiftAidOptions? value) {
                              setState(() {
                                _aidOptions = value;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('No, thank you.'),
                          leading: Radio<GiftAidOptions>(
                            groupValue: _aidOptions,
                            value: GiftAidOptions.notEnabled,
                            onChanged: (GiftAidOptions? value) {
                              setState(() {
                                _aidOptions = value;
                              });
                            },
                          ),
                        )
                      ],
                    )),
                const SizedBox(
                  height: 32,
                ),
                BlocListener<OnboardingCubit, OnboardingState>(
                  listener: (context, state) {
                    if (state is OnboardingSuccess) {
                      Navigator.push(context,
                          AppRouter.routeToPage(const HomeAddressScreen()));
                    }
                  },
                  child: BlocListener<OnboardingCubit, OnboardingState>(
                    listener: (context, state) {
                      if (state is OnboardingSuccess) {
                        final snackBar = SnackBar(
                          content: const Text('Success!'),
                          action: SnackBarAction(
                            label: 'Ok',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: ElevatedNextIconButton(
                        text: 'Continue'.toUpperCase(),
                        onPressed: () {
                          context.read<OnboardingCubit>().onBoardUser({
                            'gift_aid_enabled':
                                _aidOptions == GiftAidOptions.enabled
                                    ? true
                                    : false
                          });
                        }),
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
