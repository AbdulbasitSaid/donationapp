import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:idonatio/presentation/journeys/reset_password/cubit/validate_otp_forgot_password_cubit.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';
import 'package:idonatio/presentation/widgets/labels/level_4_headline.dart';
import 'package:line_icons/line_icons.dart';

import 'package:pinput/pinput.dart';

class ValiditeOtpForgotPasswordScreen extends HookWidget {
  const ValiditeOtpForgotPasswordScreen({
    Key? key,
    required this.email,
  }) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
          childWidget: SizedBox(
        width: MediaQuery.of(context).size.width,
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
            const SizedBox(
              height: 36,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Pinput(
                  length: 6,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
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
            BlocConsumer<ValidateOtpForgotPasswordCubit,
                ValidateOtpForgotPasswordState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                return TextButton(
                    onPressed: state is ValidateOtpForgotPasswordLoading
                        ? null
                        : () {},
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
                        state is ValidateOtpForgotPasswordLoading
                            ? const CircularProgressIndicator.adaptive()
                            : const SizedBox.shrink(),
                      ],
                    ));
              },
            )
          ],
        ),
      )),
    );
  }
}
