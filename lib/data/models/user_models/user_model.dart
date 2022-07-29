import 'package:hive/hive.dart';

import 'package:idonatio/data/models/user_models/donor_model.dart';

part 'user_model.g.dart';

@HiveType(typeId: 1)
class UserModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String email;
  @HiveField(2)
  final bool isActive;
  @HiveField(3)
  final DateTime? emailVerifiedAt;
  @HiveField(4)
  final String signupType;
  @HiveField(5)
  final DonorModel? donor;
  //
  UserModel({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.donor,
    required this.signupType,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        signupType: json['signup_type'],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        donor:
            json["donor"] == null ? null : DonorModel.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        'singup_type': signupType,
        "donor": donor!.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.isActive == isActive &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.signupType == signupType &&
        other.donor == donor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        isActive.hashCode ^
        emailVerifiedAt.hashCode ^
        signupType.hashCode ^
        donor.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, isActive: $isActive, emailVerifiedAt: $emailVerifiedAt, donor: $donor , signUpType: $signupType)';
  }

  bool get alwaysDonateAnonymosly {
    return donor == null
        ? false
        : donor!.shareBasicInfomation == true
            ? false
            : true;
  }

  UserModel copyWith({
    String? id,
    String? email,
    bool? isActive,
    DateTime? emailVerifiedAt,
    DonorModel? donor,
    String? signupType,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      donor: donor ?? this.donor,
      signupType: signupType ?? this.signupType,
    );
  }
}
