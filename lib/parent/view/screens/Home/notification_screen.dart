import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/const/colors.dart';
import '../../../controllers/home_controller/notification_controller.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(
        init: NotificationController(),
        builder: (notificationController) {
          return _buildBody(notificationController, context);
        });
  }

  Widget _buildBody(
      NotificationController notificationController, BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Notification"),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: (notificationController.notificationModel != null &&
                notificationController.notificationModel!.data!.isEmpty)
            ? const Center(child: Text("No Data"))
            : RefreshIndicator(
                key: notificationController.refreshIndicatorKey,
                onRefresh: notificationController.refreshData,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: notificationController
                            .notificationModel?.data?.length ??
                        0,
                    itemBuilder: (BuildContext context, int index) {
                      return _cardBody(notificationController, context, index);
                    })),
      ),
    );
  }

  Widget _cardBody(NotificationController notificationController,
      BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5, right: 5, left: 5),
      child: InkWell(
        onTap: () {
          if (notificationController
                  .notificationModel?.data?[index].mobileAppStatus ==
              1) {
            notificationController.getNotificationRead(
                notificationController.notificationModel?.data?[index].id ?? 0);
            notificationController.getNotification();
            print("clicked");
          }
        },
        child: Card(
            color: notificationController
                        .notificationModel?.data?[index].mobileAppStatus ==
                    2
                ? Colors.white
                : Colors.grey[200],
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${notificationController.notificationModel?.data?[index].title}",
                        style: AppStyles.NunitoExtrabold.copyWith(fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${notificationController.notificationModel?.data?[index].description}",
                        style: AppStyles.NunitoRegular.copyWith(fontSize: 13),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50, right: 10),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "${notificationController.notificationModel?.data?[index].date}",
                      style: AppStyles.NunitoRegular.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
