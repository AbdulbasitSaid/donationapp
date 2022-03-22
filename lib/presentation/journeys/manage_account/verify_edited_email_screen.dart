import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:idonatio/presentation/journeys/email_verification/cubit/verification_cubit.dart';

import '../../../di/get_it.dart';
import '../../../enums.dart';
import '../../reusables.dart';
import '../../router/app_router.dart';
import '../../widgets/buttons/reset_otp_code.dart';
import '../../widgets/labels/level_2_heading.dart';
import '../auth_guard.dart';

import '../user/cubit/user_cubit.dart';

class VerifyEdittedEmailScreen extends StatefulWidget {
  const VerifyEdittedEmailScreen({Key? key}) : super(key: key);

  @override
  _VerifyEdittedEmailScreenState createState() =>
      _VerifyEdittedEmailScreenState();
}

class _VerifyEdittedEmailScreenState extends State<VerifyEdittedEmailScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _enableVerificationButton = false;
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
              padding: EdgeInsets.all(
                16,
              ),
              child: Level2Headline(text: 'Verify your email address'),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'We have sent a verification message to your email address.Click the link in the message to verify your email or enter the 6-digit code we sent you below.',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                onChanged: (){
                  setState(() {
                    _enableVerificationButton = _formKey.currentState!.validate();
                  });
                },
                key: _formKey,
                child: TextFormField(
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
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: ResendOTPCode(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                  'Please allow a few minutes for delivery and check the Junk / Spam folder of your email inbox before requesting a new code.'),
            ),
            const SizedBox(
              height: 32,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocConsumer<VerificationCubit, VerificationState>(
                  listener: (context, state) {
                    if (state is VerificationFailure) {
                      Fluttertoast.showToast(msg: state.errorMessage);
                    }
                    if (state is VerificationSuccess) {
                      context.read<UserCubit>().setUserState(
                          getItInstance(), AuthStatus.authenticated);
                      Navigator.push(
                          context, AppRouter.routeToPage(const AuthGaurd()));
                    }
                  },
                  builder: (context, state) {
                    if (state is VerificationLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      return ElevatedButton(
                        onPressed:_enableVerificationButton? () async {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<VerificationCubit>()
                                .verifyOtp(_otpController.text);
                          }
                        }:null,
                        child: const Text('Verify Email'),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
