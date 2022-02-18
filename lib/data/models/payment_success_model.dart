// To parse this JSON data, do
//
//     final paymentSuccessModel = paymentSuccessModelFromMap(jsonString);

import 'dart:convert';

import 'package:idonatio/data/models/donation_models/donantion_dart.dart';

class PaymentSuccessModel {
  PaymentSuccessModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final DonationData data;

  factory PaymentSuccessModel.fromJson(String str) =>
      PaymentSuccessModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentSuccessModel.fromMap(Map<String, dynamic> json) =>
      PaymentSuccessModel(
        status: json["status"],
        message: json["message"],
        data: DonationData.fromJson(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}
