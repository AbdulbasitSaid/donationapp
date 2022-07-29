import 'package:hive/hive.dart';

import 'package:idonatio/data/models/user_models/user_model.dart';

part 'user_data_model.g.dart';

@HiveType(typeId: 2)
class UserData extends HiveObject {
  @HiveField(0)
  final String token;
  @HiveField(1)
  final String? tokenType;
  @HiveField(2)
  final int expiresIn;
  @HiveField(3)
  final bool isDeviceSaved;
  @HiveField(4)
  final UserModel user;
  @HiveField(5)
  final String? stripeCustomerId;
  @HiveField(6)
  final String? singUpType;
  //
  UserData({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.isDeviceSaved,
    required this.user,
    required this.stripeCustomerId,
    required this.singUpType,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
      token: json["token"],
      tokenType: json["token_type"],
      expiresIn: json["expires_in"],
      isDeviceSaved: json["is_device_saved"],
      user: UserModel.fromJson(json["user"]),
      stripeCustomerId: json['stripe_customer_id'],
      singUpType: json["signup_type"] as String?);

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "is_device_saved": isDeviceSaved,
        "stripe_customer_id": stripeCustomerId,
        "user": user.toJson(),
        'signup_type': singUpType,
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.token == token &&
        other.tokenType == tokenType &&
        other.expiresIn == expiresIn &&
        other.isDeviceSaved == isDeviceSaved &&
        other.user == user &&
        other.singUpType == singUpType &&
        other.stripeCustomerId == stripeCustomerId;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        tokenType.hashCode ^
        expiresIn.hashCode ^
        isDeviceSaved.hashCode ^
        user.hashCode ^
        singUpType.hashCode ^
        stripeCustomerId.hashCode;
  }

  @override
  String toString() {
    return 'UserData(token: $token, tokenType: $tokenType, expiresIn: $expiresIn, isDeviceSaved: $isDeviceSaved, user: $user, stripeCustomerId: $stripeCustomerId singUpType: $singUpType)';
  }

  UserData copyWith({
    String? token,
    String? tokenType,
    int? expiresIn,
    bool? isDeviceSaved,
    UserModel? user,
    String? stripeCustomerId,
    String? singUpType,
  }) {
    return UserData(
      token: token ?? this.token,
      tokenType: tokenType ?? this.tokenType,
      expiresIn: expiresIn ?? this.expiresIn,
      isDeviceSaved: isDeviceSaved ?? this.isDeviceSaved,
      user: user ?? this.user,
      stripeCustomerId: stripeCustomerId ?? this.stripeCustomerId,
      singUpType: singUpType ?? this.singUpType,
    );
  }
}
