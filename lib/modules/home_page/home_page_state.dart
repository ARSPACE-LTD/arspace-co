import '../../backend/api/api.dart';
import '../../backend/helper/shared_pref.dart';

class Home_pageState {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  Home_pageState({required this.sharedPreferencesManager, required this.apiService});


}
