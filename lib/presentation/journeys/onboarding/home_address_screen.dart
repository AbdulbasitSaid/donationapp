import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/getcountreis_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/payment_method_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/label_10_medium.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

import '../../widgets/loaders/primary_app_loader_widget.dart';
import 'entities/onboarding_entity.dart';

class HomeAddressScreen extends StatefulWidget {
  const HomeAddressScreen({Key? key}) : super(key: key);

  @override
  State<HomeAddressScreen> createState() => _HomeAddressScreenState();
}

class _HomeAddressScreenState extends State<HomeAddressScreen> {
  String? countyValue = 'county 1';
  late TextEditingController address;
  late TextEditingController town;
  late TextEditingController postCode;
  bool formIsValid = false;

  String? countryId;
  @override
  void initState() {
    address = TextEditingController();
    town = TextEditingController();
    postCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    address.dispose();
    town.dispose();
    postCode.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: BlocConsumer<OnboardingdataholderCubit, OnboardingEntity>(
              listener: (context, state) {},
              builder: (context, state) {
                return Form(
                  key: _formKey,
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
                        height: 32,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        controller: address,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'address is required'),
                          MinLengthValidator(8,
                              errorText: 'Please enter a valid  address')
                        ]),
                        decoration: const InputDecoration(
                          hintText: 'Address',
                          labelText: 'Address',
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: town,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'address is required'),
                          MinLengthValidator(3,
                              errorText: 'min of 3 characters')
                        ]),
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
                              value: countyValue,
                              isExpanded: true,
                              isDense: true,
                              onChanged: (String? newTitle) {
                                setState(() {
                                  countyValue = newTitle!;
                                });
                              },
                              items: <String>[
                                'county 1',
                                'county 2',
                                'county 3',
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
                          Flexible(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              onChanged: (value) {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    formIsValid = true;
                                  });
                                } else {
                                  setState(() {
                                    formIsValid = false;
                                  });
                                }
                              },
                              controller: postCode,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Postcode is required'),
                                MinLengthValidator(3,
                                    errorText: 'min of 6 characters')
                              ]),
                              decoration: const InputDecoration(
                                hintText: 'Postcode(83738)',
                                labelText: 'Postcode',
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      BlocBuilder<GetcountreisCubit, GetcountreisState>(
                        builder: (context, state) {
                          if (state is GetcountreisSuccessfull) {
                            final countries =
                                state.countries.countryData.toList();
                            return DropdownButtonFormField(
                              hint: const Text('Select Country'),
                              items: countries
                                  .map((e) => DropdownMenuItem<String>(
                                        child: Text(e.name),
                                        value: e.id,
                                      ))
                                  .toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  countryId = value;
                                });
                              },
                            );
                          } else if (state is GetcountreisLoading) {
                            return const Center(
                              child: PrimaryAppLoader(),
                            );
                          } else {
                            return TextButton(
                                onPressed: () {},
                                child: const Text(
                                    'Pleas tap to get list on countries'));
                          }
                        },
                      ),
                      const SizedBox(
                        height: 48,
                      ),
                      ElevatedNextIconButton(
                          text: 'Continue',
                          onPressed: formIsValid &&
                                  countryId != null &&
                                  countyValue != null
                              ? () {
                                  context
                                      .read<OnboardingdataholderCubit>()
                                      .updateOnboardingData(
                                        OnboardingEntity(
                                            giftAidEnabled:
                                                state.giftAidEnabled,
                                            address: address.text,
                                            city: town.text,
                                            county: countyValue!,
                                            countryId: countryId!,
                                            postalCode: postCode.text,
                                            isOnboarded: true),
                                      );
                                  Navigator.push(
                                      context,
                                      AppRouter.routeToPage(
                                          const PaymentMethodScreen()));
                                }
                              : null),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
