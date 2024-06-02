import 'package:get/get.dart';

import 'home_page_logic.dart';

class Home_pageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Home_pageLogic(state: Get.find()));

  }
}
