import 'package:arspace_co/widgets/skip_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/app_assets.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../util/theme.dart';
import '../../widgets/commontext.dart';
import '../../widgets/submit_button.dart';
import 'ticket_status_logic.dart';

class Ticket_statusPage extends StatefulWidget {
  const Ticket_statusPage({Key? key}) : super(key: key);

  @override
  _Ticket_statusPageState createState() => _Ticket_statusPageState();
}

class _Ticket_statusPageState extends State<Ticket_statusPage> {

  String? ticketStatus;


  @override
  void initState() {
    super.initState();
    ticketStatus = Get.arguments[0].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ticketStatus == "verified" ?ThemeProvider.primary :ThemeProvider.error,
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
            Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  margin: EdgeInsets.only(left: 20),
                  child: CircleAvatar(
                    maxRadius: Get.width* 0.055,
                    backgroundColor: ThemeProvider.blackColor,
                    child: Center(
                      child: SvgPicture.asset(
                        AssetPath.left_arrow,
                        height: 25,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height:Get.height * 0.15, ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  width: Get.width * 0.35,
                  height: Get.width * 0.35,
                  image: AssetImage(
                      ticketStatus == "verified" ?
                      AssetPath.approve_badge_bule :  ticketStatus == "already_verified" ? AssetPath.alert
                  :ticketStatus == "event_expired" ? AssetPath.approve_badge_yellow
                          :ticketStatus == "invalid_ticket" ? AssetPath.alert_1 : AssetPath.approve_badge_bule ),
                ),
                CommonTextWidget(
                  heading: ticketStatus == "verified" ?
                  AppString.awsome_good_to_go :  ticketStatus == "already_verified" ? AppString.ticket_has_been_scanned
                      :ticketStatus == "event_expired" ? AppString.ticket_has_expired
                      :ticketStatus == "invalid_ticket" ? AppString.ticket_not_valid : AppString.ticket_not_valid ,
                  fontSize: Dimens.sixteen,
                  color: ThemeProvider.whiteColor,
                  fontFamily: 'Lexend',
                  fontWeight: FontWeight.w700,
                ),
              ],
            ),
            SizedBox(height:Get.height * 0.15, ),
            Container(
              margin: EdgeInsets.only(left: 20 ,right: 20),
              child: SkipButton(
                onPressed: () {
                  Get.back();
                },
                title:ticketStatus == "verified" ||ticketStatus == "event_expired" ? AppString.next_ticket : "TRY AGAIN",
                color: ticketStatus == "verified" ||ticketStatus == "event_expired" ? ThemeProvider.blackColor :
                ThemeProvider.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
