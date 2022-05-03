import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:idonatio/di/get_it.dart' as get_it;
import 'package:idonatio/presentation/bloc/simple_bloc_observer.dart';

import 'common/hive_initiator.dart';
import 'presentation/journeys/i_donation_app.dart';
// import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsBinding widgetsBinding =
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      "pk_test_51HSkkpGqiuzQS1fhELMeWYfVhxf2olIBOiUabSjrML7zaqCwxBpjuiv63MUU1XDE45HkWa9l7M1bCQyuaRzbmF2V00RqyUZAyG";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';

  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());

  BlocOverrides.runZoned(
    () async {
      await HiveInitiator.initialize();
      runApp(
        const IdonatioApp(),
      );
    },
    blocObserver: SimpleBlocObserver(),
  );
}
