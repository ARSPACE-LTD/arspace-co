import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../util/app_assets.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../util/theme.dart';
import '../../widgets/commontext.dart';
import 'history_logic.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  double screenHeight = 0;
  double screenWidth = 0;

  late HistoryLogic ticketHistoryController;

  @override
  void initState() {
    super.initState();
    ticketHistoryController = Get.put(HistoryLogic(state: Get.find()));
    ticketHistoryController.initialized;
    ticketHistoryController.getHistroyTickets();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return GetBuilder<HistoryLogic>(builder: (value) {
      return value.isTicketHistroyLoading == true
          ? Center(
        child: LoadingAnimationWidget.threeRotatingDots(
          color: ThemeProvider.loader_color,
          size: Dimens.loder_size,
        ),
      ):Scaffold(
        backgroundColor: ThemeProvider.blackColor,

        body: Column(
          children: [

            Container(
              margin: EdgeInsets.only(top: Get.height * 0.085),
              child: Row(
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0.0 ,left: 15 ,right: 15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: CircleAvatar(
                      maxRadius: screenWidth * 0.055,
                      backgroundColor: ThemeProvider.text_background,
                      child: Center(
                        child: SvgPicture.asset(
                          AssetPath.left_arrow,
                          height: 25,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10,),
                  CommonTextWidget(
                    heading: AppString.view_order,
                    fontSize: Dimens.twenty,
                    color: ThemeProvider.whiteColor,
                    fontFamily: 'Lexend',
                    fontWeight: FontWeight.w800,
                  ),

                ],
              ),
            ),

            Expanded(
              child: value.historyResponse.data != null &&  value.historyResponse.data!.isNotEmpty ?
      ListView.builder(
                  itemCount: value.historyResponse.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: ()
                      {

                      },
                      child: Container(
                        margin: EdgeInsets.only(left: Get.width * 0.070 ,right: Get.width * 0.070 ,bottom: 20),
                        padding: EdgeInsets.all(15),
                        decoration:  BoxDecoration(
                          color:ThemeProvider.whiteColor,

                          borderRadius: BorderRadius.all(
                              Radius.circular(10.0)), // Set rounded corner radius
                        ),
                        child: Container(
                            padding: EdgeInsets.all(10),
                            child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    CommonTextWidget(
                    heading: value.historyResponse.data![index].event!.name,
                    fontSize: Dimens.sixteen,
                    color: ThemeProvider.blackColor,
                    fontFamily: 'bold',
                    fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 15,),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                CircleAvatar(
                                  maxRadius: 8,
                                  backgroundColor: ThemeProvider.text_littel_light_gray,
                                  child: Container(),
                                ),
                                SizedBox(width: 5),
                                CommonTextWidget(
                                  heading: value.historyResponse.data![index].user!.name,
                                  fontSize: Dimens.thrteen,
                                  color: ThemeProvider.blackColor,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Image(
                                  width: 16.0,
                                  height: 16.0,
                                  image: AssetImage(AssetPath.briefcase),
                                ),

                                SizedBox(width: 5),
                                CommonTextWidget(
                                  heading: value.historyResponse.data![index].event!.club,
                                  fontSize: Dimens.thrteen,
                                  color: ThemeProvider.blackColor,
                                  fontFamily: 'bold',
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 12 , bottom: 12 ,left: 15 ,right: 15),
                            decoration:  BoxDecoration(
                              color: value.historyResponse.data![index].status == "verified" ? ThemeProvider.blue_light_Color : ThemeProvider.light_redColor,

                              borderRadius: BorderRadius.all(
                                  Radius.circular(5.0)), // Set rounded corner radius
                            ),
                            child: CommonTextWidget(
                              heading: value.historyResponse.data![index].status == "verified" ? "vertified" :"Not vertified",
                              fontSize: Dimens.thrteen,
                              color: value.historyResponse.data![index].status == "verified" ? ThemeProvider.blueColor : ThemeProvider.redColor ,
                              fontFamily: 'bold',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(width: 5),
                          CommonTextWidget(
                            heading: _miliseconds_to_date(userTime: value.historyResponse.data![index].createdAt!),
                            fontSize: Dimens.thrteen,
                            color: ThemeProvider.text_littel_light_gray,
                            fontFamily: 'bold',
                            fontWeight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                    ),

                    )));



                  }) : Container(
                child: Center(child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image(
                      width: Get.width * 0.35,
                      height: Get.width * 0.35,
                      image: AssetImage(AssetPath.order_png),
                    ),

                    CommonTextWidget(
                      heading: "you don’t have any ticket history",
                      fontSize: Dimens.sixteen,
                      color: ThemeProvider.whiteColor,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w700,
                    ),

                  ],
                ),),
              ),
            ),
          ],
        ));


    });
  }
  String _miliseconds_to_date({required String userTime}) {
    // Parse the string date into a DateTime object
    DateTime notificationDate = DateTime.parse(userTime);

    // Format the date as "Jul 7, 2022 5:53 PM"
    String formattedDateTime = DateFormat('MMM d, yyyy h:mm a').format(notificationDate);

    return formattedDateTime; // Return the formatted date
  }
  /*String _miliseconds_to_date({required String userTime}) {
    // Parse the string date into a DateTime object
    DateTime notificationDate = DateTime.parse(userTime);

    // Calculate the time difference
    Duration diff = DateTime.now().difference(notificationDate);

    // Determine the appropriate format based on the time difference
    String formattedDateTime;
    if (diff.inDays >= 1) {
      formattedDateTime = DateFormat('MMM d, yyyy').format(notificationDate);
    } else if (diff.inHours >= 1) {
      formattedDateTime = '${diff.inHours} hour(s) ago';
    } else if (diff.inMinutes >= 1) {
      formattedDateTime = '${diff.inMinutes} minute(s) ago';
    } else if (diff.inSeconds >= 1) {
      formattedDateTime = '${diff.inSeconds} second(s) ago';
    } else {
      formattedDateTime = 'just now';
    }

    return formattedDateTime; // Return the formatted date
  }
*/




}
