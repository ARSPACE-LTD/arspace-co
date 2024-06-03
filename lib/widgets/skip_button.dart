
import 'package:arspace_co/util/all_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';

import '../util/theme.dart';

class SkipButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final Color color;

  const SkipButton({Key? key, required this.onPressed, required this.title ,required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0.0),
          elevation: 5,
        ),

        onPressed: onPressed,
        child: Ink(
          decoration: BoxDecoration(
           // color: ThemeProvider.primary,
            color: color,
              /*gradient:  LinearGradient(
                  colors: [ThemeProvider.primary]),*/
              borderRadius: BorderRadius.circular(50)),
          child: Container(
            margin: EdgeInsets.all(0),
            width: Get.width,
            height: 56,
            alignment: Alignment.center,
            child: Text(title,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ));
  }
}
