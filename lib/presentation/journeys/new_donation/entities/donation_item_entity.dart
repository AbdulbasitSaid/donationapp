class DonationItemEntity {
  final String id;
  final String type;
  final String description;
  double amount;

  DonationItemEntity(
      {required this.id,
      required this.type,
      required this.description,
      this.amount = 0});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DonationItemEntity &&
        other.id == id &&
        other.type == type &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ type.hashCode ^ description.hashCode;
  }

  @override
  String toString() {
    return 'DonationItemEntity(id: $id, type: $type, description: $description, amount: $amount)';
  }
}
