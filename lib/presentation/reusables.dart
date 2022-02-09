import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../common/words.dart';
import '../domain/entities/app_error.dart';

BoxDecoration defaultContainerDecoration() {
  return const BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8)));
}

String getCurrencySymbol(String code, BuildContext context) {
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(
      locale: locale.toString(), name: code.toUpperCase());
  return format.currencySymbol;
}

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return TranslationConstants.noNetwork;
      case AppErrorType.api:
      case AppErrorType.database:
        return 'Check that you have entered a correct and registered email address and password.';
      default:
        return 'Check that you have entered a correct and registered email address and password.';
    }
  }