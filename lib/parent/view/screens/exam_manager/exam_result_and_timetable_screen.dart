import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../../staff/themes/app_styles.dart';
import '../../../controllers/daily_activity_controller/exam_manager_controller/exam_result_timetable_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';

class ExamResultScreen extends StatelessWidget {
  final String tag;

  const ExamResultScreen({Key? key, required this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: _smsAppbar(tag),
      body: GetBuilder<ExamResultAndTimeTableController>(
          init: ExamResultAndTimeTableController(),
          builder: (examResultController) {
            return examResultController.examListData!.isNotEmpty
                ? WillPopScope(
                    onWillPop: () async {
                      SystemChrome.setPreferredOrientations([
                        DeviceOrientation.portraitDown,
                        DeviceOrientation.portraitUp
                      ]);
                      return true;
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0, top: 10),
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text("Exam List"),
                              ),
                              SelectExamResultDropDown(
                                examResultController: examResultController,
                              ),
                              examResultController.isLoading
                                  ? Container(
                                      height: Get.height * 0.5,
                                      child: circularProgressIndicator()
                                          .paddingOnly(top: 20))
                                  : SizedBox(
                                      height: Get.height * 0.7,
                                      child: ListView(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        physics: const BouncingScrollPhysics(),
                                        children: [
                                          Html(
                                              shrinkWrap: true,
                                              data: examResultController
                                                      .examTimeTableModel
                                                      ?.examTimeTableData
                                                      ?.timeTable ??
                                                  "",
                                              style: {
                                                "td": Style(
                                                    padding:
                                                        const EdgeInsets.all(8),
                                                    alignment: Alignment.center,
                                                    backgroundColor:
                                                        const Color(0xff2196f3),
                                                    width: Get.width * 0.5,
                                                    color: Colors.white),
                                                "tr": Style(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    alignment: Alignment.center,
                                                    backgroundColor:
                                                        Colors.blueGrey,
                                                    color: Colors.white),
                                                "th": Style(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    alignment: Alignment.center,
                                                    backgroundColor:
                                                        const Color(0xffffe082),
                                                    color: Colors.black),
                                              }),
                                        ],
                                      ),
                                    ).paddingOnly(top: 20)
                            ],
                          ),
                        ],
                      ),
                    ))
                : circularProgressIndicator();
          }),
    );
  }
}


PreferredSizeWidget _smsAppbar(String text) {
  return AppBar(
      title:
      Text(text, style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
      leading: GestureDetector(
          onTap: () {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitDown,
              DeviceOrientation.portraitUp
            ]);
            Get.back();
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.whiteColor,
            size: 28,
          )),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
            )),
      ));
}

class SelectExamResultDropDown extends StatelessWidget {
  final ExamResultAndTimeTableController examResultController;

  SelectExamResultDropDown({required this.examResultController});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.94,
        decoration: BoxDecoration(
            border: Border.all(width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: examResultController.dropdownValue,
            icon: const Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: Icon(Icons.arrow_drop_down),
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: AppColors.blackColor, fontSize: 18),
            onChanged: (data) {
              examResultController.updateSelectedIndex(data: data!);
            },
            items: examResultController.examListData
                ?.map<DropdownMenuItem<String>>((value) {
              return DropdownMenuItem<String>(
                value: value.name,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    value.name.toString(),
                    style: arimoRegularTextStyle(
                        fontSize: 14, color: AppColors.blackColor),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
