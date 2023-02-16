import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';
import '../../../../controller/payroll_controller/salary_list_controller/SalaryListController.dart';

class StaffSalaryListScreen extends GetView<SalaryListController> {
  const StaffSalaryListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("Salary List"),
        body: Obx(() {
          final loadingType = controller.loadingState.value.loadingType;
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (controller.finalList.isEmpty) {
            return const Center(child: Text("No Data"));
          }
          return ListView(
            controller: controller.scrollController,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: loadingType == LoadingType.loading ||
                      loadingType == LoadingType.error ||
                      loadingType == LoadingType.completed
                      ? controller.finalList.length + 1
                      : controller.finalList.length,
                  itemBuilder: (BuildContext context, int index) {
                    final isLastItem = index == controller.finalList.length;

                    if (isLastItem && loadingType == LoadingType.loading) {
                      return const Center(
                          child: CircularProgressIndicator.adaptive());
                    } else if (isLastItem && loadingType == LoadingType.error) {
                      return Text(controller.loadingState.value.error.toString());
                    } else if (isLastItem && loadingType == LoadingType.completed) {
                      return Text(
                          controller.loadingState.value.completed.toString());
                    } else {
                      return _buildBody(context);
                    }
                  },
                  separatorBuilder: (context, index) => Container(),
                ),
              )
            ],
          );
        })

    );
  }

  Widget _buildBody(BuildContext context) {
    return ListView.builder(
        itemCount: controller.finalList.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: Material(
              elevation: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Image.asset("assets/salarylist_img.png",width: 30,height: 30,),
                          const SizedBox(width: 20,),
                          Text("${controller.finalList[index].date}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 15, color: AppColors.blackColor)),
                          const Spacer(),
                          Text("Salary Date : ${controller.finalList[index].salaryDate}",
                              style: nunitoRegularTextStyle(
                                  fontSize: 12, color: Colors.black87)),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("${controller.finalList[index].allowanceName}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black87)),
                          const SizedBox(width: 20,),
                          Text("Gross Salary",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black38)),
                          const Spacer(),
                          Text("${controller.finalList[index].gSalary}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("${controller.finalList[index].deductionName}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black87)),
                          const SizedBox(width: 20,),
                          Text("Deduction",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black38)),
                          const Spacer(),
                          Text("${controller.finalList[index].dTotal}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Net Salary",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 13, color: Colors.black)),
                          const SizedBox(width: 20,),
                          Text("Net Salary",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 12, color: Colors.black38)),
                          const Spacer(),
                          Text("${controller.finalList[index].nSalary}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
          );
        }
    );
  }

}

