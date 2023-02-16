import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/staff_controller/staff_details_controller.dart';
import '../../../../themes/app_styles.dart';
import '../../../../utils/widget_functions.dart';
import '../../../../../common/widgets/common_widgets.dart';


class StaffDetailsScreen extends StatelessWidget {
  double padding = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("Staff Details"),
        body: GetBuilder<StaffDetailsController>(
          init: StaffDetailsController(),
          builder: (staffController) {
            return staffController.isLoading==false? staffController.staffModel?.data!=null?SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: padding,horizontal: padding),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, bottom: 18, top: 15),
                          child: Card(
                            elevation: 5,
                            child: Padding(
                              padding:
                              const EdgeInsets.only(left: 30.0, top: 3, bottom: 3),
                              child: ListTile(
                                title: Text(
                                  "${staffController.staffModel?.data!.classTeacher!.name} - ${staffController.staffModel?.data!.classTeacher!.code}",
                                  style: AppStyles.arimBold.copyWith(color: AppColors.darkPinkColor,fontSize: 16),
                                ),
                                subtitle: Text("Class Teacher",style: AppStyles.arimoRegular.copyWith(color: Colors.black,fontSize: 12)),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: -15,
                          top: 30,
                          child: Container(
                              width: 100.0,
                              height: 60.0,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          '${staffController.staffModel?.data!.classTeacher!.photo}')))),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: padding),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: staffController.staffModel?.data?.subjectList?.length??0,
                        itemBuilder: (context, index) => staffCardDesign(staffController,index)),
                  ),
                ],
              ),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: Text("no Data Found"),
              ),
            ):
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
        ));
  }

  Widget staffCardDesign(StaffDetailsController staffController,int index) {
    return
      staffController.staffModel?.data?.subjectList?[index].staffDetail?.employeeId!=null?
      Card(
      elevation: 3,
      child: Column(
        children: [
          IgnorePointer(
            ignoring: staffController.staffModel!.data!.subjectList![index].children!.isNotEmpty?false:true,
            child: ExpansionTile(
              leading: Container(
                  width: 50.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image:
                          NetworkImage('${staffController.staffModel?.data?.subjectList?[index].staffDetail?.employeePhoto}')))),
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${staffController.staffModel?.data?.subjectList?[index].staffDetail?.employeeName} - ${staffController.staffModel?.data?.subjectList?[index].staffDetail?.employeeCode}",
                    style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  addVerticalSpace(5),
                  Row(
                    children: [
                      Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      '${staffController.staffModel?.data?.subjectList?[index].subject?.icon}')))),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text("${staffController.staffModel?.data?.subjectList?[index].subject?.name} - ${staffController.staffModel?.data?.subjectList?[index].subject?.code}",
                          style: AppStyles.arimoRegular.copyWith(color: Colors.black,fontSize: 12),),
                      )
                    ],
                  )
                ],
              ),
              collapsedIconColor: staffController.staffModel!.data!.subjectList![index].children!.isEmpty?Colors.white:Colors.black,
              iconColor: staffController.staffModel!.data!.subjectList![index].children!.isEmpty?Colors.white:Colors.black,
              children: [
                ListView.builder(
                    itemCount: staffController.staffModel?.data?.subjectList?[index].children?.length??0,
                    shrinkWrap: true,
                    itemBuilder: (context, index1) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${staffController.staffModel?.data?.subjectList?[index].children?[index1].staffDetail?.employeeName} - ${staffController.staffModel?.data?.subjectList?[index].children?[index1].staffDetail?.employeeCode}",
                            style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          addVerticalSpace(5),
                          Row(
                            children: [
                              Container(
                                  width: 20.0,
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                              '${staffController.staffModel?.data?.subjectList?[index].staffDetail?.employeePhoto}')))),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text("${staffController.staffModel?.data?.subjectList?[index].children?[index1].subject?.name}",
                                  style: AppStyles.arimoRegular.copyWith(color: Colors.black,fontSize: 12),),
                              )
                            ],
                          )
                        ],
                      ).paddingOnly(top: 5,bottom: 5);
                    }).paddingOnly(left: 80,bottom: 10),
              ],
            ),
          ),
        ],
      ),
    ):Container();
  }
}
