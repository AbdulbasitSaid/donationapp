import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
