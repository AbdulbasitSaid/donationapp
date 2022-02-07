import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/donee_models/saved_donees_model.dart';

class SavedDoneeDataSource {
  final ApiClient _apiClient;

  SavedDoneeDataSource(this._apiClient);
  Future<SavedDoneesResponseModel> getSavedDonees(String token) async {
    final result = await _apiClient.get('donors/saved-donees', token: token);
    return SavedDoneesResponseModel.fromMap(result);
  }
}
