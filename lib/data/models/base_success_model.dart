import 'dart:convert';

class SuccessModel {
  SuccessModel({
    required this.status,
    required this.message,
  });

  String status;
  String message;

  factory SuccessModel.fromRawJson(String str) =>
      SuccessModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SuccessModel.fromJson(Map<String, dynamic> json) => SuccessModel(
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}
