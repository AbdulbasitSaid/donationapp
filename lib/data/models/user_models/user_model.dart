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
  final DonorModel donor;
  //
  UserModel({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.donor,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        donor: DonorModel.fromJson(json["donor"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "is_active": isActive,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "donor": donor.toJson(),
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.isActive == isActive &&
        other.emailVerifiedAt == emailVerifiedAt &&
        other.donor == donor;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        isActive.hashCode ^
        emailVerifiedAt.hashCode ^
        donor.hashCode;
  }

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, isActive: $isActive, emailVerifiedAt: $emailVerifiedAt, donor: $donor)';
  }

  UserModel copyWith({
    String? id,
    String? email,
    bool? isActive,
    DateTime? emailVerifiedAt,
    DonorModel? donor,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      isActive: isActive ?? this.isActive,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      donor: donor ?? this.donor,
    );
  }
}
