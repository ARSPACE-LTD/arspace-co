import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../backend/helper/app_router.dart';
import '../../util/all_constants.dart';
import '../../util/app_assets.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../util/theme.dart';
import '../../widgets/commontext.dart';
import '../../widgets/submit_button.dart';
import '../qr_scanner/qr_reslut.dart';
import 'home_page_logic.dart';

class Home_pagePage extends StatefulWidget {
  const Home_pagePage({Key? key}) : super(key: key);

  @override
  _Home_pagePageState createState() => _Home_pagePageState();
}

class _Home_pagePageState extends State<Home_pagePage> {
  Color menuButtonColor = Colors.white; // Initial color for the menu button

  @override
  Widget build(BuildContext context) {
    final logic = Get.find<Home_pageLogic>();
    final state = Get.find<Home_pageLogic>().state;

    return WillPopScope(
      onWillPop: () async {
        await showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 300,
            child: AlertDialog(
              backgroundColor: Color(0xFF2F323F),
              title: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "Do you want to exit the application?",
                      style: TextStyle(
                          color: ThemeProvider
                              .whiteColor,
                          fontFamily: "Intern"),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                    children: [
                      Container(
                        width: 80,
                        height: 35,
                        child: SubmitButton(
                          onPressed: () => {
                            SystemChannels.platform.invokeMethod('SystemNavigator.pop')
                          },
                          title: "Yes",
                        ),
                      ),
                      Container(
                        width: 80,
                        height: 35,
                        child: SubmitButton(
                          onPressed: () => {
                            Navigator.of(context)
                                .pop()
                          },
                          title: "No",
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
        );
        return Future.value(false);
      },
      child: Scaffold(
        backgroundColor: ThemeProvider.blackColor,
        body: Column(
          children: [
            SizedBox(height: Get.height * 0.060),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                ),
                PopupMenuButton( // Add PopupMenuButton for the overflow menu
                  icon: Icon(
                    Icons.more_vert, // Specify the icon for the three-dot button
                    color: Colors.white, // Change the color of the three-dot button
                  ),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text('Log Out'),
                        value: 'Log Out',
                        onTap: () async {

                          await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 300,
                              child: AlertDialog(
                                backgroundColor: Color(0xFF2F323F),
                                title: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: Text(
                                        "Are you sure?",
                                        style: TextStyle(
                                            color: ThemeProvider
                                                .whiteColor,
                                            fontFamily: "Intern"),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment
                                          .spaceBetween,
                                      children: [
                                        Container(
                                          width: 80,
                                          height: 35,
                                          child: SubmitButton(
                                            onPressed: () => {

                                              logic.logout(context),
                                              Navigator.of(context)
                                                  .pop(),
                                            },
                                            title: "Yes",
                                          ),
                                        ),
                                        Container(
                                          width: 80,
                                          height: 35,
                                          child: SubmitButton(
                                            onPressed: () => {
                                              Navigator.of(context)
                                                  .pop()
                                            },
                                            title: "No",
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          );

                        },
                      ),
                      PopupMenuItem(
                        child: Text('Delete Account'),
                        value: 'Delete Account',
                        onTap: () async {

                          await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: 300,
                                child: AlertDialog(
                                  backgroundColor: Color(0xFF2F323F),
                                  title: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Are you sure you want to delete this account?",
                                          style: TextStyle(
                                              color: ThemeProvider
                                                  .whiteColor,
                                              fontFamily: "Intern"),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          Container(
                                            width: 80,
                                            height: 35,
                                            child: SubmitButton(
                                              onPressed: () => {

                                                logic.deleteAccount(context),
                                                Navigator.of(context).pop(),
                                              },
                                              title: "Yes",
                                            ),
                                          ),
                                          Container(
                                            width: 80,
                                            height: 35,
                                            child: SubmitButton(
                                              onPressed: () => {
                                                Navigator.of(context)
                                                    .pop()
                                              },
                                              title: "No",
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );

                        },
                      ),

                    ];
                  },
                ),
              ],
            ),
            SizedBox(height: Get.height * 0.060),
            InkWell(
              onTap: (){
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => QRViewExample(),
                ));
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: Get.height * 0.25,
                  width: Get.width ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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
            ),
            SizedBox(height: Get.height * 0.030),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRouter.getHistory());
              },
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: Get.height * 0.25,
                  width: Get.width ,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
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