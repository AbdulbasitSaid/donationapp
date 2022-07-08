import 'package:idonatio/data/models/donation_models/donee_model.dart';

class RecentDoneesResponseModel {
  String? status;
  String? message;
  List<DoneeModel>? data;

  RecentDoneesResponseModel({this.status, this.message, this.data});

  RecentDoneesResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <DoneeModel>[];
      json['data'].forEach((v) {
        data!.add(DoneeModel.fromJson(v));
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
