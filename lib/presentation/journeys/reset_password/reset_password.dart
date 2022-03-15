import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/journeys/reset_password/bloc/resetpassword_bloc.dart';
import 'package:idonatio/presentation/journeys/reset_password/verification_code_screen.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/dialogs/app_loader_dialog.dart';
import 'package:idonatio/presentation/widgets/input_fields/email_form_field.dart';
import 'package:idonatio/presentation/widgets/labels/base_label_text.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

class ResetPasswordEmailScreen extends StatelessWidget {
  const ResetPasswordEmailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: AppBackgroundWidget(
        childWidget: SingleChildScrollView(
          child: Column(
            children: const [
              ResetPasswordEmailform(),
            ],
          ),
        ),
      ),
    );
  }
}

class ResetPasswordEmailform extends StatefulWidget {
  const ResetPasswordEmailform({Key? key}) : super(key: key);

  @override
  State<ResetPasswordEmailform> createState() => _ResetPasswordEmailformState();
}

class _ResetPasswordEmailformState extends State<ResetPasswordEmailform> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _emailController;
  @override
  void initState() {
    _emailController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResetpasswordBloc, ResetpasswordState>(
      listener: (context, state) {
        if (state is ResetpasswordLoadding) {
          showDialog(
              context: context,
              builder: (context) {
                return const AppLoader(
                  loadingMessage: 'Sending request please wait..',
                );
              });
        }
        if (state is ResetpasswordSuccess) {
          Navigator.of(context, rootNavigator: true).pop();
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.successMessage)));
          Navigator.push(
              context,
              AppRouter.routeToPage(ResetPasswordVerificationCodeScreen(
                email: _emailController.text,
              )));
        }
        if (state is ResetpasswordFailed) {
          Navigator.of(context, rootNavigator: true).pop();
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                    title: const Text('Failed to send OTP!'),
                    content: Text(state.errorMessage),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ));
        }
      },
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Level2Headline(text: "Reset your password"),
              const SizedBox(
                height: 48,
              ),
              const BaseLabelText(
                  text:
                      'Enter your registered email below to verify your account and reset your password.'),
              const SizedBox(
                height: 16,
              ),
              const SizedBox(
                height: 16,
              ),
              EmailField(
                emailController: _emailController,
                formKey: _formKey,
              ),
              const SizedBox(
                height: 48,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () => {
                            if (_formKey.currentState!.validate())
                              {
                                context.read<ResetpasswordBloc>().add(
                                    ValidateEmail(email: _emailController.text))
                              }
                          },
                      child: Row(
                        children: [
                          Text('Send otp to email'.toUpperCase()),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.arrow_forward_sharp,
                          )
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
