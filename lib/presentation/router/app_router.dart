import 'package:flutter/material.dart';
import 'package:idonatio/common/route_list.dart';
import 'package:idonatio/presentation/journeys/authentication/un_authenticated.dart';
import 'package:idonatio/presentation/journeys/email_verification/email_varification_screen.dart';
import 'package:idonatio/presentation/journeys/home.dart';
import 'package:idonatio/presentation/journeys/login/login_screen.dart';
import 'package:idonatio/presentation/journeys/login/varify_login.dart';
import 'package:idonatio/presentation/journeys/onboarding/onboarding_screen.dart';
import 'package:idonatio/presentation/journeys/registration/registration_screen.dart';

class AppRouter {
  static Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteList.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case RouteList.unAuthenticated:
        return MaterialPageRoute(builder: (_) => const UnAuthenticated());
      case RouteList.register:
        return MaterialPageRoute(builder: (_) => const RegistrationScreen());
      case RouteList.verifyEmail:
        return MaterialPageRoute(
            builder: (_) => const EmailVerificationScreen());
      case RouteList.verifyLogin:
        return MaterialPageRoute(builder: (_) => const VerifyLoginScreen());
      case RouteList.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case RouteList.onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());
      default:
        {
          return MaterialPageRoute(builder: (_) => const UnAuthenticated());
        }
    }
  }
}
