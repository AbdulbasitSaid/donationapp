import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/presentation/bloc/registration_steps/cubit/registration_steps_cubit.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import 'register_form.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: AppBackgroundWidget(
          childWidget: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const AspectRatio(
                aspectRatio: 5 / 1,
                child: Level2Headline(
                  text: TranslationConstants.register,
                ),
              ),
              BlocProvider<RegistrationStepsCubit>(
                create: (context) => RegistrationStepsCubit(),
                child: const RegisterForm(),
              )
            ],
          ),
        ),
      ),
    );
  }
}



//TODO: change button disable color
