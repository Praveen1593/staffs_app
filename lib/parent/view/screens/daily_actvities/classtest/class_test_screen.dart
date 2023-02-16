import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/screens/daily_actvities/classtest/today_classtest_screen.dart';

import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/class_test_controller/class_test_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'past_classtest_screen.dart';
import 'report_clastest_screen.dart';

class ClassTestScreen extends StatelessWidget {
  const ClassTestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClassTestController>(
        init: ClassTestController(),
        builder: (classTestController){
          return _buildBody(classTestController, context);
        });
  }

  Widget _buildBody(ClassTestController controller,BuildContext context){
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("Class Test"),
        body: DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const TabBar(
                    labelColor: AppColors.darkPinkColor,
                    unselectedLabelColor: AppColors.greyColor,
                    indicatorColor: AppColors.darkPinkColor,
                    tabs: [
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
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child:  TabBarView(children: <Widget>[
                     // TodayClassTestScreen(),
                   //   PastClassTestScreen(),
                     // ReportClassTestScreen(),
                    ]),
                  )
                ])));
  }
}
