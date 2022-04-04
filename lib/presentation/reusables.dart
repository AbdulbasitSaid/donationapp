
import 'package:flutter/material.dart';
import 'package:idonatio/presentation/themes/app_color.dart';
import 'package:intl/intl.dart';

import '../domain/entities/app_error.dart';

BoxDecoration whiteContainerBackGround() {
  return const BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(8)));
}

BoxDecoration gradientBoxDecoration() {
  return const BoxDecoration(
    gradient: AppColor.appBackground,
  );
}

String getCurrencySymbol(String code, BuildContext context) {
  Locale locale = Localizations.localeOf(context);
  var format = NumberFormat.simpleCurrency(
      locale: locale.toString(), name: code.toUpperCase());
  return format.currencySymbol;
}

String getErrorMessage(AppErrorType appErrorType) {
  switch (appErrorType) {
    case AppErrorType.unProcessableEntity:
      return 'The request is unprocessable, often due to invalid parameters.';
    case AppErrorType.badRequest:
      return 'The request was unacceptable, often due the parameter provided by the client.';
    case AppErrorType.network:
      return 'Please check your internet';
    case AppErrorType.unauthorized:
      return 'No bearer token provided or an invalid bearer token was provided.';
    case AppErrorType.forbidden:
      return 'Authentication failed. This may occur when a wrong email or password is provided during login.';
    case AppErrorType.notFound:
      return 'The requested resource doesn\'t exist.';
    case AppErrorType.serveError:
      return 'Server error. Hopefully this will occur in rear cases.';
    case AppErrorType.serverNotAvailble:
      return 'Server not available at the moment please try again!! later';
    case AppErrorType.unExpected:
      return 'Unexpected error.';
    default:
      return 'Opps something went wrong';
  }
}


///
/// idonation plus amount before Stripe charges
///

//
// Future<DeviceInfoModel> getIosInfo(
//     DeviceInfoPlugin deviceInfoPlugin, NetworkInfo networkInfo) async {
//   final iosInfo = await deviceInfoPlugin.iosInfo;
//   final String ipInfo = await Ipify.ipv64();
//   log(iosInfo.toString());
//   return DeviceInfoModel(
//       platform: 'mobile',
//       deviceUid: iosInfo.identifierForVendor,
//       os: 'ios',
//       osVersion: iosInfo.systemVersion,
//       model: iosInfo.systemName,
//       ipAddress: ipInfo,
//       screenResolution: '1080p');
//   // final ios
// }

// Future<DeviceInfoModel> getAndroidInfo(
//     DeviceInfoPlugin deviceInfoPlugin, NetworkInfo networkInfo) async {
//   final androidInfo = await deviceInfoPlugin.androidInfo;
//   final String ipInfo = await Ipify.ipv64();
//   return DeviceInfoModel(
//       platform: 'mobile',
//       deviceUid: androidInfo.id,
//       os: 'android',
//       osVersion: androidInfo.version.baseOS,
//       model: androidInfo.model,
//       ipAddress: ipInfo,
//       screenResolution: androidInfo.display);
  // final ios

