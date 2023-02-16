import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/payroll_controller/advance_salarylist_controller/AdvanceSalaryListController.dart';

class StaffAdvanceSalaryScreen extends GetView<AdvanceSalaryListController> {
  const StaffAdvanceSalaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Advance Salary"),
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
    print("getLeaveListData :finelist UI ${controller.finalList.length}");
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${controller.finalList[index].amount}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 13, color: AppColors.blackColor)),
                              const SizedBox(height: 10,),
                              Text("${controller.finalList[index].applyDate}",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black38)),
                            ],
                          ),
                          const Spacer(),
                          Text("Pending",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 15, color: Colors.black)),
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
