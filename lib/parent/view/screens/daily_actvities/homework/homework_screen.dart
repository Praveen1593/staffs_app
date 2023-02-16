import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/themes/app_styles.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'Today_past_screen.dart';
import 'home_report_screen.dart';

class HomeWorkScreen extends StatelessWidget {
  const HomeWorkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF5F5F5),
        appBar: smsAppbar("Homework"),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<HomeworkController>(
            init: HomeworkController(),
            builder: (controller) {
              return DefaultTabController(
                  length: 3, // length of tabs
                  initialIndex: 0,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            height: 45,
                            decoration: BoxDecoration(
                              color: Color(0XFFECF4FF),
                              borderRadius: BorderRadius.circular(
                                25.0,
                              ),
                            ),
                            child: TabBar(
                              labelColor: Color(0XFFFFFFFF),
                              unselectedLabelColor: AppColors.greyColor,
                              indicator: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0XFF407BFF)
                              ),
                              indicatorColor: AppColors.darkPinkColor,
                              controller: controller.tabController,
                              isScrollable: false,
                              onTap: (index) {
                                controller.updateTabIndex(index);
                              },
                              tabs:  [
                                Tab(
                                  child: Text('TODAY',style: AppStyles.PoppinsRegular.copyWith(fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                                Tab(
                                  child: Text('PAST',style: AppStyles.PoppinsRegular.copyWith(fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                                Tab(
                                  child: Text('REPORT',style: AppStyles.PoppinsRegular.copyWith(fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                TodayAndPastScreen(),
                                TodayAndPastScreen(),
                                const ReportScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
