import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:idonatio/data/models/payment_success_model.dart';

class RecentDoneesResponseModel {
  String status;
  String message;
  List<Donee> data;
  RecentDoneesResponseModel({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  String toString() =>
      'RecentDonees(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RecentDoneesResponseModel &&
        other.status == status &&
        other.message == message &&
        listEquals(other.data, data);
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'message': message,
      'data': data.map((x) => x.toMap()).toList(),
    };
  }

  factory RecentDoneesResponseModel.fromMap(Map<String, dynamic> map) {
    return RecentDoneesResponseModel(
      status: map['status'] ?? '',
      message: map['message'] ?? '',
      data: List<Donee>.from(map['data']?.map((x) => Donee.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecentDoneesResponseModel.fromJson(String source) =>
      RecentDoneesResponseModel.fromMap(json.decode(source));
}
