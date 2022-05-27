import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/send_otp_forgot_password_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/validate_otp_forgot_password_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/validate_otp_forgot_password_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';

import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../widgets/app_background_widget.dart';
import '../../widgets/loaders/primary_app_loader_widget.dart';

class SendOtpForgotPasswordScreen extends HookWidget {
  SendOtpForgotPasswordScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final _emailController = useTextEditingController();
    final _isFormValid = useState<bool>(false);
    return Scaffold(
        appBar: AppBar(),
        body: AppBackgroundWidget(
          childWidget: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Form(
                key: _formKey,
                onChanged: () {
                  _isFormValid.value = _formKey.currentState!.validate();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Level2Headline(text: 'Reset your password'),
                      const SizedBox(
                        height: 48,
                      ),
                      const Text(
                          'Enter your registered email below to verify your account and reset your password.'),
                      const SizedBox(
                        height: 36,
                      ),
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email address',
                          prefixIcon: Icon(Icons.person_outline_outlined),
                        ),
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'Email is required'),
                          EmailValidator(
                              errorText: 'Please Enter a valid email Address'),
                        ]),
                      ),
                      const SizedBox(
                        height: 56,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocConsumer<SendOtpForgotPasswordCubit,
                              SendOtpForgotPasswordState>(
                            listener: (context, state) {
                              if (state is SendOtpForgotPasswordSuccess) {
                                context
                                    .read<ValidateOtpForgotPasswordCubit>()
                                    .initialize();
                                Fluttertoast.showToast(msg: state.message);
                                Navigator.push(
                                    context,
                                    AppRouter.routeToPage(
                                        ValiditeOtpForgotPasswordScreen(
                                      email: _emailController.text,
                                    )));
                              }
                              if (state is SendOtpForgotPasswordFailed) {
                                
                                Fluttertoast.showToast(msg: state.message);
                              }
                            },
                            builder: (context, state) {
                              if (state is SendOtpForgotPasswordLoading) {
                                return const Center(
                                  child: PrimaryAppLoader(),
                                );
                              }
                              return ElevatedButton(
                                  onPressed: _isFormValid.value
                                      ? () {
                                          context
                                              .read<
                                                  SendOtpForgotPasswordCubit>()
                                              .sendOtpForgotPassword(
                                                  email: _emailController.text);
                                        }
                                      : null,
                                  child: Row(
                                    children: [
                                      Text('Verify Account'.toUpperCase()),
                                    ],
                                  ));
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              )),
        ));
  }
}
