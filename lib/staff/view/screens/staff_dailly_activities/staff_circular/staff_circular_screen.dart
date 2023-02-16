import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const/colors.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/view/screens/daily_actvities/latest_in_circular_event_news/latest_screen.dart';
import '../../../../../parent/view/screens/daily_actvities/news/past_screen.dart';
import '../../../../controller/daily_activities/circular_controller/staff_circular_event_news_controller.dart';
import 'Staff_latest_screen.dart';
import 'Staff_past_screen.dart';

class StaffCircularScreen extends StatelessWidget {
  const StaffCircularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        resizeToAvoidBottomInset: false,
        appBar: smsAppbar("Circular"),
        body: GetBuilder<StaffNewsCircularEventController>(
            init: StaffNewsCircularEventController(),
            builder: (controller) {
              return DefaultTabController(
                  length: 2, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          labelColor: AppColors.darkPinkColor,
                          unselectedLabelColor: AppColors.greyColor,
                          indicatorColor: AppColors.darkPinkColor,
                          controller: controller.tabController,
                          isScrollable: false,
                          onTap: (index) {
                            controller.updateTabIndex(index);
                          },
                          tabs: const [
                            Tab(
                              child: Text('LATEST',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Tab(
                              child: Text('PAST',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: TabBarView(
                              controller: controller.tabController,
                              children: <Widget>[
                                StaffLatestScreen(),
                                const StaffPastScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
