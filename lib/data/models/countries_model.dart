import 'dart:convert';

import 'package:equatable/equatable.dart';

class CountriesModel extends Equatable {
  final String status;
  final String message;

  final List<CountryData> countryData;
  const CountriesModel(
      {required this.countryData, required this.message, required this.status});

  @override
  List<Object?> get props => [status, message, countryData];

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'countryData': countryData.map((x) => x.toMap()).toList(),
    };
  }

  factory CountriesModel.fromMap(Map<String, dynamic> map) {
    return CountriesModel(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      countryData: List<CountryData>.from(
          map['data']?.map((x) => CountryData.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CountriesModel.fromJson(String source) =>
      CountriesModel.fromMap(json.decode(source));
}

class CountryData extends Equatable {
  final String id;
  final String name;
  final String countryCode;
  final String currencyCode;
  final bool isVisible;
  const CountryData({
    required this.countryCode,
    required this.currencyCode,
    required this.id,
    required this.isVisible,
    required this.name,
  });

  @override
  List<Object?> get props => [id, countryCode, currencyCode, isVisible, name];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'country_code': countryCode,
      'currency_code': currencyCode,
      'isVisible': isVisible,
    };
  }

  factory CountryData.fromMap(Map<String, dynamic> map) {
    return CountryData(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      countryCode: map['country_code'] ?? '',
      currencyCode: map['currency_code'] ?? '',
      isVisible: map['isVisible'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryData.fromJson(String source) =>
      CountryData.fromMap(json.decode(source));
}
