import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'donee_history_datum_model.dart';
import 'link_model.dart';
part 'donation_history_data_model.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class DonationHistoryDataModel extends Equatable {
  const DonationHistoryDataModel({
    required this.currentPage,
    required this.data,
    required this.firstPageUrl,
    required this.from,
    required this.lastPage,
    required this.lastPageUrl,
    required this.links,
    this.nextPageUrl = '',
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
  final String nextPageUrl;
  final String path;
  final dynamic perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;
  factory DonationHistoryDataModel.fromJson(json) =>
      _$DonationHistoryDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$DonationHistoryDataModelToJson(this);

  @override
  List<Object?> get props => [
        currentPage,
        data,
        firstPageUrl,
        from,
        lastPage,
        lastPageUrl,
        links,
        nextPageUrl,
        path,
        prevPageUrl,
        to,
        total,
      ];
}
