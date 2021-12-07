import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/router/app_router.dart';
import 'package:idonatio/presentation/themes/app_theme_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  runApp(const IdonatioApp());
}

class IdonatioApp extends StatelessWidget {
  const IdonatioApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idonation',
      theme: AppThemeData.appTheme(),
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: RouteList.home,
    );
  }
}
