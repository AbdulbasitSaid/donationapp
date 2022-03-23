import 'dart:convert';

class DeviceInfoModel {
  final String? platform;
  final String? deviceUid;
  final String? os;
  final String? osVersion;
  final String? model;
  final String? ipAddress;
  final String? screenResolution;
  DeviceInfoModel({
    required this.platform,
    required this.deviceUid,
    required this.os,
    required this.osVersion,
    required this.model,
    required this.ipAddress,
    required this.screenResolution,
  });

  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'deviceUid': deviceUid,
      'os': os,
      'osVersion': osVersion,
      'model': model,
      'ipAddress': ipAddress,
      'screenResolution': screenResolution,
    };
  }

  factory DeviceInfoModel.fromMap(Map<String, dynamic> map) {
    return DeviceInfoModel(
      platform: map['platform'] ?? '',
      deviceUid: map['deviceUid'] ?? '',
      os: map['os'] ?? '',
      osVersion: map['osVersion'] ?? '',
      model: map['model'] ?? '',
      ipAddress: map['ipAddress'] ?? '',
      screenResolution: map['screenResolution'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory DeviceInfoModel.fromJson(String source) =>
      DeviceInfoModel.fromMap(json.decode(source));
}