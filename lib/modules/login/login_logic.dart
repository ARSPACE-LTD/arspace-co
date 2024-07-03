import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../backend/api/handler.dart';
import '../../backend/helper/app_router.dart';
import '../../util/constants.dart';
import '../../util/dimens.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';
import 'login_state.dart';

class LoginLogic extends GetxController {

  late LoginState state;

  LoginLogic({required this.state});

  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  RxBool showPassword = false.obs;

  var has8Char = false.obs;
  var hasLN = false.obs;
  GlobalKey<FormState> loginformKey = GlobalKey<FormState>();



  @override
  void onInit() {
    super.onInit();

  }

  Future<void> onLoginClicked(BuildContext context) async {
    var body = {
      // "email": countryCodeController.text,
      "username": userNameController.text.toString().trim(),
      "password": passwordController.text.toString().trim(),
      "is_staff": true
    };

    //HtmlLoader();
    // htmlLoaderController.startLoading();


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

    var response = await state.loginWithEmail(body);
    Navigator.of(context).pop();

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['success'] == true) {
        successToast(myMap['message']);
        state.saveToken(myMap['token']);
        state.saveUserUUID(myMap['data']["uuid"]);
        print("token--->${myMap['token']}");
        print("uuid--->${myMap['data']["uuid"]}");

        Get.toNamed(AppRouter.getHomeRoute());


        // UpdateDeviceToken();

      }
    } else if (response.statusCode == 401) {
      showToast('Something went wrong while signup');
      update();
    } else if (response.statusCode == 404) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      showToast(myMap['error']);
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['message'] != '') {
        showToast(myMap['message']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }

  /*Future<void> UpdateDeviceToken() async {
    var body = {
      // "email": countryCodeController.text,
      "device_token": AppConstants.fcm_token,

    };
    var response = await state.updateDeviceToken(body);
    Get.back();

    if (response.statusCode == 200) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['success'] == true) {
        print("token is updated --->${myMap.toString()}");
      }
    } else if (response.statusCode == 401) {
      showToast('Something went wrong while signup');
      update();
    } else if (response.statusCode == 404) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      showToast(myMap['error']);
      update();
    } else if (response.statusCode == 500) {
      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      if (myMap['message'] != '') {
        showToast(myMap['message']);
      } else {
        showToast('Something went wrong');
      }
      update();
    } else {
      ApiChecker.checkApi(response);
      update();
    }
    update();
  }*/
}
