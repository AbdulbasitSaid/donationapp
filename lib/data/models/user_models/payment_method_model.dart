// To parse this JSON data, do
//
//     final paymentMethods = paymentMethodsFromMap(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

class PaymentMethodsModel {
  PaymentMethodsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final List<PaymentMethodDatum> data;

  factory PaymentMethodsModel.fromJson(String str) =>
      PaymentMethodsModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethodsModel.fromMap(Map<String, dynamic> json) =>
      PaymentMethodsModel(
        status: json["status"],
        message: json["message"],
        data: List<PaymentMethodDatum>.from(
            json["data"].map((x) => PaymentMethodDatum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };

  @override
  String toString() =>
      'PaymentMethodsModel(status: $status, message: $message, data: $data)';
}

class PaymentMethodDatum extends Equatable {
  const PaymentMethodDatum({
    required this.id,
    required this.brand,
    required this.country,
    required this.expMonth,
    required this.expYear,
    required this.cardLastFourDigits,
  });

  final String id;
  final String brand;
  final String country;
  final int expMonth;
  final String cardLastFourDigits;
  final int expYear;

  factory PaymentMethodDatum.fromJson(String str) =>
      PaymentMethodDatum.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PaymentMethodDatum.fromMap(Map<String, dynamic> json) =>
      PaymentMethodDatum(
        id: json["id"],
        brand: json["brand"],
        country: json["country"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        cardLastFourDigits: json["card_last_four_digits"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "brand": brand,
        "country": country,
        "exp_month": expMonth,
        "exp_year": expYear,
        "card_last_four_digits": cardLastFourDigits,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PaymentMethodDatum &&
        other.id == id &&
        other.brand == brand &&
        other.country == country &&
        other.expMonth == expMonth &&
        other.cardLastFourDigits == cardLastFourDigits &&
        other.expYear == expYear;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        brand.hashCode ^
        country.hashCode ^
        expMonth.hashCode ^
        cardLastFourDigits.hashCode ^
        expYear.hashCode;
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        brand,
        country,
        expMonth,
        cardLastFourDigits,
        expYear,
      ];
}
