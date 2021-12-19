import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/journeys/email_verification/cubit/verification_cubit.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

import '../../../enums.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: AppBackgroundWidget(
          childWidget: VerifyEmailForm(),
        ),
      ),
    );
  }
}

class VerifyEmailForm extends StatefulWidget {
  const VerifyEmailForm({
    Key? key,
  }) : super(key: key);

  @override
  State<VerifyEmailForm> createState() => _VerifyEmailFormState();
}

class _VerifyEmailFormState extends State<VerifyEmailForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _otpController;
  @override
  void initState() {
    _otpController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _otpController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 4 / 1,
            child: Text(
              'Verify',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Text(
            'Verify your email',
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'We have sent a verification message to your email address.Click the link in the message to verify your email or enter the 6-digit code we sent you below.',
          ),
          const SizedBox(
            height: 16,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            controller: _otpController,
            validator: MultiValidator([
              RequiredValidator(errorText: 'Opt is required'),
            ]),
            onChanged: (value) {
              _formKey.currentState!.validate();
            },
            decoration: const InputDecoration(
              hintText: 'OTP Code(123456)',
              labelText: 'OTP Code',
              prefixIcon: Icon(Icons.code),
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: const [
          //     OTPItem(),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     OTPItem(),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     OTPItem(),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     OTPItem(),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     OTPItem(),
          //     SizedBox(
          //       width: 8,
          //     ),
          //     OTPItem(),
          //   ],
          // ),
          const SizedBox(
            height: 32,
          ),
          Row(
            children: const [
              Flexible(
                child: Icon(
                  Icons.restart_alt,
                  color: AppColor.basePrimary,
                ),
              ),
              Text(
                'Resend code',
                style: TextStyle(color: AppColor.basePrimary),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          const Text(
            'Please allow a few minutes for delivery and check the Junk / Spam folder of your email inbox before requesting a new code.',
          ),
          const SizedBox(
            height: 32,
          ),
          BlocConsumer<VerificationCubit, VerificationState>(
            listener: (context, state) {
              if (state is VerificationSuccess) {
                context
                    .read<AuthBloc>()
                    .add(const ChangeAuth(AuthStatus.verifiedEmail));
              }
            },
            builder: (context, state) {
              return ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<VerificationCubit>()
                        .verifyOtp(_otpController.text);
                  }
                },
                child: const Text('Verify Email'),
              );
            },
          ),
        ],
      ),
    );
  }
}

class OTPItem extends StatelessWidget {
  const OTPItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Flexible(
        child: TextField(
      keyboardType: TextInputType.number,
      maxLength: 1,
    ));
  }
}
