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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      "pk_test_51HSkkpGqiuzQS1fhELMeWYfVhxf2olIBOiUabSjrML7zaqCwxBpjuiv63MUU1XDE45HkWa9l7M1bCQyuaRzbmF2V00RqyUZAyG";
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  unawaited(
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]));
  unawaited(get_it.init());

  await HiveInitiator.initialize();
  // UserLocalDataSource().saveUserData(
  //   UserData(
  //       token: 'tokenzzor',
  //       tokenType: '',
  //       expiresIn: 5,
  //       isDeviceSaved: false,
  //       user: UserModel(
  //           donor: DonorModel(
  //               address: 'ddd',
  //               city: 'null',
  //               countryId: 'null',
  //               firstName: '',
  //               giftAidEnabled: false,
  //               id: 'dddd',
  //               isOnboarded: false,
  //               lastName: '',
  //               paymentMethod: null,
  //               phoneNumber: '',
  //               phoneReceiveSecurityAlert: true,
  //               phoneVerifiedAt: null,
  //               postalCode: null,
  //               sendMarketingMail: false,
  //               stripeCustomerId: '',
  //               title: '',
  //               userId: ''),
  //           email: '',
  //           emailVerifiedAt: null,
  //           id: '',
  //           isActive: true),
  //       stripeCustomerId: 'stripeCustomerId'),
  // );
  BlocOverrides.runZoned(
    () => runApp(
      const IdonatioApp(),
    ),
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
