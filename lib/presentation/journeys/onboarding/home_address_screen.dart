import 'package:flutter/material.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/input_fields/base_text_field.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

class HomeAddressScreen extends StatefulWidget {
  const HomeAddressScreen({Key? key}) : super(key: key);

  @override
  State<HomeAddressScreen> createState() => _HomeAddressScreenState();
}

class _HomeAddressScreenState extends State<HomeAddressScreen> {
  String countryValue = 'United Kingdom';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Label10Medium(text: '2/4'),
                  const SizedBox(
                    height: 8,
                  ),
                  const Level2Headline(text: 'Home address'),
                  const SizedBox(
                    height: 32,
                  ),
                  const Level4Headline(
                      text:
                          'Please provide your home address to enable GiftAid on your donations'),
                  const SizedBox(
                    height: 16,
                  ),
                  const BaseLabelText(
                      text:
                          'Your home address will be used by the charities you donate to for claiming any eligible GiftAid. It is also needed to identify you as a current UK taxpayer. '),
                  const SizedBox(
                    height: 16,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      hintText: 'Address',
                      labelText: 'Address',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    decoration: const InputDecoration(
                      hintText: 'Town / City',
                      labelText: 'Town / City',
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Flexible(
                        child: DropdownButtonFormField(
                          value: countryValue,
                          isExpanded: true,
                          isDense: true,
                          onChanged: (String? newTitle) {
                            setState(() {
                              countryValue = newTitle!;
                            });
                          },
                          items: <String>[
                            'United Kingdom',
                            'Nigeria',
                            'Germany',
                            'Brazil',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      const Flexible(child: BaseTextField(hintText: 'Postcode'))
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  ElevatedNextIconButton(
                    text: 'Continue',
                    onPressed: () => Navigator.pushNamed(
                        context, RouteList.paymentMethodScreen),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
