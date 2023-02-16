import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/payroll_controller/loan_controller/LoanController.dart';

class StaffLoanDetailsScreen extends GetView<LoanController> {
  const StaffLoanDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Loan Details"),
      body:  Obx(() {
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
      shrinkWrap: true,
        itemCount: controller.finalList.length,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                              Text("${controller.finalList[index].leaveTypeName}",
                                  style: nunitoExtraBoldTextStyle(
                                      fontSize: 13, color: AppColors.blackColor)),
                              const SizedBox(height: 10,),
                              Text("${controller.finalList[index].date}",
                                  style: nunitoRegularTextStyle(
                                      fontSize: 12, color: Colors.black)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text("Details",
                          style: nunitoRegularTextStyle(
                              fontSize: 12, color: Colors.black38)),
                    ),
                    const SizedBox(height: 10,),
                    const Divider(
                      height: 1,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Start Date",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                          const Spacer(),
                          Text("${controller.finalList[index].startDate}",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("End Date",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                          const Spacer(),
                          Text("${controller.finalList[index].endDate}",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Amount",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                          const Spacer(),
                          Text("${controller.finalList[index].amount}",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Payment Status",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                          const Spacer(),
                          Text("${controller.finalList[index].paymentStatus}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 14, color: Colors.black)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Text("Loan Status",
                              style: nunitoRegularTextStyle(
                                  fontSize: 13, color: Colors.black)),
                          const Spacer(),
                          Text("${controller.finalList[index].status}",
                              style: nunitoExtraBoldTextStyle(
                                  fontSize: 14, color: AppColors.darkGreenColor)),
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
