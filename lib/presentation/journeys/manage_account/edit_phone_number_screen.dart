import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../../data/core/validator.dart';
import '../../../data/models/user_models/user_data_model.dart';
import '../../reusables.dart';
import '../../widgets/labels/level_4_headline.dart';
import 'cubit/update_profile_cubit.dart';

class EditPhoneNumberScreen extends StatefulWidget {
  const EditPhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<EditPhoneNumberScreen> createState() => _EditPhoneNumberScreenState();
}

class _EditPhoneNumberScreenState extends State<EditPhoneNumberScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _phoneNumberController;
  bool isSecurityAlert = false;
  @override
  void initState() {
    _phoneNumberController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
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
              padding: EdgeInsets.all(16),
              child: Level4Headline(text: 'Edit your mobile number'),
            ),
            const SizedBox(
              height: 32,
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Level6Headline(
                  text:
                      'Enter the mobile number you’d like to use with your account.'),
            ),
            //edit phone form
            ValueListenableBuilder(
                valueListenable: Hive.box<UserData>('user_box').listenable(),
                builder: (context, Box<UserData> box, widget) {
                  final userData = box.get('user_data');
                  final user = userData?.user;
                  final donor = user?.donor;
                  // _phoneNumberController.text = donor?.phoneNumber ?? '';
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              keyboardType: TextInputType.phone,
                              onChanged: (value) {
                                Validator.validateField(formKey: _formKey);
                              },
                              controller: _phoneNumberController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Phone number required'),
                                MinLengthValidator(6,
                                    errorText:
                                        'Lenght should be greater than 6')
                              ]),
                              decoration: const InputDecoration(
                                prefixIcon: Icon(Icons.phone),
                                hintText: 'Mobile number',
                                labelText: 'Mobile number',
                              ),
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Checkbox(
                                    value: isSecurityAlert,
                                    onChanged: (onChanged) {
                                      setState(() {
                                        isSecurityAlert = onChanged!;
                                      });
                                    }),
                                Flexible(
                                    child: Column(
                                  children: [
                                    const Text(
                                        'I’d like to receive security messages on this number.'),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      'We may send messages to this number to confirm your identity when performing senstitive actions, for example when signing into the app.',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ))
                              ],
                            ),
                            const SizedBox(
                              height: 32,
                            ),
                            // save
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocConsumer<UpdateProfileCubit,
                                    UpdateProfileState>(
                                  listener: (context, state) {
                                    if (state is UpdateProfileSuccessfull) {
                                      Fluttertoast.showToast(
                                          msg: state.successMessage);
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
                                              .editPhoneNumber(
                                                  phoneNumber:
                                                      _phoneNumberController
                                                          .text,
                                                  isSecurityAlert:
                                                      isSecurityAlert);
                                        },
                                        child: Text('save'.toUpperCase()));
                                  },
                                )
                              ],
                            )
                            //end save
                          ],
                        )),
                  );
                })
            // end edit from
          ],
        )),
      ),
    );
  }
}
