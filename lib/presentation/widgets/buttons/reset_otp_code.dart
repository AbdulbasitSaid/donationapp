import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/widgets/buttons/cubit/resend_otp_cubit.dart';
import 'package:line_icons/line_icons.dart';

import '../../themes/app_color.dart';

class ResendOTPCode extends StatelessWidget {
  const ResendOTPCode({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResendOtpCubit, ResendOtpState>(
      listener: (context, state) {
        if (state is ResendOtpFailed) {
          Fluttertoast.showToast(
              msg: '${state.errorMessage}: please try again');
        }
        if (state is ResendOtpSuccess) {
          Fluttertoast.showToast(
              msg: '${state.successModel.message}: please try again');
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            TextButton(
              onPressed: state is ResendOtpLoading
                  ? null
                  : () {
                      context.read<ResendOtpCubit>().resendOptCode();
                    },
              child: Row(
                children: [
                  const Icon(
                    LineIcons.alternateRedo,
                    color: AppColor.basePrimary,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Text(
                    'Resend code',
                    style: TextStyle(color: AppColor.basePrimary),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  state is ResendOtpLoading
                      ? const Center(child: CircularProgressIndicator())
                      : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
