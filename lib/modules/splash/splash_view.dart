import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/app_assets.dart';
import '../../util/theme.dart';
import 'splash_logic.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashLogic>(builder: (value){

      return Scaffold(
        backgroundColor: ThemeProvider.blackColor,
        body: Center(
            child: Image.asset(
              AssetPath.splashGif,
              height: Get.height*0.2,
              width: Get.width,
              fit: BoxFit.cover,
            )
        ),
      );

    });
  }

  @override
  void dispose() {
    // Call dispose function of SplashLogic here
    Get.find<SplashLogic>().dispose();
   // super.dispose();
  }


}
