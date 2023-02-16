import 'package:flutter/material.dart';
import 'package:flutter_projects/staff/controller/attendance_controller/attendance_details_controller.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../common/const/colors.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../../parent/themes/app_styles.dart';


class StaffAttendanceDetailsScreen extends StatelessWidget {
  StaffAttendanceDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("Staff Attendance"),
        body: GetBuilder<StaffAttendanceDetailsController>(
            init: StaffAttendanceDetailsController(),
            builder: (staffAttendanceDetailsController) {
              return staffAttendanceDetailsController.staffAttendanceDisplayModel?.data!=null?
                SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 200,
                          child: SfCircularChart(series: <CircularSeries>[
                            // Renders doughnut chart
                            DoughnutSeries<ChartDatas, String>(
                                dataSource: staffAttendanceDetailsController.chartDatas,
                                animationDuration: 5000,
                                radius: '100%',
                                dataLabelSettings:
                                const DataLabelSettings(isVisible: true),
                                dataLabelMapper: (ChartDatas data, _) => data.x,
                                pointColorMapper: (ChartDatas data, _) =>
                                data.color,
                                xValueMapper: (ChartDatas data, _) => data.x,
                                yValueMapper: (ChartDatas data, _) => data.y)
                          ]),
                        ),
                        Column(
                          children: [
                            Container(
                              decoration: _decorationOverview(),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildBoldText(text: "Today Attendance",fontSize: 15),
                                    _buildRegularText(text: "Attendance\nnot taken",fontSize: 13)
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: _decorationOverview(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      child:  Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildBoldText(text: "Working Days",fontSize: 15),
                                              _buildRegularText(text: "${staffAttendanceDetailsController.staffAttendanceDisplayModel?.data?.noOfWorkingDays}",fontSize: 13)
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          _attdanceLinearIndicator(staffAttendanceDetailsController,0.5,Colors.red,1),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: _decorationOverview(),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                      child:  Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              _buildBoldText(text: "Present",fontSize: 15),
                                              _buildRegularText(text: "${staffAttendanceDetailsController.staffAttendanceDisplayModel?.data?.present}",fontSize: 13)
                                            ],
                                          ),
                                          const SizedBox(height: 10,),
                                          _attdanceLinearIndicator(staffAttendanceDetailsController,0.5,Colors.red,2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Container(
                              decoration: _decorationOverview(),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildBoldText(text: "Absent",fontSize: 15),
                                        _buildRegularText(text: "${staffAttendanceDetailsController.staffAttendanceDisplayModel?.data?.absent}",fontSize: 13)
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    _attdanceLinearIndicator(staffAttendanceDetailsController,0.5,Colors.red,3),
                                    const SizedBox(height: 25,),
                                    Row(
                                      children: [
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  _buildBoldText(text: "LOP",fontSize: 15),
                                                  _buildRegularText(text: "${staffAttendanceDetailsController.staffAttendanceDisplayModel?.data?.leaveList?[0].absentDetail?.total}",fontSize: 13)
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              _attdanceLinearIndicator(staffAttendanceDetailsController,0.5,Colors.red,4),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 20,),
                                        Expanded(
                                          flex: 1,
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  _buildBoldText(text: "Casual Leave",fontSize: 15),
                                                  _buildRegularText(text: "${staffAttendanceDetailsController.staffAttendanceDisplayModel?.data?.leaveList?[1].absentDetail?.total}",fontSize: 13)
                                                ],
                                              ),
                                              const SizedBox(height: 10,),
                                              _attdanceLinearIndicator(staffAttendanceDetailsController,0.5,Colors.red,5),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 25,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildBoldText(text: "Medical Leave",fontSize: 15),
                                        _buildRegularText(text: "${staffAttendanceDetailsController.staffAttendanceDisplayModel?.data?.leaveList?[2].absentDetail?.total}",fontSize: 13)
                                      ],
                                    ),
                                    const SizedBox(height: 10,),
                                    _attdanceLinearIndicator(staffAttendanceDetailsController,0.5,Colors.red,6),
                                    const SizedBox(height: 10,),
                                  ],
                                ),
                              ),
                            ),

                          ],
                        )

                      ]),
                ),
              ):SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }

  Text _buildBoldText({String? text, double? fontSize}) => Text(
    text ?? "",
    style: AppStyles.NunitoExtrabold.copyWith(
        color: AppColors.whiteColor, fontSize: fontSize ?? 15),
  );

  Text _buildRegularText({String? text, double? fontSize}) => Text(
    text ?? "",
    style: AppStyles.NunitoExtrabold.copyWith(
        color: AppColors.whiteColor, fontSize: fontSize ?? 15),
  );

  BoxDecoration _decorationOverview() {
    return const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        gradient: LinearGradient(
          colors: <Color>[
            AppColors.indigo2Color,
            AppColors.indigo2Color,
          ],
        ));
  }

  Widget _attdanceLinearIndicator(StaffAttendanceDetailsController controller,double value,Color color,int type) {
    double? displayValue;
    double? workingDays = controller.staffAttendanceDisplayModel?.data?.noOfWorkingDays?.toDouble();
    double? absent = controller.staffAttendanceDisplayModel?.data?.absent?.toDouble();
    if(type==1){
    //Working days
     // controller.staffAttendanceDisplayModel?.data?.leaveList?[1].absentDetail?.total
      displayValue = 1.0;

    }else if(type==2){
    //Present
      displayValue = (((workingDays! - (controller.staffAttendanceDisplayModel!.data!.present!.toDouble())) /
          workingDays) * 100 * 0.01);

    }else if(type==3){
    //Absent

      displayValue = (((workingDays! - (controller.staffAttendanceDisplayModel!.data!.absent!.toDouble())) /
          workingDays) * 100 * 0.01);

    }else if(type==4){
    //lop
      displayValue = (((absent! - (controller.staffAttendanceDisplayModel!.data!.leaveList![0].absentDetail!.total!.toDouble())) /
          absent) * 100 * 0.01);

    }else if(type==5){
    //casual leave
      displayValue = (((absent! - (controller.staffAttendanceDisplayModel!.data!.leaveList![1].absentDetail!.total!.toDouble())) /
          absent) * 100 * 0.01);

    }else if(type==5){
    //Medical leave
      displayValue = (((absent! - (controller.staffAttendanceDisplayModel!.data!.leaveList![2].absentDetail!.total!.toDouble())) /
          absent) * 100 * 0.01);

    }



    return LinearPercentIndicator(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      lineHeight: 10.0,
      percent: displayValue??0.0,
      linearStrokeCap: LinearStrokeCap.roundAll,
      progressColor: Colors.blue,//color
    );
  }

  Widget _cardOfAttendance(
      String txt, double type, int refVal, StaffAttendanceDetailsController homeController,Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBoldText(text: "Today Attendance",fontSize: 15),
            _buildBoldText(text: "Today Attendance",fontSize: 15),
          ],
        ).paddingOnly(top: 10, bottom: 10, left: 10, right: 10),
        /*_attdanceLinearIndicator(getPercentageCalc(
            type,
            refVal,
            homeController
        ),color)*/
      ],
    );
  }

  double getPercentageCalc(
      double type, int refVal, StaffAttendanceDetailsController homeController) {
    double workingDay = 0.0;
    double finalValue = 0.0;
    if (refVal == 1) {
      finalValue = 1.0;
    } else {
      finalValue = (type / workingDay * 100) * 0.01;
    }
    print("refVal $finalValue");
    return finalValue;
  }

  Widget overallAttendanceCard(
      BuildContext context, StaffAttendanceDetailsController controller) {
    return Container(
      color: Colors.transparent,
      child: Column(
        children: [
          _buildBoldText(text: "Today Attendance",fontSize: 15),
          Container(
            color: Colors.white10,
            child: Column(
              children: [
                _todayAttendance(context, controller),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _cardOfAttendance(
                          "Working Days",
                          0,
                          1,
                          controller,AppColors.lightOrange), //.attendanceOverviewData?.noOfWorkingDays.toString() ?? 0.toString()
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.11,
                      decoration: _decorationOverview(),
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: _cardOfAttendance(
                          "Presents",
                          0,
                          2,
                          controller,AppColors.DarkCyan),
                    ),
                  ],
                ).paddingOnly(left: 10, right: 10, top: 20, bottom: 20),
                Container(
                  decoration: _decorationOverview(),
                  child: Column(
                    children: [
                      _cardOfAttendance(
                          "Absents",
                          0,
                          3,
                          controller,AppColors.shadeOfPinkColor),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Wrap(
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.11,
                                  width: MediaQuery.of(context).size.width *
                                      0.4,
                                  child: _cardOfAttendance(
                                      "Medical Leave",
                                      0,
                                      4,
                                      controller,AppColors.orangeColor),
                                ),
                                SizedBox(
                                  height:
                                  MediaQuery.of(context).size.height *
                                      0.11,
                                  width: MediaQuery.of(context).size.width *
                                      0.4,
                                  child: _cardOfAttendance(
                                      "Causal Leave",
                                      0,
                                      5,
                                      controller,AppColors.shadeOfIndianRed),
                                ),
                                SizedBox(
                                    height:
                                    MediaQuery.of(context).size.height *
                                        0.11,
                                    child: _cardOfAttendance(
                                        "LOP Leave (loss of pay)",
                                        0,
                                        6,
                                        controller,AppColors.cornflowerBlueColor))
                              ],
                            );
                          }),
                    ],
                  ),
                ).paddingOnly(left: 10, right: 10),
                _buildSizedBoxHeight(height: 20)
              ],
            ),
          ).paddingAll(10),
        ],
      ),
    );
  }

  Widget _buildSizedBoxHeight({required double height}) {
    return SizedBox(
      height: height,
    );
  }

  Widget _todayAttendance(
      BuildContext context, StaffAttendanceDetailsController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: _decorationOverview(),
          child: Row(
            children: [
              _buildBoldText(text: "Today Attendance",fontSize: 15),
              _buildBoldText(text: "Today Attendance",fontSize: 15),
            ],
          ),
        )
      ],
    ).paddingOnly(top: 10);
  }

}

class ChartDatas {
  ChartDatas(this.x, this.y, [this.color]);

  final String x;
  final int y;
  final Color? color;
}
