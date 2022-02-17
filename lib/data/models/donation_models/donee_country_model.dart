class DoneeCountry {
  String? id;
  String? name;
  String? countryCode;
  String? currencyCode;
  bool? isVisible;

  DoneeCountry(
      {this.id,
      this.name,
      this.countryCode,
      this.currencyCode,
      this.isVisible});

  DoneeCountry.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    countryCode = json['country_code'];
    currencyCode = json['currency_code'];
    isVisible = json['is_visible'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['country_code'] = countryCode;
    data['currency_code'] = currencyCode;
    data['is_visible'] = isVisible;
    return data;
  }
}
