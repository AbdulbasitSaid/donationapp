import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/presentation/bloc/app_session_manager_bloc.dart';

import 'package:idonatio/presentation/themes/app_theme_data.dart';

import '../bloc/referesh_timer_bloc.dart';
import 'auth_guard.dart';

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
    final appSessionState = context.watch<AppSessionManagerBloc>().state;
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => UserLocalDataSource(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(getItInstance(), getItInstance()),
        ),
      ],
      child: Listener(
        onPointerDown: (event) {
          if (appSessionState is AppSessionManagerInProgress) {
            log('Session timer is counting');
            context.read<AppSessionManagerBloc>().add(const AppSessionReset());
          }
          log('I love it when you touch me!');
        },
        child: MaterialApp(
          title: 'Idonation',
          theme: AppThemeData.appTheme(),
          home: BlocListener<RefereshTimerBloc, RefereshTimerState>(
            listener: (context, state) {
              if (state is RefereshTimerRunComplete) {
                log('completed timer');
                context
                    .read<RefereshTimerBloc>()
                    .add(const RefereshTimerReset());
              }
            },
            child: const AuthGaurd(),
          ),
        ),
      ),
    );
  }
}
