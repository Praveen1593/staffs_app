import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/screens/payment_and_invoice/school_fee_screen.dart';
import 'package:get/get.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../controllers/payment_controller/fee_payment_controller.dart';
import '../../../themes/app_styles.dart';
import '../../../../common/widgets/common_widgets.dart';

class FeePaymentScreen extends StatelessWidget {
  FeePaymentScreen({Key? key}) : super(key: key);

  double mountHeight = 120;
  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
        appBar: smsAppbar("Fee Payment"),
        body: GetBuilder<FeePaymentController>(
            init: FeePaymentController(),
            builder: (feePaymentController){
              return feePaymentController.isLoading==false?
              feePaymentController.feeModel?.feeData!=null?
              _buildBody(feePaymentController, context):SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child:  Center(
                  child: Text("Something went wrong ${feePaymentController.feeModel?.code}"),
                ),
              ):SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            })
    );




  }

  Widget _buildBody(FeePaymentController feePaymentController,BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFFECF4FF),
                    ),
                    child:  buildFeeTextWidget(feePaymentController,context,"Total Fee","${feePaymentController.feeModel?.feeData?.total}"),//feePaymentController.feeModel?.feeData!.total??""
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: InkWell(
                  onTap: (){

                  for(int i=0;i<feePaymentController
                      .feeModel!.feeData!.feePendingDetail!.length ;i++){

                    for(int j=0;j<feePaymentController
                        .feeModel!.feeData!.feePendingDetail![i].
                    feeGroupDetail!.length ;j++){

                      if(feePaymentController
                          .feeModel!.feeData!.feePendingDetail![i].
                      feeGroupDetail![j].paid!>0){



                      }

                    }



                  }

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFFECF4FF),
                    ),
                    child: buildFeeTextWidget(feePaymentController,context,"Paid","${feePaymentController.feeModel?.feeData?.paid}"),//feePaymentController.feeModel?.feeData!.paid??""
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: InkWell(
                  onTap: (){

                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0XFFECF4FF),
                    ),
                    child: buildFeeTextWidget(feePaymentController,context,"Pending","${feePaymentController.feeModel?.feeData?.pending}"),//feePaymentController.feeModel?.feeData!.pending??""
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10,),
         /* Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: mountHeight),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: feePaymentController
                                .feeModel!.feeData!.feePendingDetail!.length,
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
                                                  "${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].name ?? 0}",
                                                  style: AppStyles.PoppinsRegular
                                                      .copyWith(
                                                      color: Color(0XFF407BFF),
                                                      fontSize: 18),
                                                ),
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
                                                "${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].total ?? 0}",
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
                                                "${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].discount ?? 0}",
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
                                                "${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].paid ?? 0}",
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
                                                "${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].pending ?? 0}",
                                                style: AppStyles.PoppinsRegular
                                                    .copyWith(
                                                    color: Color(0XFFE93E3A),
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),

                                          *//* buildText(
                                              "Total: ${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].total ?? 0}"),
                                          buildText(
                                              "Discount: ${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].discount ?? 0}"),
                                          buildText(
                                              "Paid: ${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].paid ?? 0}"),*//*
                                        ],
                                      ),
                                    ),
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: feePaymentController
                                          .feeModel
                                          ?.feeData
                                          ?.feePendingDetail?[0]
                                          .feeGroupDetail?[index]
                                          .feeTermMonthPending
                                          ?.length ??
                                          0,
                                      //feePaymentController.feeModel!.feeData.detail![index].fees,
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
                                                            feePaymentController
                                                                .feeModel
                                                                ?.feeData
                                                                ?.feePendingDetail?[0]
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
                                                        Text("${Constants.RUPEESYMBOOL}${feePaymentController.feeModel?.feeData?.feePendingDetail?[0].feeGroupDetail?[index].feeTermMonthPending?[index1].pending ?? 0}",
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
                                                      ],
                                                    ),
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
                  )
                ],
              ),
            ),
          )*/
          Expanded(
              child: 
              DefaultTabController(
              length: feePaymentController.feeModel?.feeData!.feePendingDetail?.length??0, // length of tabs
              initialIndex: 0,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFECF4FF),
                        borderRadius: BorderRadius.circular(
                          25.0,
                        ),
                      ),
                      child: TabBar(
                        labelColor: Color(0XFFFFFFFF),
                        unselectedLabelColor: AppColors.greyColor,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0XFF407BFF)
                        ),
                        indicatorColor: AppColors.darkPinkColor,
                        controller: _tabController,
                        isScrollable: false,
                        onTap: (index){
                          //feePaymentController.selectedTotalAmt = 0.0;
                          feePaymentController.tabIndex = index;

                        },
                        tabs: feePaymentController.feeModel!=null?feePaymentController.feeModel!.feeData!.feePendingDetail!.isNotEmpty?feePaymentController.feeModel!.feeData!.feePendingDetail!.map((e) => Tab(
                          text: '${e.name}',
                        )).toList():[]:[],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: TabBarView(
                              controller: _tabController,
                              children: feePaymentController.feeModel!=null?feePaymentController.feeModel!.feeData!.feePendingDetail!.map((e) {
                                print("click tab main : ${feePaymentController.tabIndex}");
                                return SchoolFeePendingScreen(e.name,2,feePaymentController);
                              }).toList():[]
                          ),
                        ),
                      ),
                    )
                  ]))
          )
        ],
      ),
    );
  }

  Column buildFeeTextWidget(FeePaymentController feePaymentController,BuildContext context,String title,String value) {
    return Column(
      children: [
         Padding(
          padding:  const EdgeInsets.only(top: 10.0),
          child: Text(title,style: AppStyles.PoppinsBold.copyWith(color: Color(0XFF407BFF),fontSize:14),),),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              const Icon(
                Icons.currency_rupee,
                color: Color(0XFF407BFF)
              ),
              Text(value,style: AppStyles.PoppinsRegular.copyWith(color: Color(0XFF407BFF),fontSize: 20),),
            ],
          ),
        ),
      ],
    );
  }
}

