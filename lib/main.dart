import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/di/get_it.dart' as get_it;
import 'package:idonatio/presentation/bloc/simple_bloc_observer.dart';

import 'presentation/journeys/i_donation_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());
  await Hive.initFlutter();
  // AuthenticationRepository(get_it.getItInstance(), get_it.getItInstance())
  //     .verifyEmail(OtpRequestParameter(otp: '123456').toJson());
  // await AuthenticationLocalDataSource().deleteUserData();
  BlocOverrides.runZoned(
    () => runApp(
      const IdonatioApp(),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}
