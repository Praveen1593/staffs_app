import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/staff_common_widgets.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../controllers/payment_controller/fee_payment_controller.dart';
import '../../../controllers/payment_controller/fee_pending_controller.dart';
import '../../../model/fee_model.dart';
import '../../../themes/app_styles.dart';
import '../../../../common/widgets/common_widgets.dart';
import '../payment/paymentscreen.dart';

class SchoolFeePendingScreen extends StatelessWidget {
  FeeModel? feeModel;
  double mountHeight = 120;
  String? feeName;
  int paymentGateway = 1; // 1 - KNET | 2 - RazorPay

  late Razorpay razorpay;
  int? type;
  int? paymentIndex=0;
  FeePaymentController? feePaymentController;


  SchoolFeePendingScreen(this.feeName,this.type,[this.feePaymentController]);

  @override
  Widget build(BuildContext context) {


    void _handlePaymentSuccess(PaymentSuccessResponse response) {
      // Do something when payment succeeds
     // print("payment Success");
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

    return GetBuilder<FeePendingController>(
        init: FeePendingController(),
        builder: (feePendingController) {
          print("click tab : $paymentIndex");
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: type==1?mountHeight:0),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: feePendingController
                            .feeModel!=null?feePendingController
                            .feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail!.length:0,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Card(
                                elevation: 5,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 15.0,
                                      right: 15.0,
                                      top: 10,
                                      bottom: 10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 6.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              "${feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].name ?? 0}",
                                              style: AppStyles.PoppinsRegular
                                                  .copyWith(
                                                  color: Color(0XFF407BFF),
                                                  fontSize: 18),
                                            ),
                                            type==1?
                                            Visibility(
                                              visible: feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].feeTermMonthPending!=null&&feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].feeTermMonthPending!.isNotEmpty?false:true,
                                              child: Checkbox(
                                                  checkColor: Colors.white,
                                                  activeColor: Color(0XFFFC8828),
                                                  value: feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].checkboxClicked!=null&&feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].checkboxClicked!?true:false,
                                                  onChanged: (value){

                                                    feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].checkboxClicked = value!;

                                                    if(value!){
                                                      feePendingController.selectedTotalAmt += feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].pending!.toDouble();
                                                      //  feePendingController.selectedTotalAmt -= subTotal;
                                                      print("add total amt : ${feePendingController.selectedTotalAmt}");
                                                    }else{
                                                      feePendingController.selectedTotalAmt -= feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].pending!.toDouble();
                                                      print("minus total amt : ${feePendingController.selectedTotalAmt}");
                                                    }
                                                    print("Selected Fine Value : ${feePendingController.selectedTotalAmt}");
                                                    print("Selected Fine Value : $value!");
                                                    feePendingController.update();

                                                  }),
                                            ):Container()
                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Total",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  ":",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].total ?? 0}",
                                            style: AppStyles.PoppinsRegular
                                                .copyWith(
                                                color: Color(0XFF252525),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Discount",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  ":",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].discount ?? 0}",
                                            style: AppStyles.PoppinsRegular
                                                .copyWith(
                                                color: Color(0XFF252525),
                                                fontSize: 14),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Paid",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  ":",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].paid ?? 0}",
                                            style: AppStyles.PoppinsRegular
                                                .copyWith(
                                                color: Color(0XFF5B9D00),
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10,),
                                      Row(
                                        children: [
                                          Container(
                                            width: 80,
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Pending",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                                Spacer(),
                                                Text(
                                                  ":",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF252525),
                                                      fontSize: 14),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(width: 10,),
                                          Text(
                                            "${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].pending ?? 0}",
                                            style: AppStyles.PoppinsRegular
                                                .copyWith(
                                                color: Color(0XFFE93E3A),
                                                fontSize: 18),
                                          ),
                                        ],
                                      ),

                                     /* buildText(
                                          "Total: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].total ?? 0}"),
                                      buildText(
                                          "Discount: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].discount ?? 0}"),
                                      buildText(
                                          "Paid: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].paid ?? 0}"),*/
                                    ],
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: feePendingController
                                          .feeModel
                                          ?.feeData
                                          ?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!]
                                          .feeGroupDetail?[index]
                                          .feeTermMonthPending
                                          ?.length ??
                                      0,
                                  //feePendingController.feeModel!.feeData.detail![index].fees,
                                  itemBuilder:
                                      (BuildContext context, int index1) {
                                    return InkWell(
                                      onTap: () {
                                        //feeController.checkExpanedView();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5,right: 5,top: 15),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            border: Border.all(width: 1,color: Color(0XFFCCCCCC))
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(left: 15,right: 15,top: 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        feePendingController
                                                            .feeModel
                                                            ?.feeData
                                                            ?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!]
                                                            .feeGroupDetail?[index]
                                                            .feeTermMonthPending?[index1]
                                                            .name ??
                                                            "",
                                                        style: AppStyles
                                                            .PoppinsRegular
                                                            .copyWith(
                                                          fontSize: 18,
                                                          color: AppColors
                                                              .blackColor,
                                                        )),
                                                    Spacer(),
                                                    Text("${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].feeTermMonthPending?[index1].pending ?? 0}",
                                                        style: AppStyles
                                                            .NunitoExtrabold
                                                            .copyWith(
                                                          fontSize: 18,
                                                          color: Color(0XFF407BFF),
                                                        )),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                        "PENDING",
                                                        style: AppStyles
                                                            .PoppinsRegular
                                                            .copyWith(
                                                          fontSize: 15,
                                                          color: Color(0XFF93A0A7),
                                                        )),
                                                    Spacer(),
                                                    type==1?
                                                    Visibility(
                                                      visible: true,
                                                      child: Checkbox(value: feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].feeTermMonthPending?[index1].checkboxClicked!=null&&feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].feeTermMonthPending![index1].checkboxClicked!?true:false,
                                                          checkColor: Colors.white,
                                                          activeColor: Color(0XFFFC8828),
                                                          onChanged: (value){

                                                            feePendingController.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail?[index].feeTermMonthPending?[index1].checkboxClicked = value!;
                                                            if(value!){

                                                              feePendingController.selectedTotalAmt += feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].feeTermMonthPending![index1].pending!.toDouble();
                                                              print("add sub total amt : ${feePendingController.selectedTotalAmt}");
                                                            }else{
                                                              feePendingController.selectedTotalAmt -= feePendingController.feeModel!.feeData!.feePendingDetail![type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].feeGroupDetail![index].feeTermMonthPending![index1].pending!.toDouble();
                                                              print("add sub total amt : ${feePendingController.selectedTotalAmt}");
                                                            }
                                                            print("Selected Fine Value : ${feePendingController.selectedTotalAmt}");
                                                            print("Selected Fine Value : $value!");
                                                            feePendingController.update();

                                                          }),
                                                    ):Container(),
                                                  ],
                                                ),
                                               /* Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 8.0,
                                                      left: 8,
                                                      right: 8.0,
                                                      bottom: 8),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text("Pending",
                                                              style: AppStyles
                                                                  .arimoRegular
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .blackColor,
                                                                      fontSize:
                                                                          12)),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                              "${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].feeTermMonthPending?[index1].pending ?? 0}",
                                                              style: AppStyles
                                                                  .arimBold
                                                                  .copyWith(
                                                                      color: AppColors
                                                                          .indianRedColor,
                                                                      fontSize:
                                                                          15)),
                                                          Visibility(
                                                            visible: true,
                                                            child: Checkbox(value: feePendingController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].feeTermMonthPending?[index1].checkboxClicked!=null&&feePendingController.feeModel!.feeData!.feePendingDetail![0].feeGroupDetail![index].feeTermMonthPending![index1].checkboxClicked!?true:false,
                                                                onChanged: (value){

                                                                  feePendingController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].feeTermMonthPending?[index1].checkboxClicked = value!;
                                                                  if(value!){

                                                                    feePendingController.selectedTotalAmt += feePendingController.feeModel!.feeData!.feePendingDetail![0].feeGroupDetail![index].feeTermMonthPending![index1].pending!.toDouble();
                                                                    print("add sub total amt : ${feePendingController.selectedTotalAmt}");
                                                                  }else{
                                                                    feePendingController.selectedTotalAmt -= feePendingController.feeModel!.feeData!.feePendingDetail![0].feeGroupDetail![index].feeTermMonthPending![index1].pending!.toDouble();
                                                                    print("add sub total amt : ${feePendingController.selectedTotalAmt}");
                                                                  }
                                                                  print("Selected Fine Value : ${feePendingController.selectedTotalAmt}");
                                                                  print("Selected Fine Value : $value!");
                                                                  feePendingController.update();

                                                                }),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),*/
                                                /* Visibility(
                                                  visible: truefeeController.expandCard
                                                      ? true
                                                      : false,
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        left: 20.0,
                                                        right: 20.0,
                                                        top: 10.0,
                                                        bottom: 10.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Due Details",
                                                          style: AppStyles
                                                                  .NunitoExtrabold
                                                              .copyWith(
                                                                  fontSize: 10,
                                                                  color:
                                                                      Colors.black45),
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
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Total fine Days",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                            Text(
                                                              "8",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Single Day Fine",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${Constants.RUPEESYMBOOL} 5.00",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Fine Amount",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${Constants.RUPEESYMBOOL} 30.00",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Lost Book Amount",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${Constants.RUPEESYMBOOL} 0.00",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Discount",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${Constants.RUPEESYMBOOL} 0.00",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
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
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              "Total fine Days",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
                                                                      fontSize: 13),
                                                            ),
                                                            Text(
                                                              "${Constants.RUPEESYMBOOL} 30.00",
                                                              style: AppStyles
                                                                      .NunitoRegular
                                                                  .copyWith(
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
                                                ),*/
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  })
                            ],
                          );
                        }),
                  ),
                ),
              ),
              type==1?
              _feePendingTotalAMountCard(feePendingController):Container()
            ],
          );
        });
  }

  Widget _feePendingTotalAMountCard(FeePendingController feePendingController) {
    return GetBuilder<FeePendingController>(
        init: FeePendingController(),
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
                      elevation: 5,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15, right: 15, top: 4.0, bottom: 4),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total : ${Constants.RUPEESYMBOOL}${controller.feeModel?.feeData?.feePendingDetail?[type==1?feePendingController.tabIndex!:feePaymentController!.tabIndex!].total ?? 0}",
                                    style: AppStyles.PoppinsRegular.copyWith(
                                        color: Color(0XFF252525), fontSize: 17),
                                  ),
                                  Text(
                                    "${Constants.RUPEESYMBOOL}${feePendingController.selectedTotalAmt}",
                                    style: AppStyles.PoppinsBold.copyWith(
                                        color: Color(0XFF407BFF), fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10,right: 10,top: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      onTap:(){
                                        var options = {
                                          "key":"rzp_test_SQ8XuHbju2bfAU",
                                          "amount":num.parse("${feePendingController.selectedTotalAmt}")*100,
                                          "name":"$feeName",
                                          "description":"${feePendingController.feeModel}",
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
                                      child: Container(
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Text(
                                              "Pay",
                                              style: AppStyles.PoppinsBold.copyWith(
                                                  color: Colors.white, fontSize: 17),
                                            ),
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Color(0XFF407BFF)
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            "Cancel",
                                            style: AppStyles.PoppinsRegular.copyWith(
                                                color: Color(0XFF407BFF), fontSize: 17),
                                          ),
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          color: Colors.white,
                                          border: Border.all(color: Color(0XFFBBBBBB),width: 1)
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /*Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    Text(
                                      "Total : ${Constants.RUPEESYMBOOL}${controller.feeModel?.feeData?.feePendingDetail?[0].total ?? 0}",
                                      style: AppStyles.arimoRegular.copyWith(
                                          color: AppColors.blackColor, fontSize: 15),
                                    ),
                                    const SizedBox(height: 10,),
                                    Text(
                                      "${Constants.RUPEESYMBOOL}${feePendingController.selectedTotalAmt}",
                                      style: AppStyles.arimBold.copyWith(
                                          color: AppColors.darkPinkColor, fontSize: 20),
                                    ),

                                    *//*
                              Text(
                                  "Discount : ${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.detail?[0].discount ?? 0}"),
                              Text(
                                  "Paid: ${Constants.RUPEESYMBOOL}${feePendingController.feeModel?.feeData?.detail?[0].paid ?? 0}"),*//*
                                  ],
                                ),
                                Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: (){

                                        var options = {
                                          "key":"rzp_test_SQ8XuHbju2bfAU",
                                          "amount":num.parse("${feePendingController.selectedTotalAmt}")*100,
                                          "name":"$feeName",
                                          "description":"Pending Fee",
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

                                       *//* if(paymentGateway==1){
                                          //KNET

                                          Get.to(PaymentScreen(feePendingController.feeModel?.feeData?.detail?[0].pending));

                                        }else{
                                          //RazorPay


                                        }*//*



                                      },
                                      child: const Text("RazorPay"),
                                    ),
                                    const SizedBox(width: 10,),
                                    ElevatedButton(
                                      onPressed: (){

                                        Get.to(PaymentScreen(feePendingController.feeModel?.feeData?.feePendingDetail?[0].pending));

                                      },
                                      child: const Text("KNET"),
                                    ),
                                  ],
                                )

                              ],
                            ),*/
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
