import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/di/get_it.dart' as get_it;
import 'package:idonatio/presentation/bloc/simple_bloc_observer.dart';

import 'data/data_sources/authentication_local_datasource.dart';
import 'presentation/journeys/i_donation_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());
  await Hive.initFlutter();
  // AuthenticationLocalDataSource().saveUserData(LocalUserObject(
  //     token: 'my toking is dope', isBoarded: true, isEmailVerified: true));
  var token = await AuthenticationLocalDataSource().getUser();
  print(token.token);

  // AuthenticationRepository(get_it.getItInstance(), get_it.getItInstance())
  //     .loginUser(LoginRequestParams(
  //   email: 'pap@gmail.com',
  //   password: 'password',
  //   platform: 'mobile',
  //   deviceUid: '272892-08287-398903903',
  //   os: 'ios',
  //   osVersion: '190',
  //   model: 'samsung s281',
  //   ipAddress: '198.0.2.3',
  //   screenResolution: '1080p',
  // ).toJson());
  BlocOverrides.runZoned(
    () => runApp(
      const IdonatioApp(),
    ),
    blocObserver: SimpleBlocObserver(),
  );
}
