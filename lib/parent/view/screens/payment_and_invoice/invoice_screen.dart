import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../../common/const/image_constants.dart';
import '../../../controllers/daily_activity_controller/payment_invoice_controller/fee_invoice_controller.dart';
import '../../../themes/app_styles.dart';
import '../../../../common/widgets/common_widgets.dart';

class InvoiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Invoice"),
      body: GetBuilder<FeeInvoiceController>(
          init: FeeInvoiceController(),
          builder: (feeInvoiceController) {
            return feeInvoiceController.feeInvoiceSingleModel?.data!=null?Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SMSImageAsset(
                        image: ImageConstants.smsBandSplashImg,
                        height: 60,
                        width: 90,
                      ),
                      schoolMAnagementText(context)
                    ],
                  ),
                ),
                ListView.builder(
                        shrinkWrap: true,
                        itemCount: feeInvoiceController.feeInvoiceSingleModel
                                ?.data?.feeDetail?.length ??
                            0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Text(
                                  "FrNo : ${feeInvoiceController.feeInvoiceSingleModel?.data?.frNo}",
                                  style: AppStyles.arimoRegular.copyWith(fontSize: 16, color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                child: Text(
                                  "Bill Date : ${feeInvoiceController.feeInvoiceSingleModel?.data?.billDate}",
                                  style: AppStyles.arimoRegular.copyWith(fontSize: 16, color: Colors.black),
                                ),
                              ),
                              const SizedBox(height: 5,),
                              schoolFeeText(feeInvoiceController, context, index),
                              ListView.builder(
                                itemCount: feeInvoiceController
                                        .feeInvoiceSingleModel
                                        ?.data
                                        ?.feeDetail?[index]
                                        .fees
                                        ?.length ??
                                    0,
                                shrinkWrap: true,
                                itemBuilder: (context, index1) {
                                  return ListView.builder(
                                    itemCount: feeInvoiceController
                                            .feeInvoiceSingleModel
                                            ?.data
                                            ?.feeDetail?[index]
                                            .fees?[index1]
                                            .items
                                            ?.length ??
                                        0,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index2) => Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "${feeInvoiceController.feeInvoiceSingleModel?.data?.feeDetail?[index].fees?[index1].items?[index2].name}"),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.currency_rupee,
                                                color: AppColors.blackColor,
                                              ),
                                              Text(
                                                "${feeInvoiceController.feeInvoiceSingleModel?.data?.feeDetail?[index].fees?[index1].items?[index2].amount}",
                                                style: AppStyles.arimBold
                                                    .copyWith(
                                                        color: AppColors
                                                            .blackColor,
                                                        fontSize: 16),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        }),
                totalAMountCard(feeInvoiceController)
              ],
            ):SizedBox(
            height: MediaQuery.of(context).size.height / 1.3,
            child: const Center(
            child: CircularProgressIndicator(),
            ),
            );
          }),
    );
  }

  Widget schoolMAnagementText(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.55,
      child: Text(
        Constants.SCHOOLTEXT,
        maxLines: 2,
        overflow: TextOverflow.fade,
        style: AppStyles.normal
            .copyWith(color: AppColors.blackColor, fontSize: 16),
      ),
    );
  }

  Widget schoolFeeText(FeeInvoiceController feeInvoiceController,
      BuildContext context, int index) {
    return Container(
      height: 50,
      width: MediaQuery.of(context).size.width,
      color: AppColors.darkPinkColor,
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: Text(
          "${feeInvoiceController.feeInvoiceSingleModel?.data?.feeDetail?[index].name}",
          style: AppStyles.arimBold.copyWith(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }

  Widget totalAMountCard(FeeInvoiceController feeInvoiceController) {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 4.0, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "Payment Type : ${feeInvoiceController.feeInvoiceSingleModel?.data?.billPayType}"),
                        Padding(
                          padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                          child: Text(
                              "Discount Type : ${feeInvoiceController.feeInvoiceSingleModel?.data?.discountType}"),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${Constants.RUPEESYMBOOL} ${feeInvoiceController.feeInvoiceSingleModel?.data?.total}",
                            style: AppStyles.arimBold.copyWith(
                                color: AppColors.darkPinkColor, fontSize: 20),
                          ),
                          Text(
                            "Total",
                            style: AppStyles.normal.copyWith(
                                color: AppColors.greyColor, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
