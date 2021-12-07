import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/di/get_it.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_theme_data.dart';

class IdonatioApp extends StatefulWidget {
  const IdonatioApp({Key? key}) : super(key: key);

  @override
  State<IdonatioApp> createState() => _IdonatioAppState();
}

class _IdonatioAppState extends State<IdonatioApp> {
  late LoginCubit _loginCubit;

  @override
  void initState() {
    _loginCubit = getItInstance<LoginCubit>();
    super.initState();
  }

  @override
  void dispose() {
    _loginCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>.value(
          value: _loginCubit,
        )
      ],
      child: MaterialApp(
        title: 'Idonation',
        theme: AppThemeData.appTheme(),
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: RouteList.login,
      ),
    );
  }
}
