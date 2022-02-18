import 'donantion_dart.dart';

class DonationHistoryModel {
  String? status;
  String? message;
  List<DonationData>? data;

  DonationHistoryModel({this.status, this.message, this.data});

  DonationHistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DonationData>[];
      json['data'].forEach((v) {
        data!.add(DonationData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}







