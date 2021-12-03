import 'package:flutter/material.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
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
                const EnableGiftAidOption(),
                const SizedBox(
                  height: 32,
                ),
                ElevatedNextIconButton(
                  text: 'Continue'.toUpperCase(),
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteList.homeAddressScreen),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
