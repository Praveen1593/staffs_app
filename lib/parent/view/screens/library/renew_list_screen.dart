import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../controllers/library_controller/renew_controller.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class RenewListScreen extends GetView<RenewController> {
  const RenewListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("Return List"),
        body: Obx(() {
          final loadingType = controller.loadingState.value.loadingType;
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (controller.finalList.isEmpty) {
            return const Center(child: Text("No Data"));
          }
          return GetBuilder<RenewController>(builder: (renew) {
            print("fetchData GetBuilder ${controller.finalList.length}");
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
                      print(
                          "fetchData itemBuilder ${controller.finalList.length}");
                      final isLastItem = index == controller.finalList.length;

                      if (isLastItem && loadingType == LoadingType.loading) {
                        return const Center(
                            child: CircularProgressIndicator.adaptive());
                      } else if (isLastItem &&
                          loadingType == LoadingType.error) {
                        return Text(
                            controller.loadingState.value.error.toString());
                      } else if (isLastItem &&
                          loadingType == LoadingType.completed) {
                        return Text(
                            controller.loadingState.value.completed.toString());
                      } else {
                        return _buildBody(controller, context, index);
                      }
                    },
                    separatorBuilder: (context, index) => Container(),
                  ),
                )
              ],
            );
          });
        }));
  }

  Widget _buildBody(
      RenewController renewController, BuildContext context, int index) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
          child: SizedBox(
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.fineListData[index].isClicked =
                            !controller.fineListData[index].isClicked;
                        controller.update();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${controller.finalList[index].bookName}",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Academic Year : ${controller.finalList[index].academic}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Return Date : ${controller.finalList[index].returnRenewDate}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Library Code : ${controller.finalList[index].code}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "${controller.finalList[index].type}",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                    fontSize: 15,
                                    color: AppColors.darkPinkColor,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.finalList[index].fineStatus}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 11),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.fineListData[index].isClicked
                          ? true
                          : false, //controller.showDetails.value
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Due Details",
                              style: AppStyles.NunitoExtrabold.copyWith(
                                  fontSize: 10, color: Colors.black45),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total fine Days",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  "${controller.finalList[index].totalFineDays}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Single Day Fine",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  "${Constants.RUPEESYMBOOL} ${controller.finalList[index].singleDayFine}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Fine Amount",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  "${Constants.RUPEESYMBOOL} ${controller.finalList[index].fineAmount}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Lost Book Amount",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  "${Constants.RUPEESYMBOOL} ${controller.finalList[index].lostBookAmount}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  controller.finalList[index].discount != null
                                      ? "${Constants.RUPEESYMBOOL} ${controller.finalList[index].discount}"
                                      : "",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Divider(
                              color: Colors.black12,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Fine Amount",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  "${Constants.RUPEESYMBOOL} ${controller.finalList[index].totalFineAmount}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ],
    );
  }
}
