import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/contact_support_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../reusables.dart';
import '../../widgets/buttons/logout_button_widget.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({Key? key}) : super(key: key);

  @override
  _ContactSupportScreenState createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _editingController;
  bool _enableSendMessage = false;
  @override
  void initState() {
    _editingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _editingController.dispose();
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
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              onChanged: () {
                setState(() {
                  _enableSendMessage = _formKey.currentState!.validate();
                });
              },
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Level2Headline(text: 'Contact support'),
                  const SizedBox(
                    height: 16,
                  ),
                  const Text(
                      'Before sending us a message, have a look through the FAQs to see if we already have an answer to your enquiry.If not, go ahead and send us a message. We’ll do our best to respond within 48 hrs.'),
                  const SizedBox(height: 16),
                  Text(
                    'Note: We’ll send a copy of your message and respond directly to your registered email address.',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: AppColor.darkSecondaryGreen),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  TextFormField(
                    maxLines: 8,
                    controller: _editingController,
                    validator: MultiValidator([
                      RequiredValidator(errorText: 'Message is required'),
                      MinLengthValidator(8,
                          errorText: 'Lenght should be greater than 8')
                    ]),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BlocConsumer<ContactSupportCubit, ContactSupportState>(
                        listener: (context, state) {
                          if (state is ContactSupportSuccessful) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text('Message sent'),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            AppRouter.routeToPage(
                                                const HomeScreen()),
                                            (route) => false);
                                      },
                                      child: Text('ok'.toUpperCase())),
                                ],
                                content: Text('${state.successMessage} '),
                              ),
                            );
                          }
                          if (state is ContactSupportFailed) {
                            Fluttertoast.showToast(msg: state.errorMessage);
                          }
                        },
                        builder: (context, state) {
                          if (state is ContactSupportLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return ElevatedButton(
                            onPressed: _enableSendMessage
                                ? () {
                                    context
                                        .read<ContactSupportCubit>()
                                        .contactSupport(
                                            _editingController.text);
                                  }
                                : null,
                            child: Text(
                              'Send Message'.toUpperCase(),
                            ),
                          );
                        },
                      ),
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
