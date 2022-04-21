import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/new_donation/cubit/getdoneebycode_cubit.dart';
import 'package:idonatio/presentation/journeys/saved_donees/add_new_donee_screen.dart';
import 'package:idonatio/presentation/journeys/saved_donees/cubit/get_saved_donees_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';

import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SaveDoneeAddDoneeByIdScreen extends StatefulWidget {
  const SaveDoneeAddDoneeByIdScreen({Key? key}) : super(key: key);

  @override
  State<SaveDoneeAddDoneeByIdScreen> createState() =>
      _SaveDoneeAddDoneeByIdScreenState();
}

class _SaveDoneeAddDoneeByIdScreenState
    extends State<SaveDoneeAddDoneeByIdScreen> {
  late TextEditingController _doneeIdTextField;
  @override
  void initState() {
    _doneeIdTextField = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _doneeIdTextField.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  bool _enableButton = false;

  @override
  Widget build(BuildContext context) {
    final savedDoneeState = context.watch<GetSavedDoneesCubit>().state;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: AppColor.appBackground,
        ),
        child: SingleChildScrollView(
          child: BlocListener<GetdoneebycodeCubit, GetdoneebycodeState>(
            listener: (context, state) {
              if (state is GetdoneebycodeSuccess) {
                if (savedDoneeState is GetSavedDoneesSuccess) {
                  final savedDoneesIds = savedDoneeState
                      .savedDoneesResponseModel.data!
                      .map((e) => e.id)
                      .toList();
                  if (savedDoneesIds.contains(state.doneeResponseData.id)) {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (_) => AlertDialog(
                              title: const Text('Donee already Saved!!'),
                              content: const Text(
                                  'You have this Donee saved already. Click on retry to add deferent Donee or Click on Cancel to exit page.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text(
                                    'Retry',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        AppRouter.routeToPage(const HomeScreen(
                                          pageIndex: 2,
                                        )),
                                        (route) => false);
                                  },
                                  child: const Text(
                                    'Cancel',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                )
                              ],
                            ));
                  } else {
                    Navigator.push(context,
                        AppRouter.routeToPage(const AddNewDoneeScreen()));
                  }
                }
              }
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Level2Headline(text: 'Add donee by ID'),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Enter the ID code shared by your donee below.',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                    buildWhen: (previous, current) =>
                        current is GetdoneebycodeFailed,
                    builder: (context, state) {
                      if (state is GetdoneebycodeFailed) {
                        return AppErrorDialogWidget(
                          message: state.errorMessage,
                          title: state.errorTitle,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const BaseLabelText(text: 'Donee ID'),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _doneeIdTextField,
                    validator: RequiredValidator(errorText: 'errorText'),
                    onChanged: (value) {
                      setState(() {
                        _enableButton = _formKey.currentState!.validate();
                      });
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.tag),
                      hintText: '425A70',
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocBuilder<GetdoneebycodeCubit, GetdoneebycodeState>(
                        builder: (context, state) {
                          if (state is GetdoneebycodeLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ElevatedButton(
                                onPressed: _enableButton
                                    ? () {
                                        context
                                            .read<GetdoneebycodeCubit>()
                                            .getDoneeByCode(
                                                _doneeIdTextField.text);
                                      }
                                    : null,
                                child: Row(
                                  children: [
                                    Text(
                                      'continue'.toUpperCase(),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(Icons.arrow_right_alt_outlined)
                                  ],
                                ));
                          }
                        },
                      )
                    ],
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
