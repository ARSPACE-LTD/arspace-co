import 'package:arspace_co/util/extensions/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../backend/helper/connectivity_service.dart';
import '../../util/app_assets.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../util/theme.dart';
import '../../util/toast.dart';
import '../../widgets/commontext.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/submit_button.dart';
import 'login_logic.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final ConnectivityService connectivityService = Get.find();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginLogic>(
      builder: (value) {
        return Scaffold(
          backgroundColor: ThemeProvider.blackColor,
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: Container(
                color: ThemeProvider.blackColor,
                padding: EdgeInsets.only(
                  left: Get.width * 0.06,
                  right: Get.width * 0.06,
                ),
                child: WillPopScope(
                  onWillPop: () {
                    Get.offNamedUntil(
                        'authentication_typescreen', (route) => false);
                    return Future.value(false);
                  },
                  child: Form(
                    key: value.loginformKey,
                    child: Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: Get.height * 0.04),
                                InkWell(
                                  onTap: () {
                                    Get.offNamedUntil('authentication_typescreen',
                                            (route) => false);
                                  },
                                  child: CircleAvatar(
                                    maxRadius: Get.width * 0.055,
                                    backgroundColor: ThemeProvider.text_background,
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AssetPath.left_arrow,
                                        height: 25,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.06),
                                Container(
                                  child: CommonTextWidget(
                                    heading: AppString.login_header,
                                    fontSize: Dimens.thirtySix,
                                    color: ThemeProvider.whiteColor,
                                    fontFamily: 'Lexend',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                CommonTextWidget(
                                  heading: AppString.welcome_back,
                                  fontSize: Dimens.sixteen,
                                  color: Color(0xFFA7A9B1),
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w400,
                                ),
                                SizedBox(height: Get.height * 0.06),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: CustomTextField(
                                    controller: value.userNameController,
                                    hintText: AppString.email,
                                    keyboardType: TextInputType.text,
                                    backgroundColor: ThemeProvider.whiteColor,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppString.error_email;
                                      } else if (value.isValidEmail() ==
                                          false) {
                                        return AppString
                                            .please_enter_valid_email;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.02),
                                GestureDetector(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                  },
                                  child: CustomTextField(
                                    backgroundColor: ThemeProvider.whiteColor,
                                    controller: value.passwordController,
                                    obscureText: !value.showPassword.value,
                                    maxLines: 1,
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        value.showPassword.value =
                                        !value.showPassword.value;
                                        value.update();
                                      },
                                      icon: Icon(
                                        value.showPassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: ThemeProvider.blackColor,
                                      ),
                                    ),
                                    hintText: AppString.password,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppString.error_msg_password;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(height: Get.height * 0.08),
                                SubmitButton(
                                  onPressed: () {
                                    if (value.loginformKey.currentState!
                                        .validate()) {
                                      connectivityService.isConnected.value
                                          ? value.onLoginClicked()
                                          : showToast(
                                          AppString.internet_connection);
                                    }
                                  },
                                  title: AppString.login_button,
                                ),
                                SizedBox(height: Get.height * 0.05),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}