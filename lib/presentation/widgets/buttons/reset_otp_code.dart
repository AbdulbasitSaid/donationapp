import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/presentation/widgets/buttons/cubit/resend_otp_cubit.dart';

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
        if (state is ResendOtpLoading) {
          return TextButton(
            onPressed: null,
            child: Row(
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
                SizedBox(
                  width: 16,
                ),
                CircularProgressIndicator()
              ],
            ),
          );
        }
        return TextButton(
          onPressed: () {
            context.read<ResendOtpCubit>().resendOptCode();
          },
          child: Row(
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
        );
      },
    );
  }
}
