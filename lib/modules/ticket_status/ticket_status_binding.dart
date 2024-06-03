import 'package:get/get.dart';

import 'ticket_status_logic.dart';

class Ticket_statusBinding extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut(() => Ticket_statusLogic(state: Get.find()));
  }
}
