import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/countries_model.dart';

class CountryRemoteDataSource {
  final ApiClient _apiClient;

  CountryRemoteDataSource(this._apiClient);
  Future<CountriesModel> getCountries() async {
    final response = await _apiClient.get('countries');
    return CountriesModel.fromMap(response);
  }
}
