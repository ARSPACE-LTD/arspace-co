import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/app_assets.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../util/theme.dart';
import '../../widgets/commontext.dart';
import 'home_page_logic.dart';

class Home_pagePage extends StatelessWidget {
  const Home_pagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<Home_pageLogic>();
    final state = Get.find<Home_pageLogic>().state;

    return Scaffold(
      backgroundColor: ThemeProvider.blackColor,
      body: SafeArea(
        child: Column(
          children: [

            SizedBox(height: Get.height * 0.030),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Image(
                  width: 30.0,
                  height: 30.0,
                  image: AssetImage(AssetPath.ar_icon),
                ),

                SizedBox(width: 10,),
                CommonTextWidget(
                  heading: AppString.app_name,
                  fontSize: Dimens.thirtySix,
                  color: ThemeProvider.whiteColor,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w800,
                ),

              ],
            ),
            SizedBox(height:Get.height * 0.060, ),

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: Get.height * 0.25,
                width: Get.width ,
                decoration: BoxDecoration(
                  borderRadius:
                    BorderRadius
                      .circular(20),
                  color: ThemeProvider.text_background

                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: Get.width * 0.15,
                      height: Get.width * 0.15,
                      image: AssetImage(AssetPath.scan_png),
                    ),


                    SizedBox(width: 10,),
                    CommonTextWidget(
                      heading: AppString.scan_icket,
                      fontSize: Dimens.sixteen,
                      color: ThemeProvider.whiteColor,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w400,
                    ),

                  ],
                ),
              ),
            ),
            SizedBox(height:Get.height * 0.030, ),

            GestureDetector(
              onTap: () {

              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: Get.height * 0.25,
                  width: Get.width ,
                  decoration: BoxDecoration(
                      borderRadius:
                      BorderRadius
                          .circular(20),
                      color: ThemeProvider.text_background

                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        width: Get.width * 0.15,
                        height: Get.width * 0.15,
                        image: AssetImage(AssetPath.order_png),
                      ),


                      SizedBox(width: 10,),
                      CommonTextWidget(
                        heading: AppString.history,
                        fontSize: Dimens.sixteen,
                        color: ThemeProvider.whiteColor,
                        fontFamily: 'Lexend',
                        fontWeight: FontWeight.w400,
                      ),

                    ],
                  ),
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }
}
