import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/common/words.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/widgets/app_background_widget.dart';
import 'package:idonatio/presentation/widgets/labels/level_2_heading.dart';

import '../../../enums.dart';
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
      body: AppBackgroundWidget(
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
                buildWhen: (previous, current) => current is RegisterFailed,
                builder: (context, state) {
                  if (state is RegisterFailed) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.cancel_outlined),
                        title: const Text('Registration failed'),
                        subtitle: Text(state.errorMessage),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
                listenWhen: (previous, current) => current is RegisterSuccess,
                listener: (context, state) {
                  context
                      .read<AuthBloc>()
                      .add(const ChangeAuth(AuthStatus.authenticated));
                  Navigator.push(
                    context,
                    AppRouter.routeToPage(const AuthGaurd()),
                  );
                },
              ),
              const RegisterForm()
            ],
          ),
        ),
      ),
    );
  }
}



//TODO: change button disable color
