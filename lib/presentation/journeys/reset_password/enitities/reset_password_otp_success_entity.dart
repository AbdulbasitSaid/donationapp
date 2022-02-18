import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

ResetPasswordOtpSuccessEntity resetPasswordOtpSuccessEntityFromJson(
        String str) =>
    ResetPasswordOtpSuccessEntity.fromJson(json.decode(str));

String resetPasswordOtpSuccessEntityToJson(
        ResetPasswordOtpSuccessEntity data) =>
    json.encode(data.toJson());

class ResetPasswordOtpSuccessEntity extends Equatable {
  const ResetPasswordOtpSuccessEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final ResetPasswordOtpSuccessEntityDataData data;

  factory ResetPasswordOtpSuccessEntity.fromJson(Map<String, dynamic> json) =>
      ResetPasswordOtpSuccessEntity(
        status: json["status"],
        message: json["message"],
        data: ResetPasswordOtpSuccessEntityDataData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };

  @override
  List<Object?> get props => [
        status,
        message,
        data.email,
        data.passwordResetToken,
      ];
}

class ResetPasswordOtpSuccessEntityDataData extends Equatable {
  ResetPasswordOtpSuccessEntityDataData({
    required this.email,
    required this.passwordResetToken,
  });

  final String email;
  final String passwordResetToken;

  factory ResetPasswordOtpSuccessEntityDataData.fromJson(
          Map<String, dynamic> json) =>
      ResetPasswordOtpSuccessEntityDataData(
        email: json["email"],
        passwordResetToken: json["password_reset_token"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password_reset_token": passwordResetToken,
      };

  @override
  List<Object?> get props => [email, passwordResetToken];
}
