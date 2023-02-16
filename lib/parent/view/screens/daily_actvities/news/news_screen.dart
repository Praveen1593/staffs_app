import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/themes/app_styles.dart';
import 'package:flutter_projects/parent/view/screens/daily_actvities/news/past_screen.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/news_circular_event_controller/circular_event_news_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../latest_in_circular_event_news/latest_screen.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("News"),
        body: GetBuilder<NewsCircularEventController>(
            init: NewsCircularEventController(),
            builder: (newsController) {
              return DefaultTabController(
                  length: 2, // length of tabs
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
                               isScrollable: false,
                               controller: newsController.tabController,
                              onTap: (index){
                                newsController.updateTabIndex(index);
                              },
                              tabs: [
                                Tab(
                                  child: Text('LATEST',style: AppStyles.PoppinsRegular.copyWith(fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                                Tab(
                                  child: Text('PAST',style: AppStyles.PoppinsRegular.copyWith(fontSize: 14,fontWeight: FontWeight.w600)),
                                ),
                              ],
                        ),
                           ),
                         ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.8,
                          child: TabBarView(
                              controller: newsController.tabController,
                              children: <Widget>[
                                LatestScreen(),
                                const PastScreen(),
                              ]),
                        )
                      ]));
            }));
  }
}
