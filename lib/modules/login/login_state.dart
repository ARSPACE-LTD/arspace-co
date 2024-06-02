import 'package:get/get_connect/http/src/response/response.dart';

import '../../backend/api/api.dart';
import '../../backend/helper/shared_pref.dart';
import '../../util/constants.dart';

class LoginState {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  LoginState({required this.sharedPreferencesManager, required this.apiService});


  Future<Response> loginPhoneNumber(dynamic body) async {
    var response = await apiService.postPublic(AppConstants.login_api, body);
    return response;
  }

  Future<Response> updateDeviceToken(dynamic body) async {
    var response = await apiService.putPrivate(AppConstants.completeProfile_api, body , sharedPreferencesManager.getString('token') ?? '');
    return response;
  }

  void saveToken(String token) {
    sharedPreferencesManager.putString('token', token);
  }

  void saveUserUUID(String UUID) {
    sharedPreferencesManager.putString('UUID', UUID);
  }

}
