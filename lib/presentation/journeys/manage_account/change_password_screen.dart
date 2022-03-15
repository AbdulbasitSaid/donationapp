import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/manage_account/cubit/change_password_cubit.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_6_headline.dart';

import '../../reusables.dart';
import '../../router/app_router.dart';
import '../../themes/app_color.dart';
import '../../widgets/dialogs/app_error_dailog.dart';
import '../reset_password/reset_password.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _currentPasswordEditingController;
  late TextEditingController _newPasswordEditingController;
  late TextEditingController _confirmPasswordEditingController;
  bool hidePassword = true;
  bool formIsValid = true;

  @override
  void initState() {
    _currentPasswordEditingController = TextEditingController();
    _newPasswordEditingController = TextEditingController();
    _confirmPasswordEditingController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _currentPasswordEditingController.dispose();
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
                child: Level2Headline(text: 'Edit your password'),
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Level6Headline(
                  text:
                      'Enter the password you’d like to use with your account below.',
                ),
              ),
              BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                builder: (context, state) {
                  if (state is ChangePasswordFailed) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: AppErrorDialogWidget(
                          title: "Change password failed",
                          message: state.errorMessage),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        //current password
                        TextFormField(
                          controller: _currentPasswordEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePassword,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password is required'),
                            MinLengthValidator(8,
                                errorText:
                                    'Password should be a mininum of 8 characters')
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Current password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye_sharp),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        const Text(
                            'Can’t remember your current password? Use the link below to reset it.'),

                        TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              AppRouter.routeToPage(
                                  const ResetPasswordEmailScreen())),
                          child: Row(
                            children: const [
                              Flexible(
                                child: Icon(
                                  Icons.restart_alt,
                                  color: AppColor.basePrimary,
                                ),
                              ),
                              Text(
                                'Reset Password',
                                style: TextStyle(color: AppColor.basePrimary),
                              ),
                            ],
                          ),
                        ),

                        //new password
                        TextFormField(
                          controller: _newPasswordEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePassword,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password is required'),
                            MinLengthValidator(8,
                                errorText:
                                    'Password should be a mininum of 8 characters')
                          ]),
                          decoration: InputDecoration(
                            hintText: 'new password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye_sharp),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        //confirm password
                        TextFormField(
                          controller: _confirmPasswordEditingController,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: hidePassword,
                          validator: MultiValidator([
                            RequiredValidator(
                                errorText: 'Password is required'),
                            MinLengthValidator(8,
                                errorText: 'Password do not match')
                          ]),
                          decoration: InputDecoration(
                            hintText: 'Confirm password',
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.remove_red_eye_sharp),
                              onPressed: () {
                                setState(() {
                                  hidePassword = !hidePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                      listener: (context, state) {
                        if (state is ChangePasswordSuccess) {
                          Fluttertoast.showToast(msg: state.successMessage);

                          Navigator.push(
                              context, AppRouter.routeToPage(HomeScreen()));
                        }
                      },
                      builder: (context, state) {
                        if (state is ChangePasswordLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return ElevatedButton(
                            onPressed: formIsValid
                                ? () {
                                    context
                                        .read<ChangePasswordCubit>()
                                        .changePassword(
                                          currentPassword:
                                              _currentPasswordEditingController
                                                  .text,
                                          newPassword:
                                              _newPasswordEditingController
                                                  .text,
                                          confirmPassword:
                                              _confirmPasswordEditingController
                                                  .text,
                                        );
                                  }
                                : null,
                            child: Text('Change Password'.toUpperCase()));
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
