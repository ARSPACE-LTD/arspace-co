


import 'package:arspace_co/backend/helper/shared_pref.dart';
import 'package:arspace_co/util/all_constants.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../modules/history/history_state.dart';
import '../../modules/home_page/home_page_state.dart';
import '../../modules/login/login_state.dart';
import '../../modules/splash/splash_state.dart';
import '../../modules/ticket_status/ticket_status_state.dart';
import '../../util/environment.dart';
import '../api/api.dart';
import 'connectivity_service.dart';


class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    final sharedPref = await SharedPreferences.getInstance();
    Get.put(
      SharedPreferencesManager(sharedPreferences: sharedPref),
      permanent: true,
    );


    Get.lazyPut(() => ApiService(appBaseUrl: Environments.apiBaseURL));

    // State LazyLoad

    Get.lazyPut(() => ConnectivityService());

    Get.lazyPut(() => SplashState(apiService: Get.find(), sharedPreferencesManager: Get.find()), fenix: true);
    Get.lazyPut(() => LoginState(apiService: Get.find(), sharedPreferencesManager: Get.find()), fenix: true);
    Get.lazyPut(() => Home_pageState(apiService: Get.find(), sharedPreferencesManager: Get.find()), fenix: true);
    Get.lazyPut(() => HistoryState(apiService: Get.find(), sharedPreferencesManager: Get.find()), fenix: true);
    Get.lazyPut(() => Ticket_statusState(apiService: Get.find(), sharedPreferencesManager: Get.find()), fenix: true);


  }
}
