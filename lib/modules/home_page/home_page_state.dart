import 'package:get/get_connect/http/src/response/response.dart';

import '../../backend/api/api.dart';
import '../../backend/helper/shared_pref.dart';
import '../../util/constants.dart';

class Home_pageState {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  Home_pageState({required this.sharedPreferencesManager, required this.apiService});

  Future<Response> logout() async {
    return await apiService.logout(AppConstants.logOut_api,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<void> clearAccount() async {
    bool? success = await sharedPreferencesManager.clearAll();
    if (success == true) {
      print("Clear sucessful.");
    } else {
      print("Clear failed or sharedPreferences is null.");
    }
  }


  Future<Response> deleteAccount() async {
    return await apiService.deleteAccount(AppConstants.delete_account,
        sharedPreferencesManager.getString('token') ?? '');
  }


}
