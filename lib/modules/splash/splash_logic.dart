import 'dart:async';
import 'package:get/get.dart';

import '../../backend/helper/app_router.dart';
import 'splash_state.dart';
import 'dart:io';


class SplashLogic extends GetxController {

  late SplashState state;

  SplashLogic({required this.state});

  @override
  void onInit() {
    super.onInit();

    Timer(

        Duration(seconds:Platform.isAndroid ? 5 : 6),
            () => {
          if (state.token() != null && state.token() != "")
            {
              Get.toNamed(AppRouter.getHomeRoute())
            }
          else
            {Get.toNamed(AppRouter.getLoginRoute())}
        });
  }


}
