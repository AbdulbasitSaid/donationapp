import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/journeys/email_verification/cubit/verification_cubit.dart';
import 'package:idonatio/presentation/journeys/user/cubit/user_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/loaders/primary_app_loader_widget.dart';
import 'package:pinput/pinput.dart';

import '../../widgets/buttons/reset_otp_code.dart';

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: const SingleChildScrollView(
          child: AppBackgroundWidget(
            childWidget: VerifyEmailForm(),
          ),
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
              'Register',
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
            'We have sent a verification message to your email address.',
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Click the link in the message to verify your email or enter the 6-digit code we sent you below.',
          ),
          const SizedBox(
            height: 16,
          ),
          Pinput(
            pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            controller: _otpController,
            // forceErrorState: true,
            errorText: 'Error',
            length: 6,

            onCompleted: (pin) {
              setState(() {});
            },
            defaultPinTheme: PinTheme(
              width: MediaQuery.of(context).size.width * .12,
              height: MediaQuery.of(context).size.height * .07,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          const ResendOTPCode(),
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
              if (state is VerificationFailure) {
                Fluttertoast.showToast(msg: state.errorMessage);
              }
              if (state is VerificationSuccess) {
                context
                    .read<UserCubit>()
                    .setUserState(getItInstance(), AuthStatus.authenticated);
                Navigator.push(
                    context, AppRouter.routeToPage(const AuthGaurd()));
              }
            },
            builder: (context, state) {
              if (state is VerificationLoading) {
                return const Center(
                  child: PrimaryAppLoader(),
                );
              } else {
                return ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<VerificationCubit>()
                          .verifyOtp(_otpController.text);
                    }
                  },
                  child: Text('Verify Email'.toUpperCase()),
                );
              }
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
