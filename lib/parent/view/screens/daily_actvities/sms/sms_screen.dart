import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/sms_controller/sms_all_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'latest_specific_overall_screen.dart';

class SMSScreen extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _TabLayoutExampleState();
  }
}

class _TabLayoutExampleState extends State<SMSScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.animateTo(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("SMS"),
        body: GetBuilder<SmsController>(
            init: SmsController(),
            builder: (controller) {
              return DefaultTabController(
                  length: 3, // length of tabs
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TabBar(
                          labelColor: AppColors.darkPinkColor,
                          unselectedLabelColor: Colors.grey,
                          indicatorSize: TabBarIndicatorSize.tab,
                          isScrollable: false,
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: AppColors.darkPinkColor,
                                width: 2.0,
                              ),
                            ),
                          ),
                          onTap: (int index) {},
                          tabs: const [
                            Tab(
                              child: Text('LATEST',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Tab(
                              child: Text('SPECIFIC',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Tab(
                              child: Text('OVERALL',style: TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: TabBarView(
                              // physics:const NeverScrollableScrollPhysics(),
                              children: <Widget>[
                                SMSLatestSpecificOverAllScreen(
                                    listData: controller.todayFinalList,
                                    scrollController:
                                        controller.scrollController),
                                SMSLatestSpecificOverAllScreen(
                                    listData: controller.specificFinalList,
                                    scrollController:
                                        controller.scrollController),
                                SMSLatestSpecificOverAllScreen(
                                    listData: controller.latestFinalList,
                                    scrollController:
                                        controller.overallScrollController),
                              ]),
                        )
                      ]));
            }));
  }
}
