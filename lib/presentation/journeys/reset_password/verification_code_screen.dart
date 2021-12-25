import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/reset_password/bloc/resetpassword_bloc.dart';
import 'package:idonatio/presentation/journeys/reset_password/new_password.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_loader_dialog.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';

class ResetPasswordVerificationCodeScreen extends StatelessWidget {
  const ResetPasswordVerificationCodeScreen({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Level2Headline(text: 'Reset your password'),
            const SizedBox(
              height: 48,
            ),
            const Level4Headline(text: 'Enter verification code'),
            const SizedBox(
              height: 32,
            ),
            const BaseLabelText(
              text:
                  'We have sent a verification message to your email address.Click the link in the message to verify your email or enter the 6-digit code we sent you below.',
            ),
            const SizedBox(
              height: 32,
            ),
            ResetPasswordVerificationCodeForm(
              email: email,
            ),
          ],
        ),
      )),
    );
  }
}

class ResetPasswordVerificationCodeForm extends StatefulWidget {
  const ResetPasswordVerificationCodeForm({Key? key, required this.email})
      : super(key: key);
  final String email;
  @override
  _ResetPasswordVerificationCodeFormState createState() =>
      _ResetPasswordVerificationCodeFormState();
}

class _ResetPasswordVerificationCodeFormState
    extends State<ResetPasswordVerificationCodeForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  late final TextEditingController _otpController;

  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordBloc, ResetpasswordState>(
      listener: (context, state) {
        if (state is ResetpasswordSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.successMessage)));
          Navigator.push(
              context, AppRouter.routeToPage(const NewPasswordScreen()));
        }
        if (state is ResetpasswordLoadding) {
          Navigator.of(context, rootNavigator: true).pop();
          showDialog(
              context: context,
              builder: (context) {
                return const AppLoader(
                  loadingMessage: 'Sending request please wait..',
                );
              });
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            children: [
              state is ResetpasswordFailed
                  ? AppErrorDialogWidget(
                      title: state.errorTitle, message: state.errorMessage)
                  : const SizedBox.shrink(),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                controller: _otpController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Opt is required'),
                ]),
                decoration: const InputDecoration(
                  hintText: 'OTP Code(123456)',
                  labelText: 'OTP Code',
                  prefixIcon: Icon(Icons.code),
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                onPressed: () {
                  context
                      .read<ResetpasswordBloc>()
                      .add(ValidateEmail(email: widget.email));
                },
                child: Row(
                  children: const [
                    Icon(Icons.restart_alt_sharp),
                    SizedBox(
                      width: 8,
                    ),
                    Text('Resend code'),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              const BaseLabelText(
                  text:
                      'Please allow a few minutes for delivery and check the Junk / Spam folder of your email inbox before requesting a new code.'),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<ResetpasswordBloc>().add(SendOtp(
                              otp: _otpController.text, email: widget.email));
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Verify Account'.toUpperCase(),
                          ),
                          const Icon(Icons.chevron_right_rounded)
                        ],
                      )),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
