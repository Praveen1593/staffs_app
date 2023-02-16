import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller1/classtest_controller1.dart';
import '../../../../controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'classtest_past_screen1.dart';
import 'classtest_report_screen1.dart';

class ClassTestScreen1 extends StatelessWidget {
  const ClassTestScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0XFFF5F5F5),
        appBar: smsAppbar("Homework Test"),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<ClassTestController1>(
            init: ClassTestController1(),
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
                              tabs: const [
                                Tab(
                                  child: Text('TODAY',style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Tab(
                                  child: Text('PAST',style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                                Tab(
                                  child: Text('REPORT',style: TextStyle(fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Flexible(
                          child: TabBarView(
                              controller: controller.tabController,
                              children: [
                                TodayAndPastScreen1(),
                                TodayAndPastScreen1(),
                                const ReportScreen1(),
                              ]),
                        )
                      ]));
            }));
  }
}
