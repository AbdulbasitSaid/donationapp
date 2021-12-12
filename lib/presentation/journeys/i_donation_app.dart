import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/enums.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/journeys/auth_guard.dart';
import 'package:idonatio/presentation/themes/app_theme_data.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authenticationLocalDataSource: getItInstance())
                ..add(const ChangeAuth(AuthStatus.appStarted)),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(getItInstance(), getItInstance()),
        ),
        
      ],
      child: MaterialApp(
        title: 'Idonation',
        theme: AppThemeData.appTheme(),
        home: const AuthGaurd(),
      ),
    );
  }
}
