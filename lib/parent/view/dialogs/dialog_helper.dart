import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../common/const/colors.dart';

void closeLoadingDialog(BuildContext context) {
  if (context != null) Get.back();
}

Future<void> showLoadingDialog(BuildContext context) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      //prevent Back button press
      return WillPopScope(
        onWillPop: () async => false,
        child: Center(
          child: Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.whiteColor),
              child: const Center(
                  child: CircularProgressIndicator(
                color: Color(0xFF525CFF),
              ))),
        ),
      );
    },
  );
}

// Future<void> showToastMsg(String message) async {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.grey,
//       textColor: Colors.white,
//       fontSize: 12.0);
// }
