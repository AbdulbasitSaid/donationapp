import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/base_success_model.dart';

class ContactSupportDatasource {
  final ApiClient _apiClient;

  ContactSupportDatasource(this._apiClient);
  Future<SuccessModel> contactSupport(
      Map<String, dynamic> params, String token) async {
    final result =
        await _apiClient.post('supports', params: params, token: token);
    return SuccessModel.fromJson(result);
  }
}
