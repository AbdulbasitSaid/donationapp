import 'dart:convert';

class SetUpIntentModel {
  SetUpIntentModel({
    required this.status,
    required this.message,
    required this.data,
  });

  final String status;
  final String message;
  final SetUpIntentData data;

  factory SetUpIntentModel.fromJson(String str) =>
      SetUpIntentModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SetUpIntentModel.fromMap(Map<String, dynamic> json) =>
      SetUpIntentModel(
        status: json["status"],
        message: json["message"],
        data: SetUpIntentData.fromMap(json["data"]),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "message": message,
        "data": data.toMap(),
      };

  @override
  String toString() =>
      'SetUpIntentModel(status: $status, message: $message, data: $data)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SetUpIntentModel &&
        other.status == status &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => status.hashCode ^ message.hashCode ^ data.hashCode;
}

class SetUpIntentData {
  SetUpIntentData({
    required this.setupIntent,
    required this.ephemeralKey,
    required this.stripeCustomerId,
  });

  final String setupIntent;
  final String ephemeralKey;
  final String stripeCustomerId;

  factory SetUpIntentData.fromJson(String str) =>
      SetUpIntentData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SetUpIntentData.fromMap(Map<String, dynamic> json) => SetUpIntentData(
        setupIntent: json["setup_intent"],
        ephemeralKey: json["ephemeral_key"],
        stripeCustomerId: json["stripe_customer_id"],
      );

  Map<String, dynamic> toMap() => {
        "setup_intent": setupIntent,
        "ephemeral_key": ephemeralKey,
        "stripe_customer_id": stripeCustomerId,
      };

  @override
  String toString() =>
      'Data(setupIntent: $setupIntent, ephemeralKey: $ephemeralKey, stripeCustomerId: $stripeCustomerId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SetUpIntentData &&
        other.setupIntent == setupIntent &&
        other.ephemeralKey == ephemeralKey &&
        other.stripeCustomerId == stripeCustomerId;
  }

  @override
  int get hashCode =>
      setupIntent.hashCode ^ ephemeralKey.hashCode ^ stripeCustomerId.hashCode;
}
