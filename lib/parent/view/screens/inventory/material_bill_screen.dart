import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../controllers/inventory_controller/material_bill_controller.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class MaterialBillScreen extends GetView<MaterialBillController> {
  const MaterialBillScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar('Material bill'),
        body: Obx(() {
          final loadingType = controller.loadingState.value.loadingType;
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (controller.finalList.isEmpty) {
            return const Center(child: Text(""));
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
                      return Text(
                          controller.loadingState.value.error.toString());
                    } else if (isLastItem &&
                        loadingType == LoadingType.completed) {
                      return Text(
                          controller.loadingState.value.completed.toString());
                    } else {
                      return _buildBody(context, index);
                    }
                  },
                  separatorBuilder: (context, index) => Container(),
                ),
              )
            ],
          );
        }));
  }

  Widget _buildBody(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${controller.finalList[index].code}",
                          style:
                              AppStyles.NunitoExtrabold.copyWith(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "${controller.finalList[index].billDate}",
                          style: AppStyles.NunitoRegular.copyWith(
                              fontSize: 11, color: Colors.black38),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Bill to : ${controller.finalList[index].billTo}",
                          style: AppStyles.NunitoRegular.copyWith(fontSize: 13),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Bill Type : ${controller.finalList[index].billPayType}",
                          style: AppStyles.NunitoRegular.copyWith(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${Constants.RUPEESYMBOOL}${controller.finalList[index].amount}",
                          style: AppStyles.NunitoExtrabold.copyWith(
                            fontSize: 15,
                            color: AppColors.darkGreenColor,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            ListView.builder(
                itemCount: controller.finalList[index].items?.length ?? 0,
                shrinkWrap: true,
                itemBuilder: (context, index1) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
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
                                  "${controller.finalList[index].items?[index1].productName}",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${controller.finalList[index].items?[index1].brandName}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Size : ${controller.finalList[index].items?[index1].sizeName} | Qty : ${controller.finalList[index].items?[index1].qty}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 15.0),
                                child: Text(
                                  "${Constants.RUPEESYMBOOL}${controller.finalList[index].items?[index1].total}",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                    fontSize: 15,
                                    color: AppColors.darkGreenColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
