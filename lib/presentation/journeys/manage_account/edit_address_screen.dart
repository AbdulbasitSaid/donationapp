import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/update_profile_cubit.dart';

import '../../reusables.dart';
import '../../widgets/labels/level_4_headline.dart';
import '../onboarding/cubit/getcountreis_cubit.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  String? countyValue = 'county 1';
  late TextEditingController addressController;
  late TextEditingController cityController;
  late TextEditingController postCode;
  bool formIsValid = false;

  String? countryId;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    addressController = TextEditingController();
    cityController = TextEditingController();
    postCode = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    addressController.dispose();
    cityController.dispose();
    postCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        decoration: gradientBoxDecoration(),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Level4Headline(text: 'Edit your home address'),
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                  'If you have enabled GiftAid on your donations, your home address is required to identify you as a UK taxpayer and is used by the charities you donate to for claiming any eligible GiftAid.'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.streetAddress,
                      controller: addressController,
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
                      controller: cityController,
                      validator: MultiValidator([
                        RequiredValidator(errorText: 'town is required'),
                        MinLengthValidator(3, errorText: 'min of 3 characters')
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
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return TextButton(
                              onPressed: () {
                                context
                                    .read<GetcountreisCubit>()
                                    .getCountries();
                              },
                              child: const Text(
                                  'Pleas tap to get list on countries'));
                        }
                      },
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                          listener: (context, state) {
                            if (state is UpdateProfileSuccessfull) {
                              Fluttertoast.showToast(msg: state.successMessage);
                              Navigator.pop(context);
                            }
                          },
                          builder: (context, state) {
                            if (state is UpdateProfileLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<UpdateProfileCubit>()
                                      .editAddress(
                                        address: addressController.text,
                                        city: cityController.text,
                                        postCode: postCode.text,
                                        county: countyValue!,
                                        country: countryId!,
                                      );
                                },
                                child: Text('save'.toUpperCase()));
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
