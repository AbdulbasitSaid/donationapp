import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/business_logic/registration_steps/cubit/registration_steps_cubit.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';

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
              AspectRatio(
                aspectRatio: 4 / 1,
                child: Text(
                  TranslationConstants.register,
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(fontWeight: FontWeight.w600),
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
