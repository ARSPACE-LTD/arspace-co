import 'package:get/get_connect/http/src/response/response.dart';

import '../../backend/api/api.dart';
import '../../backend/helper/shared_pref.dart';
import '../../util/constants.dart';

class HistoryState {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  HistoryState({required this.sharedPreferencesManager, required this.apiService});


  Future<Response> ticket_history() async {
    return apiService.getPrivate(AppConstants.ticket_history,
        sharedPreferencesManager.getString('token') ?? '');
  }

  Future<Response> CreateOrder(String ticketID) async {
    return apiService.postPrivateWithoutBody(AppConstants.check_ticket +"/$ticketID",
        sharedPreferencesManager.getString('token') ?? '');
  }

  void ClearPrafrence() {
    sharedPreferencesManager.clearAll();
  }

}
