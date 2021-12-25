import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/entities/onboarding_entity.dart';
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

import 'cubit/getcountreis_cubit.dart';

class GiftAidScreen extends StatefulWidget {
  const GiftAidScreen({Key? key}) : super(key: key);

  @override
  _GiftAidScreenState createState() => _GiftAidScreenState();
}

class _GiftAidScreenState extends State<GiftAidScreen> {
  GiftAidOptions? _aidOptions = GiftAidOptions.enabled;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  ElevatedNextIconButton(
                      text: 'Continue'.toUpperCase(),
                      onPressed: () async {
                        context
                            .read<OnboardingdataholderCubit>()
                            .updateOnboardingData(OnboardingEntity(
                              giftAidEnabled:
                                  _aidOptions == GiftAidOptions.enabled
                                      ? true
                                      : false,
                            ));
                         context.read<GetcountreisCubit>().getCountries();
                        Navigator.push(context,
                            AppRouter.routeToPage(const HomeAddressScreen()));
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

