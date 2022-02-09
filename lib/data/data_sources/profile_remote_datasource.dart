import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/models/profile/profile_seccess_model.dart';

class ProfileRemoteDataSource {
  final ApiClient apiClient;

  ProfileRemoteDataSource(this.apiClient);

  Future<ProfileSuccessModel> updateProfile(
      String token, Map<dynamic, dynamic> params) async {
    final result = await apiClient.patch('path', token: token, params: params);
    return ProfileSuccessModel.fromJson(result);
  }
}
