import '../../backend/api/api.dart';
import '../../backend/helper/shared_pref.dart';

class Ticket_statusState {

  final SharedPreferencesManager sharedPreferencesManager;
  final ApiService apiService;

  Ticket_statusState({required this.sharedPreferencesManager, required this.apiService});


}
