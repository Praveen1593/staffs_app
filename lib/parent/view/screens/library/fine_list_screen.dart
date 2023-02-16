import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../../common/widgets/staff_common_widgets.dart';
import '../../../controllers/library_controller/fine_list_controller.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class FineListScreen extends GetView<FineListController> {
  double selectedTotalAmt = 0;
  double mountHeight = 100;
  late Razorpay razorpay;

  @override
  Widget build(BuildContext context) {

    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      // Do something when payment succeeds
      // print("payment Success");



      print("payment Success : orderId - ${response.orderId}");
      print("payment Success : paymentId - ${response.paymentId}");
      print("payment Success : signature - ${response.signature}");
      //showStaffToastMsg("payment Success");
    }

    void _handlePaymentError(PaymentFailureResponse response) {
      // Do something when payment fails
      // print("payment Fail");
     // showStaffToastMsg("payment Fail");
    }

    void _handleExternalWallet(ExternalWalletResponse response) {
      // Do something when an external wallet is selected
      // print("payment Wait");
     // showStaffToastMsg("payment Wait");
    }

    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);



    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("Fine List"),
        body: Stack(
          children: [
            Obx(() {
              final loadingType = controller.loadingState.value.loadingType;
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator.adaptive());
              }
              if (controller.finalList.isEmpty) {
                return const Center(child: Text("No Data"));
              }
              return GetBuilder<FineListController>(builder: (fineList) {
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
            }),
            _feePendingTotalAMountCard(controller)
          ],
        ));

    // GetBuilder<FineListController>(
    //   init: FineListController(),
    //   builder: (fineListController){
    //     return _buildBody(fineListController,context);
    //   });
  }

  Widget _buildBody(
      FineListController fineListController, BuildContext context, int index) {
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
                        // controller.checkView(index);
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
                                  height: 2,
                                ),
                                Text(
                                  "Date : ${controller.finalList[index].date}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Academic Year : ${controller.finalList[index].academic}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 12),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  "Library Code : ${controller.finalList[index].code}",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 12),
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
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${Constants.RUPEESYMBOOL} ${controller.finalList[index].fineAmount}",
                                      style: AppStyles.NunitoExtrabold.copyWith(
                                        fontSize: 15,
                                        color: AppColors.indianRedColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Text(
                                      "${controller.finalList[index].fineStatus}",
                                      style: AppStyles.NunitoRegular.copyWith(
                                          fontSize: 11),
                                    ),
                                  ],
                                ),
                                Checkbox(value: controller.fineListData[index].checkboxClicked!=null&&controller.fineListData[index].checkboxClicked?true:false, onChanged: (value){

                                  controller.fineListData[index].checkboxClicked = value!;
                                  if(value!){
                                    selectedTotalAmt += controller.fineListData[index].totalFineAmount!=null&&controller.fineListData[index].totalFineAmount!.isNotEmpty?double.parse(controller.fineListData[index].totalFineAmount.toString()):0;
                                  }else{
                                    selectedTotalAmt -= controller.fineListData[index].totalFineAmount!=null&&controller.fineListData[index].totalFineAmount!.isNotEmpty?double.parse(controller.fineListData[index].totalFineAmount.toString()):0;
                                  }
                                  print("Selected Fine Value : $selectedTotalAmt");
                                  controller.update();

                                })
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Visibility(
                      visible: controller.fineListData[index].isClicked
                          ? true
                          : false,
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
                                  "${fineListController.finalList[index].totalFineDays ?? 0}",
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
                                  "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].singleDayFine ?? 0}",
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
                                  "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].fineAmount ?? 0}",
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
                                  "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].lostBookAmount ?? 0}",
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
                                  fineListController
                                      .finalList[index].discount !=
                                      null
                                      ? "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].discount}"
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
                                  "Total fine Days",
                                  style: AppStyles.NunitoRegular.copyWith(
                                      fontSize: 13),
                                ),
                                Text(
                                  "${Constants.RUPEESYMBOOL} ${fineListController.finalList[index].totalFineAmount}",
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

  Widget _feePendingTotalAMountCard(FineListController feePendingController) {
    return GetBuilder<FineListController>(
        init: FineListController(),
        builder: (controller){
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: double.infinity,
                  height: mountHeight,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Total : ${Constants.RUPEESYMBOOL}${controller.totalAmt}",
                                style: AppStyles.arimoRegular.copyWith(
                                    color: AppColors.blackColor, fontSize: 15),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                "${Constants.RUPEESYMBOOL}$selectedTotalAmt",
                                style: AppStyles.arimBold.copyWith(
                                    color: AppColors.darkPinkColor, fontSize: 20),
                              ),
                            ],
                          ),
                            ElevatedButton(
                              onPressed: (){
                                 var options = {
                                "key":"rzp_test_SQ8XuHbju2bfAU",
                                "amount":num.parse("$selectedTotalAmt")*100,
                                "name":" Library Fine",
                                "description":"Library Fine",
                                "prefill":{
                                  "contact":"9840195428",
                                  "email":"aravindviijay.developer@gmail.com",
                                },
                                "external":{
                                  "wallets":["paytm"],
                                }
                              };
                              try{
                                razorpay.open(options);
                              }catch(e){
                                print(e.toString());
                              }

                              },
                              child: const Text("Pay Fine"),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          );
        });

  }
}
