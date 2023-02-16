import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const/colors.dart';
import '../../../../controller/daily_activities/circular_controller/staff_circular_event_news_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'Staff_latest_screen.dart';


class StaffPastScreen extends StatelessWidget {
  const StaffPastScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffNewsCircularEventController>(
        init: StaffNewsCircularEventController(),
        builder: (newsController) {
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 20),
                child: Card(
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Choose Date",
                          style: AppStyles.arimBold.copyWith(
                              fontSize: 14, color: AppColors.blackColor),
                        ),
                        SMSButtonWidget(
                          onPress: () {
                            newsController.updateFinalList();
                            newsController.selectDate(context);
                          },
                          text: "SINGLE DAY",
                          width: 10,
                          height: 40,
                          primaryColor: AppColors.darkPinkColor,
                          borderRadius: 5,
                          fontSize: 11,
                        ),
                        SMSButtonWidget(
                          onPress: () {
                            newsController.updateFinalList();
                            newsController.dateRangeDialog(context);
                          },
                          text: '''MULTIPLE \n    DAYS''',
                          width: 10,
                          height: 40,
                          borderRadius: 5,
                          primaryColor: AppColors.darkPinkColor,
                          fontSize: 11,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              newsController.isVisiblePastView ? Container():SizedBox(
                height: Get.height * 0.65,
                  child: StaffLatestScreen()),
              const SizedBox(height: 20,)
            ],
          );
        });
  }
}
