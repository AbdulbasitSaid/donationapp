import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/data/data_sources/authentication_local_datasource.dart';
import 'package:idonatio/data/repository/authentication_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/bloc/register/register_cubit.dart';
import 'package:idonatio/presentation/bloc/registration_steps/cubit/registration_steps_cubit.dart';
import 'package:idonatio/presentation/journeys/email_verification/cubit/verification_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/getcountreis_cubit.dart';
import 'package:idonatio/presentation/journeys/onboarding/cubit/onboardingdataholder_cubit.dart';
import 'package:idonatio/presentation/journeys/reset_password/bloc/resetpassword_bloc.dart';

import 'package:idonatio/presentation/themes/app_theme_data.dart';

import 'auth_guard.dart';
import 'onboarding/cubit/onboarding_cubit.dart';

class IdonatioApp extends StatefulWidget {
  const IdonatioApp({Key? key}) : super(key: key);

  @override
  State<IdonatioApp> createState() => _IdonatioAppState();
}

class _IdonatioAppState extends State<IdonatioApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authenticationLocalDataSource: getItInstance())
                  ..add(const ChangeAuth(AuthStatus.appStarted)),
          ),
          BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(
              getItInstance(),
            ),
          ),
          BlocProvider<RegisterCubit>(
            create: (context) =>
                RegisterCubit(getItInstance(), getItInstance()),
          ),
          BlocProvider<LoadingCubit>(
            create: (context) => LoadingCubit(),
          ),
          BlocProvider<VerificationCubit>(
            create: (context) =>
                VerificationCubit(getItInstance(), getItInstance()),
          ),
          BlocProvider<OnboardingCubit>(
            create: (context) => OnboardingCubit(getItInstance()),
          ),
          BlocProvider<RegisterCubit>(
            create: (context) =>
                RegisterCubit(getItInstance(), getItInstance()),
          ),
          BlocProvider<RegistrationStepsCubit>(
            create: (context) => RegistrationStepsCubit(),
          ),
          BlocProvider<ResetpasswordBloc>(
            create: (context) => ResetpasswordBloc(getItInstance()),
          ),
          BlocProvider<OnboardingdataholderCubit>(
              create: (context) => OnboardingdataholderCubit()),
          BlocProvider<GetcountreisCubit>(
              create: (context) => GetcountreisCubit(getItInstance()))
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(
              create: (context) => AuthenticationLocalDataSource(),
            ),
            RepositoryProvider(
              create: (context) =>
                  AuthenticationRepository(getItInstance(), getItInstance()),
            ),
          ],
          child: MaterialApp(
            title: 'Idonation',
            theme: AppThemeData.appTheme(),
            home: const AuthGaurd(),
            // home: const GiftAidScreen(),
          ),
        ),
      ),
    );
  }
}
