import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaffClasstestReplyController extends GetxController {
  bool multiReplySelect = false;
  bool overallReplySelect = false;
  TextEditingController maxMarkEditController = TextEditingController();
  TextEditingController markEditController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
  }

  void updateIndex(int type) {
    if (type == 1) {
      multiReplySelect = true;
      overallReplySelect = false;
    } else {
      overallReplySelect = true;
      multiReplySelect = false;
    }
    update();
  }
}
