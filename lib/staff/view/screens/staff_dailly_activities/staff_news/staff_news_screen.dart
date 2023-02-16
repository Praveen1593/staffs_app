import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const/colors.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/daily_activities/circular_controller/staff_circular_event_news_controller.dart';
import '../staff_circular/Staff_latest_screen.dart';
import '../staff_circular/Staff_past_screen.dart';

class StaffNewsScreen extends StatelessWidget {
  const StaffNewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("News"),
        body: GetBuilder<StaffNewsCircularEventController>(
            init: StaffNewsCircularEventController(),
            builder: (newsController) {
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
                          controller: newsController.tabController,
                          isScrollable: false,
                          onTap: (index){
                            newsController.updateTabIndex(index);
                          },
                          tabs:const [
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
                              controller: newsController.tabController,
                              children: <Widget>[
                                StaffLatestScreen(),
                                const StaffPastScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
