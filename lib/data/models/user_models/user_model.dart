import '../profile/profile_seccess_model.dart';

class User {
  final String id;
  final String email;
  final bool isActive;
  final DateTime? emailVerifiedAt;
  final Donor donor;
  User({
    required this.id,
    required this.email,
    required this.isActive,
    required this.emailVerifiedAt,
    required this.donor,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        isActive: json["is_active"],
        emailVerifiedAt: json["email_verified_at"] == null
            ? null
            : DateTime.parse(json["email_verified_at"]),
        donor: Donor.fromJson(json["donor"]),
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

    return other is User &&
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
}
