import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../backend/api/handler.dart';
import '../../backend/helper/app_router.dart';
import '../../util/dimens.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';
import 'home_page_state.dart';

class Home_pageLogic extends GetxController {

  late Home_pageState state;

  Home_pageLogic({required this.state});

  Future<void> logout(BuildContext context) async {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Center(
          child: LoadingAnimationWidget.threeRotatingDots(
            color: ThemeProvider.loader_color,
            size: Dimens.loder_size,
          ),
        ); // Display the custom loader
      },
    );
    Response response = await state.logout();
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      print("Log Out Response --->${myMap.toString()}");

      if (myMap['message'] != '') {
        successToast(myMap['message'.tr]);
      } else {
        showToast('Something went wrong'.tr);
      }
      print("Log Out Response --->${myMap.toString()}");
      state.clearAccount();
      Get.offAllNamed(AppRouter.login);
      update();
    }else if(response.statusCode == 401){
      state.clearAccount();
      Get.offAllNamed(AppRouter.login);
      update();
      successToast("LogOut successfully");
    }
    else {
      ApiChecker.checkApi(response);
    }
    update();
  }



}
