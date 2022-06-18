import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../bloc/registration_steps/cubit/registration_steps_cubit.dart';
import '../../widgets/dialogs/app_error_dailog.dart';
import '../auth_guard.dart';
import 'register_form.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const RegistrationScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WillPopScope(
        onWillPop: () async {
          context.read<RegistrationStepsCubit>().resetStage();
          context.read<RegisterCubit>().reset();
          return true;
        },
        child: AppBackgroundWidget(
          childWidget: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const AspectRatio(
                  aspectRatio: 5 / 1,
                  child: Level2Headline(
                    text: TranslationConstants.register,
                  ),
                ),
                BlocConsumer<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    if (state is RegisterFailed) {
                      return AppErrorDialogWidget(
                        message: state.errorMessage,
                        title: 'Registration Failed',
                      );
                    }

                    return const SizedBox.shrink();
                  },
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.push(
                        context,
                        AppRouter.routeToPage(const AuthGaurd()),
                      );
                    } else {
                      const SizedBox.shrink();
                    }
                  },
                ),
                const RegisterForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}



//TODO: change button disable color
