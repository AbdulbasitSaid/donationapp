import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/data/models/user_models/donor_model.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/data/models/user_models/user_model.dart';

import 'package:idonatio/di/get_it.dart' as get_it;
import 'package:idonatio/presentation/bloc/simple_bloc_observer.dart';

import 'presentation/journeys/i_donation_app.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Stripe.publishableKey =
      "pk_test_51HSkkpGqiuzQS1fhELMeWYfVhxf2olIBOiUabSjrML7zaqCwxBpjuiv63MUU1XDE45HkWa9l7M1bCQyuaRzbmF2V00RqyUZAyG";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';

  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());

  BlocOverrides.runZoned(
    () async {
    

      // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      // log('Running on ${iosInfo.utsname.machine}');
      await HiveInitiator.initialize();

      runApp(
        const IdonatioApp(),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class HiveInitiator {
  HiveInitiator._();
  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DonorModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserDataAdapter());
  }
}
