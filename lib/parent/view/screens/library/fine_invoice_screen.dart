import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../controllers/library_controller/fine_invoice_controller.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class FineInvoiceScreen extends GetView<FineInvoiceController> {
  FineInvoiceScreen({Key? key}) : super(key: key);
  int? selectView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar:  smsAppbar("Fine Invoice"),
        body:Obx(() {
          final loadingType = controller.loadingState.value.loadingType;
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (controller.finalList.isEmpty) {
            return const Center(child: Text("No Data"));
          }
          return GetBuilder<FineInvoiceController>(
              builder: (renew) {
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
                            return _buildBody(controller, context,index);
                          }
                        },
                        separatorBuilder: (context, index) => Container(),
                      ),
                    )
                  ],
                );
              }
          );
        })
    );
  }

  Widget _buildBody(
      FineInvoiceController fineInvoiceController, BuildContext context,int index) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 5),
              child: SizedBox(
                child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                                    "${controller.finalList[index].code}",
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
                                    "Bill Date : ${controller.finalList[index].billDate}",
                                    style: AppStyles.NunitoRegular.copyWith(
                                        fontSize: 13),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Payment Mode : ${controller.finalList[index].billPayType}",
                                    style: AppStyles.NunitoRegular.copyWith(
                                        fontSize: 13),
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
                                    "${Constants.RUPEESYMBOOL} ${controller.finalList[index].totalFine}",
                                    style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 15,
                                      color: AppColors.darkGreenColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Paid",
                                    style: AppStyles.NunitoRegular.copyWith(
                                        fontSize: 11),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20,top: 10,bottom: 10),
                          child: Row(
                            children: [
                              Flexible(
                                  child: SMSButtonWidget(
                                    onPress: () {
                                      selectView = 1;
                                      if(controller.showBookDetails.value){
                                        fineInvoiceController.showBookDetails.value=false;
                                      }
                                      fineInvoiceController.checkView(selectView!);
                                    },
                                    text: "PAYMENT",
                                    width: width,
                                    height: 35,
                                    borderRadius: 5,
                                    primaryColor: AppColors.darkPinkColor,
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                  child: SMSButtonWidget(
                                    onPress: () {
                                      selectView = 2;
                                      if(fineInvoiceController.showPaymentDetails.value){
                                        fineInvoiceController.showPaymentDetails.value=false;
                                      }
                                      fineInvoiceController.checkView(selectView!);
                                    },
                                    text: "   BOOK\nDETAILS",
                                    width: width,
                                    height: 35,
                                    borderRadius: 5,
                                    primaryColor: AppColors.darkPinkColor,
                                  )),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: fineInvoiceController.showPaymentDetails.value?true:false,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0,
                                right: 20.0,
                                top: 10.0,
                                bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Details",
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total fine",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${controller.finalList[index].totalFine}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13),
                                    ),
                                    Text(
                                      controller.finalList[index].discount!=null?"${Constants.RUPEESYMBOOL} ${controller.finalList[index].discount}":"",
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
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total fine Amount",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 13),
                                    ),
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${controller.finalList[index].total}",
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
                        Visibility(
                          visible: fineInvoiceController.showBookDetails.value?true:false,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Text(
                                  "Book Details",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 10, color: Colors.black45),
                                ),
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
                              ListView.builder(
                                  itemCount:controller.finalList[index].finePaymentItem?.length??0,
                                  shrinkWrap: true,
                                  itemBuilder: (context,index1){
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20.0,
                                          right: 20.0,
                                          top: 10.0,
                                          bottom: 10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${controller.finalList[index].finePaymentItem?[index1].bookName}",
                                                    style: AppStyles.NunitoExtrabold.copyWith(
                                                        fontSize: 15),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Total Dine Days : ${controller.finalList[index].finePaymentItem?[index1].totalFineDays}",
                                                    style: AppStyles.NunitoRegular.copyWith(
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    "Single Day Fine : ${Constants.RUPEESYMBOOL} ${controller.finalList[index].finePaymentItem?[index1].singleDayFine}",
                                                    style: AppStyles.NunitoRegular.copyWith(
                                                        fontSize: 13),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                ],
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
                                                      "${Constants.RUPEESYMBOOL} ${controller.finalList[index].finePaymentItem?[index1].totalFineAmount}",
                                                      style: AppStyles.NunitoExtrabold.copyWith(
                                                        fontSize: 15,
                                                        color: AppColors.blackColor,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  }
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ));
  }
}
