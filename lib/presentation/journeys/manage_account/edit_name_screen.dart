import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/update_profile_cubit.dart';
import 'package:idonatio/presentation/reusables.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

import '../../../data/core/validator.dart';
import '../../../data/models/user_models/user_data_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../widgets/buttons/logout_button_widget.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';

class EditNameScreen extends StatefulWidget {
  const EditNameScreen({Key? key, required this.titleValue}) : super(key: key);

  @override
  State<EditNameScreen> createState() => _EditNameScreenState();

  final String titleValue;
}

class _EditNameScreenState extends State<EditNameScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameTextController, _lastNameTextController;
  late String _titleValue;
  @override
  void initState() {
    _titleValue = widget.titleValue;
    _firstNameTextController = TextEditingController();
    _lastNameTextController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstNameTextController.dispose();
    _lastNameTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LogoutButton()],
      ),
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
              child: Level4Headline(text: 'What should we call you?'),
            ),
            //edit form
            Padding(
              padding: const EdgeInsets.all(16),
              child: ValueListenableBuilder(
                  valueListenable: Hive.box<UserData>('user_box').listenable(),
                  builder: (context, Box<UserData> box, widget) {
                    final userData = box.get('user_data');
                    final user = userData?.user;
                    final donor = user?.donor;
                    _firstNameTextController.text = donor?.firstName ?? '';
                    _lastNameTextController.text = donor?.lastName ?? '';
                    return Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // title
                            Row(
                              children: [
                                Flexible(
                                  child: DropdownButtonFormField(
                                    value: _titleValue,
                                    isExpanded: false,
                                    isDense: true,
                                    onChanged: (String? newTitle) {
                                      setState(() {
                                        _titleValue = newTitle!;
                                      });
                                    },
                                    items: <String>[
                                      'Mr',
                                      'Mrs',
                                      'Alhaji',
                                      'Doctor'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * .6,
                                )
                              ],
                            ),
                            //end title
                            // first name
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              controller: _firstNameTextController,
                              onChanged: (value) {
                                Validator.validateField(formKey: _formKey);
                              },
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'First Name is required'),
                                MinLengthValidator(3,
                                    errorText:
                                        'Lenght should be greater than 3')
                              ]),
                              decoration: const InputDecoration(
                                hintText: 'First Name',
                                labelText: 'First Name',
                              ),
                            ),
                            // end first name
                            //last name
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                Validator.validateField(formKey: _formKey);
                              },
                              controller: _lastNameTextController,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText: 'Last Name is required'),
                                MinLengthValidator(3,
                                    errorText:
                                        'Lenght should be greater than 3')
                              ]),
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
                                labelText: 'Last Name',
                              ),
                            ),
                            //end last name
                            const SizedBox(
                              height: 32,
                            ),
                            //saving changes
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
                                        child: PrimaryAppLoader(),
                                      );
                                    }
                                    return ElevatedButton(
                                        onPressed: () {
                                          context
                                              .read<UpdateProfileCubit>()
                                              .editName(
                                                  firstName:
                                                      _firstNameTextController
                                                          .text,
                                                  lastName:
                                                      _lastNameTextController
                                                          .text,
                                                  title: _titleValue);
                                        },
                                        child: Text('save'.toUpperCase()));
                                  },
                                )
                              ],
                            )
                            //end saving changes
                          ],
                        ));
                  }),
            ),
          ],
        )),
      ),
    );
  }
}
