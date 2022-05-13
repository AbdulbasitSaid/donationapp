import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/presentation/widgets/buttons/logout_button_widget.dart';

import '../../themes/app_color.dart';
import '../../widgets/dialogs/app_error_dailog.dart';
import '../../widgets/forms/edit_password_form_widget.dart';
import 'cubit/change_password_cubit.dart';

class EditPasswordScreen extends StatelessWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [LogoutButton()],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(gradient: AppColor.appBackground),
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit your password',
                style: Theme.of(context).textTheme.headline2,
              ),
              const SizedBox(
                height: 32,
              ),
              const Text(
                  'Enter the password you’d like to use with your account below.'),
              const SizedBox(
                height: 32,
              ),
              BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                builder: (context, state) {
                  if (state is ChangePasswordFailed) {
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 24),
                      child: AppErrorDialogWidget(
                          title: state.appErrorType.toString(),
                          message: state.errorMessage),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const EditPasswordFormWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
