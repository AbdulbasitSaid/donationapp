import 'package:equatable/equatable.dart';

class DonationTypeEntity extends Equatable {
  final String name;
  final String description;
  final double fundAmount;

  const DonationTypeEntity({
    required this.name,
    required this.description,
    this.fundAmount = 0,
  });

  @override
  List<Object?> get props => [
        {'name': name},
        {'description: ': description},
        {'fundAmount: ': fundAmount},
      ];

  DonationTypeEntity copyWith({
    String? name,
    String? description,
    double? fundAmount,
    bool? selected,
  }) {
    return DonationTypeEntity(
      name: name ?? this.name,
      description: description ?? this.description,
      fundAmount: fundAmount ?? this.fundAmount,
    );
  }
}
