import 'package:json_annotation/json_annotation.dart';

import 'donee_history_datum_model.dart';
import 'link_model.dart';
part 'donation_history_data_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class DonationHistoryDataModel {
  DonationHistoryDataModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    required this.nextPageUrl,
    required this.path,
    required this.perPage,
    required this.prevPageUrl,
    required this.to,
    required this.total,
  });

  final int? currentPage;
  final List<DonationHistoryDatumModel> data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String lastPageUrl;
  final List<LinkModel> links;
  final dynamic nextPageUrl;
  final String path;
  final dynamic perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;
  factory DonationHistoryDataModel.fromJson(json) =>
      _$DonationHistoryDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryDataModelToJson(this);
}
