import '../../backend/api/api.dart';
import '../../backend/helper/shared_pref.dart';

class SplashState {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  SplashState({required this.sharedPreferencesManager, required this.apiService});


  bool isNewUser() {
    return sharedPreferencesManager.getBool('welcome');
  }

  String? token() {
    return sharedPreferencesManager.getString('token');
  }
}
