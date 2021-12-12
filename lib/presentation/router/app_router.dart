import 'package:flutter/material.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/journeys/authentication/start_screen.dart';
import 'package:idonatio/presentation/journeys/email_verification/email_varification_screen.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/login/login_screen.dart';
import 'package:idonatio/presentation/journeys/login/varify_login.dart';
import 'package:idonatio/presentation/journeys/onboarding/data_preference_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/home_address_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/enable_gift_aid_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/journeys/onboarding/payment_method_screen.dart';
import 'package:idonatio/presentation/journeys/registration/registration_screen.dart';

class AppRouter {
  AppRouter._();
  static MaterialPageRoute<dynamic> routeToPage(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
