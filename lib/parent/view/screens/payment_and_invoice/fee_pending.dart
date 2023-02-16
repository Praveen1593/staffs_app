import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/screens/payment_and_invoice/school_fee_screen.dart';
import 'package:get/get.dart';

import '../../../../common/const/colors.dart';
import '../../../controllers/payment_controller/fee_pending_controller.dart';
import '../../../../common/widgets/common_widgets.dart';

class FeePendingScreen extends StatelessWidget{


  TabController? _tabController;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FeePendingController>(
      init: FeePendingController(),
        builder: (feePendingController){
        return _buildBody(feePendingController, context);
        });

  }


  Widget _buildBody(FeePendingController feePendingController,BuildContext context){
    return Scaffold(
        appBar: smsAppbar("Fee Pending"),
        body:feePendingController.feeModel?.feeData!=null?
        DefaultTabController(
            length: feePendingController.feeModel?.feeData!.feePendingDetail?.length??0, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  TabBar(
                    controller: _tabController,
                    labelColor: AppColors.darkPinkColor,
                    unselectedLabelColor: AppColors.greyColor,
                    indicatorColor: AppColors.darkPinkColor,
                    onTap: (index){
                      feePendingController.selectedTotalAmt = 0.0;
                      feePendingController.tabIndex = index;

                      for(int i=0;i<feePendingController
                          .feeModel!.feeData!.feePendingDetail![index].
                      feeGroupDetail!.length ;i++){

                        if(feePendingController
                            .feeModel!.feeData!.feePendingDetail![index].
                        feeGroupDetail![i].checkboxClicked!){

                          feePendingController
                              .feeModel!.feeData!.feePendingDetail![index].
                          feeGroupDetail![i].checkboxClicked = false;

                        }
                        for(int j=0;j<feePendingController
                            .feeModel!.feeData!.feePendingDetail![index].
                        feeGroupDetail![i].feeTermMonthPending!.length ;j++){

                          if(feePendingController
                              .feeModel!.feeData!.feePendingDetail![index].
                          feeGroupDetail![i].feeTermMonthPending![j].checkboxClicked!){

                            feePendingController
                                .feeModel!.feeData!.feePendingDetail![index].
                            feeGroupDetail![i].feeTermMonthPending![j].checkboxClicked = false;

                          }
                        }

                      }
                      feePendingController.update();

                    },
                    tabs: feePendingController.feeModel!=null?feePendingController.feeModel!.feeData!.feePendingDetail!.isNotEmpty?feePendingController.feeModel!.feeData!.feePendingDetail!.map((e) => Tab(
                      text: '${e.name}',
                    )).toList():[]:[],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    //
                    child: TabBarView(
                        controller: _tabController,
                        children: feePendingController.feeModel!=null?feePendingController.feeModel!.feeData!.feePendingDetail!.map((e) {
                          return SchoolFeePendingScreen(e.name,1);
                        }).toList():[]
                    ),
                  )
                ])):SizedBox(
          height: MediaQuery.of(context).size.height / 1.3,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        )
    );
  }


}
