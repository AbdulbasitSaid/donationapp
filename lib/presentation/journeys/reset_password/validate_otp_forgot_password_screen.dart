import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/resend_otp_forgot_password_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/validate_otp_forgot_password_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/reset_password_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_error_dailog.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:line_icons/line_icons.dart';

import 'package:pinput/pinput.dart';

import '../../widgets/loaders/primary_app_loader_widget.dart';

class ValiditeOtpForgotPasswordScreen extends HookWidget {
  final _formKey = GlobalKey<FormState>();

  ValiditeOtpForgotPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    final otpController = useTextEditingController();
    final isOptComplted = useState<bool>(false);

    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
          childWidget: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Level2Headline(text: 'Reset your password'),
                const SizedBox(
                  height: 36,
                ),
                const Level4Headline(text: 'Enter verification code'),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                    'We have sent a verification message to your email address. Click the link in the message to verify your email or enter the 6-digit code we sent you below.'),

                BlocBuilder<ValidateOtpForgotPasswordCubit,
                    ValidateOtpForgotPasswordState>(
                  builder: (context, state) {
                    if (state is ValidateOtpForgotPasswordFailed) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: AppErrorDialogWidget(
                            title: 'Incorrect verification code',
                            message: state.message),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(
                  height: 36,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                      controller: otpController,
                      // forceErrorState: true,
                      errorText: 'Error',
                      length: 6,

                      onCompleted: (pin) {
                        isOptComplted.value = true;
                      },
                      defaultPinTheme: PinTheme(
                        width: MediaQuery.of(context).size.width * .12,
                        height: MediaQuery.of(context).size.height * .07,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: const Color.fromRGBO(234, 239, 243, 1)),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 42,
                ),
                //resend code
                BlocConsumer<ResendOtpForgotPasswordCubit,
                    ResendOtpForgotPasswordState>(
                  listener: (context, state) {
                    if (state is ResendOtpForgotPasswordSuccess) {
                      Fluttertoast.showToast(msg: state.message);
                      otpController.clear();
                      isOptComplted.value = false;
                    }
                    if (state is ResendOtpForgotPasswordFailed) {
                      Fluttertoast.showToast(msg: state.message);
                      otpController.clear();
                      isOptComplted.value = false;
                    }
                  },
                  builder: (context, state) {
                    return Row(
                      children: [
                        TextButton(
                            onPressed: state is ResendOtpForgotPasswordLoading
                                ? null
                                : () {
                                    context
                                        .read<ResendOtpForgotPasswordCubit>()
                                        .sendOtpForgotPassword(email: email);
                                  },
                            child: Row(
                              children: [
                                const Icon(LineIcons.alternateRedo),
                                const SizedBox(
                                  width: 16,
                                ),
                                const Text('Resend code'),
                                const SizedBox(
                                  width: 16,
                                ),
                                state is ResendOtpForgotPasswordLoading
                                    ? const PrimaryAppLoader()
                                    : const SizedBox.shrink(),
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    );
                  },
                ),
                const Text(
                    'Please allow a few minutes for delivery and check the Junk / Spam folder of your email inbox before requesting a new code.'),

                const SizedBox(
                  height: 48,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BlocConsumer<ValidateOtpForgotPasswordCubit,
                        ValidateOtpForgotPasswordState>(
                      listener: ((context, state) => {
                            if (state is ValidateOtpForgotPasswordSuccess)
                              {
                                Navigator.push(
                                    context,
                                    AppRouter.routeToPage(
                                        const ResetPasswordScreen()))
                              }
                            else if (state is ValidateOtpForgotPasswordFailed)
                              {
                                otpController.clear(),
                                isOptComplted.value = false,
                              }
                          }),
                      builder: (context, state) {
                        return state is ValidateOtpForgotPasswordLoading
                            ? const PrimaryAppLoader()
                            : ElevatedButton(
                                onPressed: isOptComplted.value
                                    ? () {
                                        log(otpController.text);
                                        log(email);
                                        context
                                            .read<
                                                ValidateOtpForgotPasswordCubit>()
                                            .validateOtpForgotPassword(
                                                otp: otpController.text,
                                                email: email);
                                      }
                                    : null,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Verify Account'.toUpperCase(),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    const Icon(LineIcons.arrowRight)
                                  ],
                                ));
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
