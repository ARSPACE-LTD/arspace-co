import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../backend/api/handler.dart';
import '../../backend/helper/app_router.dart';
import '../../backend/models/history_model.dart';
import '../../util/dimens.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';
import 'history_state.dart';

class HistoryLogic extends GetxController {
  late HistoryState state;

  bool isTicketHistroyLoading = true;


  HistoryLogic({required this.state});

  HistoryModel historyResponse = HistoryModel();



  Future<void> getHistroyTickets() async {

    Response response = await state.ticket_history();

    print("ticketResponse body--->${response.body}");
    print("ticketResponse body string--->${response.body.toString()}");

    if (response.statusCode == 200) {
      isTicketHistroyLoading = false;

      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);
      historyResponse = HistoryModel.fromJson(myMap);

      print("ticketResponse ---->${historyResponse.toString()}");

      update();
    }
    else if (response.statusCode == 401) {
      isTicketHistroyLoading = false;
      state.ClearPrafrence();
      Get.toNamed(AppRouter.getLoginRoute(), preventDuplicates: false);



      Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

      if (myMap['auth'] == false) {
        showToast(myMap['error']);
      } else {
        if (myMap['error'] != '') {
          showToast(myMap['error']);
        } else {
          showToast('Token Expire');
        }
      }
      update();
    }
    else {
      isTicketHistroyLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> CheckTicket(String tokenId, BuildContext context) async {


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
    /*Get.dialog(
        SimpleDialog(
          children: [
            Row(
              children: [
                const SizedBox(
                  width: 30,
                ),
                const CircularProgressIndicator(
                  color: ThemeProvider.appColor,
                ),
                const SizedBox(
                  width: 30,
                ),
                SizedBox(
                    child: Text(
                      "Please wait".tr,
                      style: const TextStyle(fontFamily: 'bold'),
                    )),
              ],
            )
          ],
        ),
        barrierDismissible: false);*/

    var response = await state.CreateOrder(tokenId);

    Navigator.of(context).pop();

    print("CheckTicket response body--->${response.body}");
    print("CheckTicket response body string--->${response.body.toString()}");

    if(response.body.toString() != null){
      if (response.statusCode == 200 || response.statusCode == 404) {
        //  isLoading=false;

        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

        if (myMap['status'] != '' && myMap['status'] != null ){

          // successToast(myMap['status']);
          Get.toNamed(AppRouter.getTicket_status() ,arguments: [myMap['status']]);

        }else{
          successToast(myMap['please scan again']);
        }
        update();

      }
      else if (response.statusCode == 401) {
        state.ClearPrafrence();
        Get.toNamed(AppRouter.getLoginRoute(), preventDuplicates: false);

        Map<String, dynamic> myMap = Map<String, dynamic>.from(response.body);

        if (myMap['auth'] == false) {
          showToast(myMap['error']);
        } else {
          if (myMap['error'] != '') {
            showToast(myMap['error']);
          } else {
            showToast('Token Expire');
          }
        }
        update();
      }
      else {
        ApiChecker.checkApi(response);
      }
    }else{
      showToast("Please Scan vaild Ticket");
    }


    update();
  }


}
