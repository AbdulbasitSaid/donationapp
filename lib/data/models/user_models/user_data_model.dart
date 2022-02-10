
import '../profile/profile_seccess_model.dart';

class UserData {
  final String token;
  final String tokenType;
  final int expiresIn;
  final bool isDeviceSaved;
  final User user;
  final String? stripeCustomerId;
  UserData({
    required this.token,
    required this.tokenType,
    required this.expiresIn,
    required this.isDeviceSaved,
    required this.user,
    required this.stripeCustomerId,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        token: json["token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
        isDeviceSaved: json["is_device_saved"],
        user: User.fromJson(json["user"]),
        stripeCustomerId: json['stripe_customer_id'],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "token_type": tokenType,
        "expires_in": expiresIn,
        "is_device_saved": isDeviceSaved,
        "stripe_customer_id": stripeCustomerId,
        "user": user.toJson(),
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
      other.stripeCustomerId == stripeCustomerId;
  }

  @override
  int get hashCode {
    return token.hashCode ^
      tokenType.hashCode ^
      expiresIn.hashCode ^
      isDeviceSaved.hashCode ^
      user.hashCode ^
      stripeCustomerId.hashCode;
  }
}
