import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/journeys/manage_account/verify_edited_email_screen.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../reusables.dart';
import '../../widgets/buttons/logout_button_widget.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';
import 'cubit/update_profile_cubit.dart';

class EditEmailScreen extends StatefulWidget {
  const EditEmailScreen({Key? key, required this.initialEmail})
      : super(key: key);
  final String initialEmail;
  @override
  State<EditEmailScreen> createState() => _EditEmailScreenState();
}

class _EditEmailScreenState extends State<EditEmailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController emailEditingController;
  bool formIsValid = true;

  @override
  void initState() {
    emailEditingController = TextEditingController();
    emailEditingController.text = widget.initialEmail;
    super.initState();
  }

  @override
  void dispose() {
    emailEditingController.dispose();
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
              padding: EdgeInsets.all(
                16,
              ),
              child: Level2Headline(text: 'Edit your email address'),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                  'Enter the email address you’d like to use with your account.',
                  style: Theme.of(context).textTheme.headline4),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('*Your email address is also your login ID.'),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailEditingController,
                        onChanged: (value) {
                          setState(() {
                            formIsValid = _formKey.currentState!.validate();
                          });
                        },
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Email is required'),
                          EmailValidator(
                              errorText: 'Please enter a valid email')
                        ]),
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: 'Your email',
                          labelText: 'Your email',
                        ),
                      ),
                    ],
                  )),
            ),
            // save
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                    listener: (context, state) {
                      if (state is UpdateProfileSuccessfull) {
                        Fluttertoast.showToast(msg: state.successMessage);

                        Navigator.push(
                            context,
                            AppRouter.routeToPage(
                                const VerifyEdittedEmailScreen()));
                      }
                    },
                    builder: (context, state) {
                      if (state is UpdateProfileLoading) {
                        return const Center(
                          child: PrimaryAppLoader(),
                        );
                      }
                      return ElevatedButton(
                          onPressed: formIsValid
                              ? () {
                                  context.read<UpdateProfileCubit>().editEmail(
                                      email: emailEditingController.text);
                                  context.read<UserCubit>().setUserState(
                                      getItInstance(),
                                      AuthStatus.authenticated);
                                }
                              : null,
                          child: Text('save'.toUpperCase()));
                    },
                  )
                ],
              ),
            )

            //end save
          ],
        )),
      ),
    );
  }
}
