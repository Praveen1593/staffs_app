import 'dart:convert';

import 'package:expandable_bottom_sheet/expandable_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:get/get.dart';
import '../../../../../common/apihelper/api_helper.dart';
import '../../../../../common/database_helper.dart';
import '../../../../../common/widgets/common_widgets.dart';
import '../../../../controller/staff_exam_manager_controller/staff_exam_result_controller.dart';
import '../../../../model/ExamDBModel.dart';
import '../../../../model/standard_students_list_model.dart';
import '../../../../model/subject_assesment_exam_list_model.dart';
import '../../../../themes/app_styles.dart';
import '../../../../../common/widgets/staff_common_widgets.dart';

class StaffExamResultScreen extends StatelessWidget {

  String? overallDisplayMark;
  int childrenCount = 0;
 // DatabaseHelper databaseHelper = DatabaseHelper();
  ExamDbModel? examDbModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: smsAppbar("Exam Result"),
      body: GetBuilder<StaffExamResultController>(
          init: StaffExamResultController(),
          builder: (controller) {
            print("${controller.subjectExamListData}");
            return controller.studentsStandardListData.isNotEmpty ?
            Column(
              children: [
                _standardSubjectWidget(controller),
                (controller.patternIsLoading && controller.isLoading) ?
                SizedBox(
                    height: Get.height / 2,
                    child: const Center(child: CircularProgressIndicator())
                        .paddingAll(15)) : (controller.patternData != null &&
                    controller.overallExamResultData.isNotEmpty) ?
                SizedBox(
                  height: Get.height * 0.55,
                  child: Column(
                    children: [
                      _markContainer(controller),
                      Expanded(child: _overAllExamListWidget(controller)),

                    ],
                  ),
                ) : Container(),
                (controller.patternData != null &&
                    controller.overallExamResultData.isNotEmpty) ? Expanded(
                  child: Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: ButtonWithLinearGradiantWidget(
                        text: "SUBMIT",
                        height: 60,
                        onPress: () {},
                        width: Get.width,
                      )),
                ) : (controller.patternIsLoading && controller.isLoading)
                    ? Container()
                    : Container()
              ],
            ) : const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget _markContainer(StaffExamResultController controller) {
    return Container(
      width: Get.width,
      height: 50,
      color: AppColors.darkPinkColor,
      child: Center(
        child: Text(
          "${controller.patternData?.subject?.commonName ?? ""} ${controller
              .patternData?.examMarkType?.name ?? ""}",
          style: const TextStyle(color: AppColors.whiteColor, fontSize: 14),
        ),
      ),
    ).paddingOnly(top: 8, bottom: 8);
  }

  //bolt - mark edit bottomsheet
  Widget _overAllExamListWidget(StaffExamResultController controller) {
    return ListView.builder(
        itemCount: controller.customModelOverallExamList.length,
        shrinkWrap: true,
        physics: AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
             // controller.editedCustomModel = [];
              if(controller.editedCustomModel.isNotEmpty){

                for(int z=0;z<controller.editedCustomModel.length;z++){

                  if(controller.editedCustomModel[z].editedValue==1){

                  }else{
                    controller.editedCustomModel = [];
                    break;
                  }

                }


              }else{
                controller.editedCustomModel = [];
              }
              controller.childrenCustomModel = [];
              if(controller.patternData!.examMarkType!.items!=null&&
                  controller.patternData!.examMarkType!.items!.isNotEmpty){
                // Having Item
                for(int i = 0; i <controller.patternData!.examMarkType!.items!.length; i++) {

                  if(controller.patternData!.examMarkType!.items![i].children!.isNotEmpty){

                    //having Item Children

                    for(int k = 0; k <controller.patternData!.examMarkType!.items![i].children!.length; k++) {

                      int absentValue = 0;
                      for(int l = 0; l <controller.customModelOverallExamList[index]
                          .customOverExamResultList!.examResult!.length; l++) {

                        if(controller.patternData!.examMarkType!.items![i].children![k].id==controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![l].examMarkTypeIteId&&controller.subjectItemId==controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![l].standardSubjectItemId){

                          if(controller.customModelOverallExamList[index]
                              .customOverExamResultList!.examResult![l].absent==1){

                            //Absent
                            absentValue=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![l].absent!.toInt();


                            controller.childrenCustomModel.add(
                                ChildrenCustomModel(
                                    displayText: "${controller.patternData!.examMarkType!.items![i].children![k].name} (${controller.patternData!.examMarkType!.items![i].children![k].maxMark})",
                                    total: controller.patternData!.examMarkType!.items![i].children![k].total??-1,
                                    itemId: 1,
                                    childrenId: -1,
                                    absentValue: absentValue,
                                    type: 1,
                                    childrenFlag: 1,
                                    grade: "",
                                    maxMark: 100,
                                    textEditingController: TextEditingController(
                                        text: controller.customModelOverallExamList[index]
                                            .customOverExamResultList!.examResult![l].examMark.toString()),
                                    examMarkTypeItemId: 1,
                                    standardSubjectId: 2,
                                    subjectListId: 3,
                                    standardSubjectItemId: 4,
                                    examListId: 5,
                                    examMarkTypeId: 6,
                                    itemMark: 0,
                                    itemIndex: 0
                                ));



                          }else{
                            //Present
                            String grade = "";
                            absentValue=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![l].absent!.toInt();
                            int checkValue = 0;
                            if(controller.patternData!.examMarkType!.items![i].children![k].total==1&&controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![l].examMarkTypeIteId==controller.patternData!.examMarkType!.items![i].children![k].id
                                &&controller.subjectItemId==controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![l].standardSubjectItemId){

                              checkValue=1;
                              int val=controller.customModelOverallExamList[index]
                                  .customOverExamResultList!.examResult![l].examMark!.toInt();

                              if(controller.patternData!.examMarkType!.items![i].gradeSystem!=null){
                                for(int z=0;z<controller.patternData!.examMarkType!.items![i].gradeSystem!.items!.length;z++){

                                  if(val>=controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].minMark!.toInt()&&
                                      val<=controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].maxMark!.toInt()){

                                    grade = controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].grade.toString();
                                    print("grade Name : ${controller.patternData!.examMarkType!.items![i].gradeSystem!.name}");
                                    print("grade : $val - ${controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].grade}");
                                    break;
                                  }

                                }

                              }

                            }
                            if(checkValue==1){
                              controller.childrenCustomModel.add(
                                  ChildrenCustomModel(
                                      displayText: "${controller.patternData!.examMarkType!.items![i].children![k].name} (${controller.patternData!.examMarkType!.items![i].children![k].maxMark})",
                                      total: controller.patternData!.examMarkType!.items![i].children![k].total??-1,
                                      itemId: 1,
                                      childrenId: -1,
                                      absentValue: absentValue,
                                      type: 1,
                                      childrenFlag: 1,
                                      grade: grade,
                                      gradeDisplayType:controller.patternData!.examMarkType!.items![i].gradeDisplayType,
                                      maxMark: 100,
                                      textEditingController: TextEditingController(
                                          text: controller.customModelOverallExamList[index]
                                              .customOverExamResultList!.examResult![l].examMark.toString()),
                                      examMarkTypeItemId: 1,
                                      standardSubjectId: 2,
                                      subjectListId: 3,
                                      standardSubjectItemId: 4,
                                      examListId: 5,
                                      examMarkTypeId: 6,
                                      itemMark: 0,
                                      itemIndex: 0
                                  ));
                            }else{
                              controller.childrenCustomModel.add(
                                  ChildrenCustomModel(
                                      displayText: "${controller.patternData!.examMarkType!.items![i].children![k].name} (${controller.patternData!.examMarkType!.items![i].children![k].maxMark})",
                                      total: controller.patternData!.examMarkType!.items![i].children![k].total??-1,
                                      itemId: 1,
                                      childrenId: -1,
                                      absentValue: absentValue,
                                      type: 1,
                                      childrenFlag: 1,
                                      grade: grade,
                                      gradeDisplayType:controller.patternData!.examMarkType!.items![i].gradeDisplayType,
                                      maxMark: 100,
                                      textEditingController: TextEditingController(
                                          text: controller.customModelOverallExamList[index]
                                              .customOverExamResultList!.examResult![l].examMark.toString()),
                                      examMarkTypeItemId: 1,
                                      standardSubjectId: 2,
                                      subjectListId: 3,
                                      standardSubjectItemId: 4,
                                      examListId: 5,
                                      examMarkTypeId: 6,
                                      itemMark: 0,
                                      itemIndex: 0
                                  ));


                            }

                          }

                        }
                      }

                    }

                    controller.editedCustomModel.add(
                        EditedCustomModel(
                            displayText: "${controller.patternData
                                ?.examMarkType?.items?[i]
                                .name} (${controller
                                .patternData?.examMarkType
                                ?.items?[i].maxMark})",
                            total: controller.patternData!.examMarkType!.items![i].total??-1,
                            itemId: 1,
                            childrenId: 1,
                            childrenCustomModel: controller.childrenCustomModel,
                            absentValue: 0,//absentValue
                            type: 1,
                            childrenFlag: 0,
                            grade: "",
                            gradeDisplayType: controller.patternData!.examMarkType!.items![i].gradeDisplayType,
                            maxMark: 100,
                            textEditingController: TextEditingController(
                                text: "90"),
                            examMarkTypeItemId: 1,
                            standardSubjectId: 2,
                            subjectListId: 3,
                            standardSubjectItemId: 4,
                            examListId: 5,
                            examMarkTypeId: 6,
                            itemMark: 0,
                            itemIndex: 0
                        ));


                  }else{
                    // Not have Item Children

                    int checkTotal =0;
                    int absentValue = 0;
                    if(controller.editedCustomModel.isNotEmpty){

                      /*for(int j = 0; j <controller.customModelOverallExamList[index]
                          .customOverExamResultList!.examResult!.length; j++) {

                        if(controller.patternData!.examMarkType!.items![i].id==controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].examMarkTypeIteId&&controller.subjectItemId==controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].standardSubjectItemId){

                          checkTotal=1;

                          if(controller.customModelOverallExamList[index]
                              .customOverExamResultList!.examResult![j].absent==1){

                            absentValue=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].absent!.toInt();


                            controller.editedCustomModel.add(
                                EditedCustomModel(
                                    displayText: "${controller.patternData
                                        ?.examMarkType?.items?[i]
                                        .name} (${controller
                                        .patternData?.examMarkType
                                        ?.items?[i].maxMark})",
                                    total: controller.patternData!.examMarkType!.items![i].total??-1,
                                    itemId: 1,
                                    childrenId: controller.patternData!.examMarkType!.items![i].children!=null&&controller.patternData!.examMarkType!.items![i].children!.isNotEmpty?1:-1,
                                    absentValue: absentValue,
                                    type: 1,
                                    childrenFlag: 0,
                                    grade: "",
                                    resultValue: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMark,
                                    editedValue:0,
                                    editedFlag:0,
                                    maxMark: 100,
                                    textEditingController: TextEditingController(
                                        text: controller.customModelOverallExamList[index]
                                            .customOverExamResultList!.examResult![j].examMark.toString()),
                                    examMarkTypeItemId: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMarkTypeIteId,
                                    standardSubjectId: 2,
                                    subjectListId: 3,
                                    standardSubjectItemId: 4,
                                    examListId: 5,
                                    examMarkTypeId: 6,
                                    itemMark: 0,
                                    itemIndex: 0
                                ));


                          }else{

                            absentValue=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].absent!.toInt();

                            String grade = "";
                            int val=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].examMark!.toInt();
                            if(controller.patternData!.examMarkType!.items![i].gradeSystem!=null){
                              for(int z=0;z<controller.patternData!.examMarkType!.items![i].gradeSystem!.items!.length;z++){

                                if(val>=controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].minMark!.toInt()&&
                                    val<=controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].maxMark!.toInt()){

                                  grade = controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].grade.toString();
                                  break;
                                }

                              }
                            }

                            controller.editedCustomModel.add(
                                EditedCustomModel(
                                    displayText: "${controller.patternData
                                        ?.examMarkType?.items?[i]
                                        .name} (${controller
                                        .patternData?.examMarkType
                                        ?.items?[i].maxMark})",
                                    total: controller.patternData!.examMarkType!.items![i].total??-1,
                                    itemId: 1,
                                    childrenId: -1,
                                    absentValue: absentValue,
                                    gradeDisplayType: controller.patternData!.examMarkType!.items![i].gradeDisplayType,//
                                    type: 1,
                                    resultValue: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMark,
                                    editedValue:0,
                                    editedFlag:0,
                                    childrenFlag: 0,
                                    grade: grade,
                                    maxMark: 100,
                                    textEditingController: TextEditingController(
                                        text: controller.customModelOverallExamList[index]
                                            .customOverExamResultList!.examResult![j].examMark.toString()),
                                    examMarkTypeItemId: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMarkTypeIteId,
                                    standardSubjectId: 2,
                                    subjectListId: 3,
                                    standardSubjectItemId: 4,
                                    examListId: 5,
                                    examMarkTypeId: 6,
                                    itemMark: 0,
                                    itemIndex: 0
                                ));

                          }
                        }

                      }
*/
                    }else{

                      //Edited value
                      for(int j = 0; j <controller.customModelOverallExamList[index]
                          .customOverExamResultList!.examResult!.length; j++) {

                        if(controller.patternData!.examMarkType!.items![i].id==controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].examMarkTypeIteId&&controller.subjectItemId==controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].standardSubjectItemId){

                          checkTotal=1;

                          if(controller.customModelOverallExamList[index]
                              .customOverExamResultList!.examResult![j].absent==1){

                            absentValue=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].absent!.toInt();


                            controller.editedCustomModel.add(
                                EditedCustomModel(
                                    displayText: "${controller.patternData
                                        ?.examMarkType?.items?[i]
                                        .name} (${controller
                                        .patternData?.examMarkType
                                        ?.items?[i].maxMark})",
                                    total: controller.patternData!.examMarkType!.items![i].total??-1,
                                    itemId: 1,
                                    childrenId: controller.patternData!.examMarkType!.items![i].children!=null&&controller.patternData!.examMarkType!.items![i].children!.isNotEmpty?1:-1,
                                    absentValue: absentValue,
                                    type: 1,
                                    childrenFlag: 0,
                                    grade: "",
                                    resultValue: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMark,
                                    editedValue:0,
                                    editedFlag:0,
                                    maxMark: 100,
                                    textEditingController: TextEditingController(
                                        text: controller.customModelOverallExamList[index]
                                            .customOverExamResultList!.examResult![j].examMark.toString()),
                                    examMarkTypeItemId: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMarkTypeIteId,
                                    standardSubjectId: 2,
                                    subjectListId: 3,
                                    standardSubjectItemId: 4,
                                    examListId: 5,
                                    examMarkTypeId: 6,
                                    itemMark: 0,
                                    itemIndex: 0
                                ));


                          }else{

                            absentValue=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].absent!.toInt();

                            String grade = "";
                            int val=controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].examMark!.toInt();
                            if(controller.patternData!.examMarkType!.items![i].gradeSystem!=null){
                              for(int z=0;z<controller.patternData!.examMarkType!.items![i].gradeSystem!.items!.length;z++){

                                if(val>=controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].minMark!.toInt()&&
                                    val<=controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].maxMark!.toInt()){

                                  grade = controller.patternData!.examMarkType!.items![i].gradeSystem!.items![z].grade.toString();
                                  break;
                                }

                              }
                            }

                            controller.editedCustomModel.add(
                                EditedCustomModel(
                                    displayText: "${controller.patternData
                                        ?.examMarkType?.items?[i]
                                        .name} (${controller
                                        .patternData?.examMarkType
                                        ?.items?[i].maxMark})",
                                    total: controller.patternData!.examMarkType!.items![i].total??-1,
                                    itemId: 1,
                                    childrenId: -1,
                                    absentValue: absentValue,
                                    gradeDisplayType: controller.patternData!.examMarkType!.items![i].gradeDisplayType,//
                                    type: 1,
                                    resultValue: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMark,
                                    editedValue:0,
                                    editedFlag:0,
                                    childrenFlag: 0,
                                    grade: grade,
                                    maxMark: 100,
                                    textEditingController: TextEditingController(
                                        text: controller.customModelOverallExamList[index]
                                            .customOverExamResultList!.examResult![j].examMark.toString()),
                                    examMarkTypeItemId: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMarkTypeIteId,
                                    standardSubjectId: 2,
                                    subjectListId: 3,
                                    standardSubjectItemId: 4,
                                    examListId: 5,
                                    examMarkTypeId: 6,
                                    itemMark: 0,
                                    itemIndex: 0
                                ));

                          }
                        }

                      }


                    }

                    if(checkTotal!=1){
                    //  print("Check Mark ${jsonEncode(controller.patternData!.examMarkType!)}]");
                      controller.editedCustomModel.add(
                          EditedCustomModel(
                              displayText: "${controller.patternData
                                  ?.examMarkType?.items?[i]
                                  .name} (${controller
                                  .patternData?.examMarkType
                                  ?.items?[i].maxMark})",
                              total: controller.patternData!.examMarkType!.items![i].total??-1,
                              itemId: 1,
                              childrenId: -1,
                              absentValue: absentValue,
                              gradeDisplayType: controller.patternData!.examMarkType!.items![i].gradeDisplayType,//
                              type: 1,
                              childrenFlag: 0,
                              grade: "",
                              maxMark: 100,
                              textEditingController: TextEditingController(
                                  text: controller.patternData!.examMarkType!.items![i].total.toString()),
                              examMarkTypeItemId: 1,
                              standardSubjectId: 2,
                              subjectListId: 3,
                              standardSubjectItemId: 4,
                              examListId: 5,
                              examMarkTypeId: 6,
                              itemMark: 0,
                              itemIndex: 0
                          ));
                    }


                  }

                }

                if(controller.editedCustomModel.isNotEmpty){

                  print("editedCustomModel is not empty");
                  int editedCheck=0;
                  for(int z = 0; z <controller.editedCustomModel.length; z++) {

                    if(controller.customModelOverallExamList[index]
                        .customOverExamResultList!.examResult!=null&&controller.customModelOverallExamList[index]
                        .customOverExamResultList!.examResult!.isNotEmpty){

                      for(int j = 0; j<controller.customModelOverallExamList[index]
                          .customOverExamResultList!.examResult!.length; j++) {

                        if(controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].examMarkTypeIteId==
                            controller.editedCustomModel[z].examMarkTypeItemId){

                          if(controller.editedCustomModel[z].editedValue==1){
                            editedCheck=2;
                            print("editedCustomModel is edited - editedCheck $editedCheck");
                          }else{
                            editedCheck=1;
                            print("editedCustomModel is not edited - editedCheck $editedCheck");
                          }
                          break;

                        }

                      }

                    }



                    /*print("overAllItemID - ${controller.customModelOverallExamList[index]
                                .customOverExamResultList!.examResult![j].examMarkTypeIteId}");
                            print("editedItemID - ${controller.editedCustomModel[z].examMarkTypeItemId}");*/


                  }

                  // 1- not Edited | 2 - Edited
                  if(editedCheck==1){
                    // controller.editedCustomModel = [];
                  }else{

                  }

                }else{

                  print("editedCustomModel is empty");

                }



              }else{
                // dont't have Item

                int editedCheck=0;
                for(int z = 0; z <controller.editedCustomModel.length; z++) {

                  if(controller.editedCustomModel[z].editedFlag==1){
                    editedCheck = 1;
                    controller.editedCustomModel[z].textEditingController?.text = controller.editedCustomModel[z].editedValue.toString();
                  }else{
                    controller.editedCustomModel = [];
                  }

                }

                if(editedCheck!=1){
                  int absentValue = 0;
                  int checkValue=0;
                  for(int j = 0; j <controller.customModelOverallExamList[index]
                      .customOverExamResultList!.examResult!.length; j++) {

                    if(controller.patternData!.examMarkType!.id==controller.customModelOverallExamList[index]
                        .customOverExamResultList!.examResult![j].examMarkTypeId){
                      checkValue=1;
                      if(controller.customModelOverallExamList[index]
                          .customOverExamResultList!.examResult![j].absent==1){

                        absentValue=controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].absent!.toInt();
                        controller.editedCustomModel.add(
                            EditedCustomModel(
                                displayText: "${controller.patternData
                                    ?.examMarkType?.name}",
                                total: 0,
                                itemId: 1,
                                childrenId: -1,
                                absentValue: absentValue,
                                type: 1,
                                childrenFlag: 0,
                                grade: "",
                                resultValue: controller.customModelOverallExamList[index]
                                    .customOverExamResultList!.examResult![j].examMark,
                                editedValue:0,
                                editedFlag:0,
                                gradeDisplayType: controller.patternData!.examMarkType!.gradeDisplayType,
                                maxMark: 100,
                                textEditingController: TextEditingController(
                                    text: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMark.toString()),
                                examMarkTypeItemId: 1,
                                standardSubjectId: 2,
                                subjectListId: 3,
                                standardSubjectItemId: 4,
                                examListId: 5,
                                examMarkTypeId: 6,
                                itemMark: 0,
                                itemIndex: 0
                            ));

                      }else{
                        //Present
                        absentValue=controller.customModelOverallExamList[index]
                            .customOverExamResultList!.examResult![j].absent!.toInt();
                        controller.editedCustomModel.add(
                            EditedCustomModel(
                                displayText: "${controller.patternData
                                    ?.examMarkType?.name}",
                                total: 0,
                                itemId: 1,
                                childrenId: -1,
                                absentValue: absentValue,
                                type: 1,
                                childrenFlag: 0,
                                grade: "",
                                resultValue: controller.customModelOverallExamList[index]
                                    .customOverExamResultList!.examResult![j].examMark,
                                editedValue:0,
                                editedFlag:0,
                                maxMark: 100,
                                gradeDisplayType: controller.patternData!.examMarkType!.gradeDisplayType,
                                textEditingController: TextEditingController(
                                    text: controller.customModelOverallExamList[index]
                                        .customOverExamResultList!.examResult![j].examMark.toString()),
                                examMarkTypeItemId: 1,
                                standardSubjectId: 2,
                                subjectListId: 3,
                                standardSubjectItemId: 4,
                                examListId: 5,
                                examMarkTypeId: 6,
                                itemMark: 0,
                                itemIndex: 0
                            ));


                      }

                    }

                  }

                  if(checkValue<1){
                    controller.editedCustomModel.add(
                        EditedCustomModel(
                            displayText: "${controller.patternData
                                ?.examMarkType?.name}",
                            total: 0,
                            itemId: 1,
                            childrenId: -1,
                            absentValue: absentValue,
                            type: 1,
                            childrenFlag: 0,
                            grade: "",
                            maxMark: 100,
                            gradeDisplayType: controller.patternData!.examMarkType!.gradeDisplayType,
                            textEditingController: TextEditingController(
                                text: "92"),
                            examMarkTypeItemId: 1,
                            standardSubjectId: 2,
                            subjectListId: 3,
                            standardSubjectItemId: 4,
                            examListId: 5,
                            examMarkTypeId: 6,
                            itemMark: 0,
                            itemIndex: 0
                        ));
                  }
                }
              }

              showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20)
                      )
                  ),
                  builder: (context) {
                    return _addResultBottomSheet1(controller, index);
                  });



              /*showModalBottomSheet(
                  context: Get.context!,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) =>
                      _addResultBottomSheet(controller, index));*/
            },
            child: Card(
              elevation: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    controller.customModelOverallExamList[index]
                        .customOverExamResultList?.fullName ?? "",
                    style: AppStyles.NunitoExtrabold.copyWith(
                        color: AppColors.blackColor, fontSize: 13),
                  ).paddingOnly(top: 10, bottom: 10),
                  _displayTextWidget(controller, index)
                ],
              ).paddingOnly(left: 20, right: 10),
            ),
          );
        }).paddingAll(2);
  }

  //bolt - OVERALL LIST MARK DISPLAY
  Widget _displayTextWidget(StaffExamResultController controller, int index) {
   // String displayMark = "";//OVERALL MARK
    overallDisplayMark = "";
    bool checkboxValue = false;

    if (controller.patternData!.examMarkType!.items!.isNotEmpty) {
      for(int i = 0; i <controller.patternData!.examMarkType!.items!.length; i++) {
        if (controller.customModelOverallExamList[index]
            .customOverExamResultList!.examResult!.isNotEmpty) {
          for(int j = 0; j <controller.customModelOverallExamList[index]
              .customOverExamResultList!.examResult!.length; j++) {

            if (checkItemId(controller, i, index, j)) {
              if (checkConditions(controller, index, j)) {



              }
            }


          }

        }
      }
    }else{
      //100 Mark or Single Mark (No items of Mark List)
      print("pattern empty");
      for(int j = 0; j <controller.customModelOverallExamList[index]
          .customOverExamResultList!.examResult!.length; j++) {

        if(controller.patternData!.examMarkType!.id==controller.customModelOverallExamList[index]
            .customOverExamResultList!.examResult![j].examMarkTypeId){

          if(controller.customModelOverallExamList[index]
              .customOverExamResultList!.examResult![j].absent==1){

            //Absent
            overallDisplayMark = "Absent marked";
            checkboxValue = true;
          }else{
            //Present
            overallDisplayMark = controller.customModelOverallExamList[index]
                .customOverExamResultList!.examResult![j].examMark.toString();
          }


        }

      }

    }



/*
    if (controller.customModelOverallExamList[index].edit != 1) {
      if (controller.patternData!.examMarkType!.items!.isNotEmpty) {
        for (int t = 0; t <
            controller.patternData!.examMarkType!.items!.length; t++) {
          //Pattern

          for (int j = 0; j < controller.customModelOverallExamList[index]
              .customOverExamResultList!.examResult!.length; j++) {
            //Exam Result

            if (checkItemId(controller, t, index, j)) {
              if (checkConditions(controller, index, j)) {
                if (controller.patternData!.examMarkType!.items![t]
                    .gradeDisplayType == 2 ||
                    controller.patternData!.examMarkType!.items![t]
                        .gradeDisplayType == 1) {
                  for (int grade = 0; grade <
                      controller.patternData!.examMarkType!.items![t]
                          .gradeSystem!.items!.length; grade++) {
                    int exammark = controller.customModelOverallExamList[index]
                        .customOverExamResultList?.examResult![j].examMark ?? 0;

                    if (controller.patternData!.examMarkType!.items![t]
                        .gradeSystem!.items![grade].minMark!.toInt() <=
                        exammark && exammark <=
                        controller.patternData!.examMarkType!.items![t]
                            .gradeSystem!.items![grade].maxMark!.toInt()) {
                      if (controller.patternData!.examMarkType!.items![t]
                          .gradeDisplayType == 2) {
                        displayMark +=
                        "${controller.patternData?.examMarkType?.items?[t]
                            .name ?? ""}=${controller
                            .customModelOverallExamList[index]
                            .customOverExamResultList?.examResult![j].absent ==
                            1 ? "Absent" : controller
                            .customModelOverallExamList[index]
                            .customOverExamResultList?.examResult?[j]
                            .examMark} ${controller.patternData!.examMarkType!
                            .items![t].gradeSystem!.items![grade]
                            .grade} ${controller.patternData?.examMarkType
                            ?.items?[t].total == 1 ? "" : ","} ";
                      } else {
                        displayMark +=
                        "${controller.patternData?.examMarkType?.items?[t]
                            .name ?? ""}= ${controller.patternData!
                            .examMarkType!.items![t].gradeSystem!.items![grade]
                            .grade} ${controller.patternData?.examMarkType
                            ?.items?[t].total == 1 ? "" : ","} ";
                      }
                    }
                  }
                } else {
                  displayMark +=
                  "${controller.patternData?.examMarkType?.items?[t].name ??
                      ""}=${controller.customModelOverallExamList[index]
                      .customOverExamResultList?.examResult![j]
                      .absent == 1 ? "Absent" : controller
                      .customModelOverallExamList[index]
                      .customOverExamResultList?.examResult?[j]
                      .examMark} ${controller.patternData?.examMarkType
                      ?.items?[t]
                      .total == 1 ? "" : ","} ";
                }
              }
            }
          }
        }
      }
    } else {
      if (controller.patternData!.examMarkType!.items!.isNotEmpty) {
        for (int t = 0; t <
            controller.patternData!.examMarkType!.items!.length; t++) {
          //Pattern

          for (int j = 0; j < controller.editedCustomModel.length; j++) {
            //edited custom model
            if (controller.patternData!.examMarkType!.items![t].id ==
                controller.editedCustomModel[j].examMarkTypeItemId) {
              if (((controller.patternStandardSubjectId ==
                  controller.editedCustomModel[j].standardSubjectId) &&
                  (controller.patternSubjectListId ==
                      controller.editedCustomModel[j].subjectListId) &&
                  (controller.standardSubjectItemId ==
                      controller.editedCustomModel[j].standardSubjectItemId) &&
                  (controller.patternExamListId ==
                      controller.editedCustomModel[j].examListId) &&
                  (controller.patternExamMarkTypeId ==
                      controller.editedCustomModel[j].examMarkTypeId))) {
                if (controller.patternData!.examMarkType!.items![t]
                    .gradeDisplayType == 2 ||
                    controller.patternData!.examMarkType!.items![t]
                        .gradeDisplayType == 1) {
                  for (int grade = 0; grade <
                      controller.patternData!.examMarkType!.items![t]
                          .gradeSystem!.items!.length; grade++) {
                    int editedExamMark = controller.editedCustomModel[j]
                        .itemMark ?? 0;
                    if (controller.patternData!.examMarkType!.items![t]
                        .gradeSystem!.items![grade].minMark!.toInt() <=
                        editedExamMark && editedExamMark <=
                        controller.patternData!.examMarkType!.items![t]
                            .gradeSystem!.items![grade].maxMark!.toInt()) {
                      if (controller.patternData!.examMarkType!.items![t]
                          .gradeDisplayType == 2) {
                        displayMark +=
                        "${controller.patternData?.examMarkType?.items?[t]
                            .name ?? ""}=${controller.editedCustomModel[j]
                            .absentValue == 1 ? "Absent" : controller
                            .editedCustomModel[j].itemMark } ${controller
                            .patternData!.examMarkType!.items![t].gradeSystem!
                            .items![grade].grade} ${controller.patternData
                            ?.examMarkType?.items?[t].total == 1 ? "" : ","} ";
                      } else {
                        displayMark +=
                        "${controller.patternData?.examMarkType?.items?[t]
                            .name ?? ""}= ${controller.patternData!
                            .examMarkType!.items![t].gradeSystem!.items![grade]
                            .grade} ${controller.patternData?.examMarkType
                            ?.items?[t].total == 1 ? "" : ","} ";
                      }
                    }
                  }
                } else {
                  displayMark +=
                  "${controller.patternData?.examMarkType?.items?[t].name ??
                      ""}=${controller.editedCustomModel[j].absentValue == 1
                      ? "Absent"
                      : controller.editedCustomModel[j].itemMark } ${controller
                      .patternData?.examMarkType?.items?[t].total == 1
                      ? ""
                      : ","} ";
                }
              }
            }
          }
        }
      }
    }*/


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(overallDisplayMark.toString()),
        Checkbox(
            value: checkboxValue
                ? true
                : false,
            activeColor: AppColors.darkPinkColor,
            onChanged: (newValue) {})
      ],
    );
  }


  bool checkChildrensId(StaffExamResultController controller, int t, int v,
      int index, int j) {
    return controller.patternData!.examMarkType!.items![t].children![v].id ==
        controller.customModelOverallExamList[index].customOverExamResultList
            ?.examResult![j].examMarkTypeIteId;
  }

  bool checkItemId(StaffExamResultController controller, int t, int index,
      int j) {
    return controller.patternData!.examMarkType!.items![t].id ==
        controller.customModelOverallExamList[index].customOverExamResultList
            ?.examResult![j].examMarkTypeIteId;
  }

  bool checkConditions(StaffExamResultController controller, int index, int j) {
    return ((controller.patternStandardSubjectId ==
        controller.customModelOverallExamList[index].customOverExamResultList
            ?.examResult?[j]
            .standardSubjectId) &&
        (controller.patternSubjectListId ==
            controller.customModelOverallExamList[index]
                .customOverExamResultList?.examResult?[j].subjectListId) &&
        (controller.standardSubjectItemId ==
            controller.customModelOverallExamList[index]
                .customOverExamResultList?.examResult?[j]
                .standardSubjectItemId) &&
        (controller.patternExamListId ==
            controller.customModelOverallExamList[index]
                .customOverExamResultList?.examResult?[j].examListId) &&
        (controller.patternExamMarkTypeId ==
            controller.customModelOverallExamList[index]
                .customOverExamResultList?.examResult?[j].examMarkTypeId));
  }

  Widget _addResultBottomSheet1(StaffExamResultController staffExamResultController, int selectIndex) {
    //print("editText : ${staffExamResultController.editedCustomModel[0].textEditingController?.text}");
    int? editIndex=-1;
    return GetBuilder<StaffExamResultController>(
        init: StaffExamResultController(),
        builder: (controllers) {
          return DraggableScrollableSheet(
            initialChildSize: 0.9,
            builder: (_, controller) =>
                Container(
                  color: Colors.white,
                  child: Stack(
                    children: [
                      ListView(
                        controller: controller,
                        children: [
                          /*Student Name*/
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                //Student Name
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Student name",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 14)),
                                    Text("${controllers
                                        .customModelOverallExamList[selectIndex]
                                        .customOverExamResultList?.fullName}",
                                        style: AppStyles.NunitoExtrabold.copyWith(
                                            fontSize: 16)),
                                  ],
                                ),
                                //Close button
                                InkWell(onTap: () {
                                  Get.back();
                                },
                                    child: const Icon(
                                      Icons.clear, color: Colors.black,))
                              ],
                            ),
                          ),
                          /*Max Mark*/
                          Container(
                            color: const Color(0xFFffc107),
                            height: 50,
                            child: Center(
                              child: Text(
                                  "${controllers.patternData
                                      ?.subject?.commonName ??
                                      ""} ${controllers
                                      .patternData?.examMarkType?.name ?? ""}",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 15,
                                      color: const Color(0xFF55514f))),
                            ),
                          ),
                          controllers.editedCustomModel.isNotEmpty?
                          ListView.builder(
                              itemCount: controllers.editedCustomModel.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {

                               // print("edit list size : ${controllers.editedCustomModel.length}");
                               /* editIndex = index;
                                if(controllers.editedCustomModel[index].editedFlag==1){
                                  controllers.editedCustomModel[index].textEditingController?.text = controllers.editedCustomModel[index].editedValue.toString();
                                }*/
                                return Column(
                                  children: [
                                    Column(
                                      children: [
                                        /*Mark Type*/
                                        Container(
                                          color: const Color(0xFF1eadbe),
                                          height: 50,
                                          child: Center(
                                            child: Text(
                                                controllers.editedCustomModel[index].displayText,
                                                style: AppStyles.NunitoExtrabold.copyWith(
                                                    fontSize: 15, color: Colors.white)),
                                          ),
                                        ),
                                        controllers.editedCustomModel[index].total != 1 ?
                                        controllers.editedCustomModel[index].childrenCustomModel!=null&&controllers.editedCustomModel[index].childrenCustomModel!.isNotEmpty?Container():
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFF2395f0),
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(controllers.editedCustomModel[index].displayText,
                                                          style: AppStyles.NunitoExtrabold
                                                              .copyWith(
                                                              fontSize: 15,
                                                              color: Colors.white)),
                                                    ),
                                                  ),
                                                ),
                                                controllers.editedCustomModel[index].childrenCustomModel!=null&&controllers.editedCustomModel[index].childrenCustomModel!.isNotEmpty?
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==0||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                        child: Text(controllers.editedCustomModel[index].textEditingController!.text.toString(),
                                                            style: AppStyles.NunitoExtrabold
                                                                .copyWith(
                                                                fontSize: 15,
                                                                color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ):
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==0||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                          child: Padding(
                                                            padding: const EdgeInsets.symmetric(
                                                                horizontal: 20),
                                                            child: TextFormField(
                                                             // initialValue: "10",//
                                                              onChanged: (val) {
                                                                if(val.isNotEmpty){
                                                                  if(int.parse(val.toString())>controllers.editedCustomModel[index].maxMark){
                                                                    controllers.editedCustomModel[index].textEditingController?.text = "";
                                                                    controllers.update();
                                                                  }else
                                                                    print("Value Edited");
                                                                    controllers.editedCustomModel[index].editedFlag = 1;
                                                                    controllers.editedCustomModel[index].editedValue = int.parse(val.toString());
                                                                    controllers.editedCustomModel[index].resultValue = int.parse(val.toString());
                                                                    controllers.editedCustomModel[index].textEditingController?.text = val.toString();
                                                                  }
                                                                },

                                                              controller:controllers.editedCustomModel[index].textEditingController,
                                                              decoration: const InputDecoration(
                                                                hintText: "Marks",
                                                              ),
                                                              textAlign: TextAlign.center,
                                                              keyboardType: TextInputType.text,
                                                              style: const TextStyle(
                                                                fontSize: 16,
                                                              ),
                                                            ),
                                                          )
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==1||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                        child: Text(controllers.editedCustomModel[index].grade.toString(),
                                                            style: AppStyles.NunitoExtrabold
                                                                .copyWith(
                                                                fontSize: 15,
                                                                color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Center(
                                                      child: Checkbox(
                                                        value: controllers.editedCustomModel[index].absentValue==1?true:false,
                                                        onChanged: (bool? value) {

                                                          print("ongoing - selected checkbox : $value");
                                                          controllers.checkboxUpdate(value!,index);


                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ) :
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Center(
                                                      child: Text("Total value",
                                                          style: AppStyles.NunitoExtrabold
                                                              .copyWith(
                                                              fontSize: 15,
                                                              color: Colors.black)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==0||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                        child: Text(controllers.editedCustomModel[index].textEditingController!.text,
                                                            style: AppStyles.NunitoExtrabold
                                                                .copyWith(
                                                                fontSize: 15,
                                                                color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==1||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                        child: Text("${controllers.editedCustomModel[index].grade}",
                                                            style: AppStyles.NunitoExtrabold
                                                                .copyWith(
                                                                fontSize: 15,
                                                                color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Checkbox(
                                                      value: controllers.editedCustomModel[index].absentValue==1?true:false,
                                                      onChanged: (bool? value) {},
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5,),
                                      ],
                                    ),
                                    controllers.editedCustomModel[index].childrenCustomModel!=null&&controllers.editedCustomModel[index].childrenCustomModel!.isNotEmpty?
                                    ListView.builder(
                                        itemCount: controllers.editedCustomModel[index].childrenCustomModel!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context,index1){
                                      return Column(
                                        children: [
                                          Container(
                                            color: Colors.orange,
                                            height: 40,
                                            width: MediaQuery.of(context).size.width,
                                            child: controllers.editedCustomModel[index].childrenCustomModel![index1].total != 1 ?
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFF2395f0),
                                                    height: 50,
                                                    child: Center(
                                                      child: Text(controllers.editedCustomModel[index].childrenCustomModel![index1].displayText??"",
                                                          style: AppStyles.NunitoExtrabold
                                                              .copyWith(
                                                              fontSize: 15,
                                                              color: Colors.white)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Center(
                                                        child: Padding(
                                                          padding: const EdgeInsets.symmetric(
                                                              horizontal: 20),
                                                          child: TextFormField(
                                                            // initialValue: "10",//
                                                            onChanged: (val) {
                                                              controllers.editedCustomModel[index].childrenCustomModel![index1].textEditingController!.text = val;

                                                            },
                                                            controller:controllers.editedCustomModel[index].childrenCustomModel![index1].textEditingController,
                                                            decoration: const InputDecoration(
                                                              hintText: "Marks",
                                                            ),
                                                            textAlign: TextAlign.center,
                                                            keyboardType: TextInputType.number,
                                                            style: const TextStyle(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Center(
                                                      child: Text("${controllers.editedCustomModel[index].childrenCustomModel![index1].grade}",
                                                          style: AppStyles.NunitoExtrabold
                                                              .copyWith(
                                                              fontSize: 15,
                                                              color: Colors.black)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:false,
                                                      child: Center(
                                                        child: Checkbox(
                                                          value: controllers.editedCustomModel[index].childrenCustomModel![index1].absentValue==1?true:false,
                                                          onChanged: (bool? value) {

                                                            print("ongoing - selected checkbox : $value");
                                                            controllers.checkboxUpdate(value!,index);


                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ): Row(
                                              children: [
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Center(
                                                      child: Text("Total values",
                                                          style: AppStyles.NunitoExtrabold
                                                              .copyWith(
                                                              fontSize: 15,
                                                              color: Colors.black)),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==0||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                        child: Text(controllers.editedCustomModel[index].childrenCustomModel![index1].textEditingController!.text,
                                                            style: AppStyles.NunitoExtrabold
                                                                .copyWith(
                                                                fontSize: 15,
                                                                color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Visibility(
                                                      visible:controllers.editedCustomModel[index].gradeDisplayType==1||
                                                          controllers.editedCustomModel[index].gradeDisplayType==2?true:false,
                                                      child: Center(
                                                        child: Text("${controllers.editedCustomModel[index].childrenCustomModel![index1].grade}",
                                                            style: AppStyles.NunitoExtrabold
                                                                .copyWith(
                                                                fontSize: 15,
                                                                color: Colors.black)),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    color: const Color(0xFFabd9fc),
                                                    height: 50,
                                                    child: Checkbox(
                                                      value: controllers.editedCustomModel[index].childrenCustomModel![index1].absentValue==1?true:false,
                                                      onChanged: (bool? value) {},
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(height: 5,),
                                        ],
                                      );

                                       /* Container(
                                        color: Colors.orange,
                                        height: 10,
                                        width: MediaQuery.of(context).size.width,
                                        child: Text(controllers.editedCustomModel[index].childrenCustomModel![index1].displayText??"",style: const TextStyle(color: Colors.black),),
                                      );*/
                                    }):Container()
                                  ],
                                );
                              }):Column(
                            children: [
                              Container()
                            ],
                          )

                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: InkWell(
                          onTap: (){

                            // if(editIndex!=null&&editIndex!=-1){
                            //   print("Result value : ${controllers.editedCustomModel[editIndex!].resultValue}");
                            //   print("Result edited value : ${controllers.editedCustomModel[editIndex!].editedValue}");
                            //
                            //   if(controllers.editedCustomModel[editIndex!].resultValue!=controllers.editedCustomModel[editIndex!].editedValue){
                            //     //edited done
                            //     print("Edit done");
                            //   }else{
                            //     //Edited not done
                            //     print("Edit not done");
                            //   }
                            //
                            // }

                            Get.back();
                          },
                          child: Container(
                            color: const Color(0xFF48d7a4),
                            height: 50,
                            child: Center(
                              child: Text("ADD RESULT",
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      fontSize: 15, color: Colors.white)),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
          );
        });

  }


  void _dynamicallyChangeGrade(StaffExamResultController controller,
      int childrens, int total, String childrenGrade) {
    if (controller.patternData!.examMarkType!.items!.isNotEmpty) {
      for (int t = 0; t <
          controller.patternData!.examMarkType!.items!.length; t++) {
        if (controller.editedCustomModel[childrens].itemId ==
            controller.patternData!.examMarkType!.items![t].id) {
          if (controller.patternData!.examMarkType!.items![t]
              .gradeDisplayType == 2) {
            for (int grade = 0; grade <
                controller.patternData!.examMarkType!.items![t].gradeSystem!
                    .items!.length; grade++) {
              if (controller.patternData!.examMarkType!.items![t].gradeSystem!
                  .items![grade].minMark!.toInt() <= total && total <=
                  controller.patternData!.examMarkType!.items![t].gradeSystem!
                      .items![grade].maxMark!.toInt()) {
                childrenGrade =
                "${controller.patternData!.examMarkType!.items![t].gradeSystem!
                    .items![grade].grade}";
              }
            }
          } else {
            childrenGrade = "";
          }
          controller.editedCustomModel[childrens].grade = childrenGrade;
        }
      }
    }
  }


  Widget _buildFullMarksWidget(StaffExamResultController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text("Enter Mark ( 100)",
                style: AppStyles.NunitoExtrabold.copyWith(fontSize: 13)),
            SizedBox(
              width: Get.width * 0.25,
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                onChanged: (value) async {},
                decoration: const InputDecoration(
                    hintStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    contentPadding: EdgeInsets.only(top: 0.0, bottom: 0.0),
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ).paddingOnly(bottom: 0, left: 20, top: 0),
            ),
          ],
        ),
        Row(
          children: [
            const Text("Absent"),
            Checkbox(
                value: false,
                activeColor: AppColors.darkPinkColor,
                onChanged: (newValue) {}),
          ],
        ),
      ],
    ).paddingOnly(left: 10, right: 10);
  }


  Widget _standardAndExamWidget(StaffExamResultController controller) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _standardWidget(controller),
          verticalDIviderWidget(),
          _examWidget(controller),
        ],
      ).paddingAll(8),
    );
  }

  Widget _examAreaSubjectRowWidget(StaffExamResultController controller) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _examAreaWidget(controller),
          verticalDIviderWidget(),
          _subjectWidget(controller),
        ],
      ).paddingAll(8),
    );
  }

  Widget _standardSubjectWidget(StaffExamResultController controller) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _standardAndExamWidget(controller),
          _examAreaSubjectRowWidget(controller),
          Visibility(
            visible: controller.standardSubjectListSelectedIndex != 0
                ? true
                : (controller.studentsListSelectedIndex == 0 ||
                controller.standardExamAreaSelectedIndex == 0 ||
                controller.standardExamListSelectedIndex == 0)
                ? false
                : false,
            child: SMSButtonWidget(
              onPress: () async {
                controller.editedCustomModel = [];
                overallDisplayMark = "";
                controller.updateLoadingStatus();
                await controller.fetchPattern();
                Map<String, dynamic> mapData = {
                  "standard_id":
                  "${controller.filterStudentsStandardListData[controller
                      .studentsListSelectedIndex].section![controller
                      .studentsListSectionIndex].standardId}",
                  "group_section_id":
                  "${controller.filterStudentsStandardListData[controller
                      .studentsListSelectedIndex].section?[controller
                      .studentsListSectionIndex].id}",
                  "group_id": "",
                  "exam_list_id": controller
                      .filteredExamList[
                  controller.standardExamListSelectedIndex]
                      .examListId,
                  "exam_area_id": controller
                      .filteredExamAreaList[
                  controller.standardExamAreaSelectedIndex]
                      .id,
                  "language_type": controller
                      .filteredSubjectList[
                  controller.standardSubjectListSelectedIndex]
                      .subject
                      ?.languageType ??
                      0,
                  "group": []
                };
                await controller.fetchOverallExamResultData(mapData);
              },
              text: "SEARCH",
              width: Get.width * 0.1,
              height: 30,
              borderRadius: 5,
              fontSize: 12,
              primaryColor: AppColors.darkPinkColor,
            ).paddingAll(8),
          ),
        ],
      ),
    );
  }

  Widget _standardWidget(StaffExamResultController controller) {
    return Expanded(
      flex: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" Standard ",
              style: AppStyles.NunitoLight.copyWith(fontSize: 14))
              .paddingOnly(bottom: 10, top: 10),
          InkWell(
            onTap: () async {
              /*    controller.filterStudentsStandardListData = [
                StudentStandardListData(
                    fullName: "-- Select Std --",
                    section: [Section(fullName: "")])
              ];
              await controller.fetchTeacherStandardListData();*/
              showModalBottomSheet(
                  context: Get.context!,
                  builder: (context) =>
                      _standardSectionBottomSheet(controller));
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    controller.filterStudentsStandardListData.isNotEmpty
                        ? controller.studentsListSelectedIndex == 0
                        ? "-- Select Std --"
                        : "${controller
                        .filterStudentsStandardListData[controller
                        .studentsListSelectedIndex].fullName} - ${controller
                        .filterStudentsStandardListData[controller
                        .studentsListSelectedIndex].section?[controller
                        .studentsListSectionIndex].fullName ?? ""}"
                        : "",
                    style: AppStyles.NunitoExtrabold.copyWith(fontSize: 12)),
                const Icon(
                  Icons.arrow_drop_down,
                  color: AppColors.greyColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _examWidget(StaffExamResultController controller) {
    return Expanded(
      flex: 1,
      child: Visibility(
        visible: controller.subjectExamListData !=
            null /*controller.studentsListSelectedIndex != 0*/ ? true : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Exam ", style: AppStyles.NunitoLight.copyWith(fontSize: 14))
                .paddingOnly(bottom: 10, top: 10),
            InkWell(
              onTap: () async {
                /*   controller.filteredExamList = [
                  ExamList(code: "-> Exam <-", name: "")
                ];*/
                showModalBottomSheet(
                    context: Get.context!,
                    builder: (context) =>
                        _standardExamListBottomSheet(controller));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                        controller.filteredExamList.isNotEmpty
                            ? controller.standardExamListSelectedIndex == 0
                            ? "-> Exam <-"
                            : "${controller.filteredExamList[controller
                            .standardExamListSelectedIndex].code} - ${controller
                            .filteredExamList[controller
                            .standardExamListSelectedIndex].name ?? ""}"
                            : "",
                        style:
                        AppStyles.NunitoExtrabold.copyWith(fontSize: 12)),
                  ),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _examAreaWidget(StaffExamResultController controller) {
    return Expanded(
      flex: 1,
      child: Visibility(
        visible: controller.standardExamListSelectedIndex != 0
            ? true
            : (controller.studentsListSelectedIndex == 0)
            ? false
            : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Exam Area ",
                style: AppStyles.NunitoLight.copyWith(fontSize: 14))
                .paddingOnly(bottom: 10, top: 10),
            InkWell(
              onTap: () async {
                showModalBottomSheet(
                    context: Get.context!,
                    builder: (context) =>
                        _standardExamAreaListBottomSheet(controller));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      controller.filteredExamAreaList.isNotEmpty
                          ? controller.standardExamAreaSelectedIndex == 0
                          ? "-> Exam Area <-"
                          : controller
                          .filteredExamAreaList[controller
                          .standardExamAreaSelectedIndex]
                          .name ??
                          ""
                          : "",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 12)),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _subjectWidget(StaffExamResultController controller) {
    return Expanded(
      flex: 1,
      child: Visibility(
        visible: controller.standardExamAreaSelectedIndex != 0
            ? true
            : (controller.studentsListSelectedIndex == 0 ||
            controller.standardExamListSelectedIndex == 0)
            ? false
            : false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(" Subject ",
                style: AppStyles.NunitoLight.copyWith(fontSize: 14))
                .paddingOnly(bottom: 10, top: 10),
            InkWell(
              onTap: () async {
                showModalBottomSheet(
                    context: Get.context!,
                    builder: (context) =>
                        _standardSubjectListBottomSheet(controller));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      controller.filteredSubjectList.isNotEmpty
                          ? controller.standardSubjectListSelectedIndex == 0
                          ? "Select Subject"
                          : controller
                          .filteredSubjectList[controller
                          .standardSubjectListSelectedIndex]
                          .subject
                          ?.name ??
                          ""
                          : "",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 12)),
                  const Icon(
                    Icons.arrow_drop_down,
                    color: AppColors.greyColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _standardSectionBottomSheet(StaffExamResultController controller) {
    return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 1,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select Item",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 16)),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 24,
                      color: AppColors.redColor,
                    ).paddingOnly(right: 20),
                  ),
                ],
              ).paddingOnly(left: 20, top: 20),
              TextFormField(
                onChanged: (value) async {
                  if (value.length > 3) {
                    controller.filterStandardStudentsResults(value);
                  }
                  if (value.isEmpty) {
                    controller.filterStudentsStandardListData = [
                      StudentStandardListData(
                          fullName: "-- Select Std --",
                          section: [Section(fullName: "")])
                    ];
                    await controller.fetchTeacherStandardListData();
                  }
                },
                decoration: InputDecoration(
                    prefix: const Icon(
                      Icons.search_rounded,
                      color: AppColors.greyColor,
                    ).paddingOnly(right: 20, left: 20),
                    contentPadding: const EdgeInsets.all(0),
                    hintStyle: const TextStyle(color: Colors.grey),
                    hintText: "Search",
                    focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    enabledBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
              ),
              controller.filterStudentsStandardListData.isNotEmpty
                  ? Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount:
                    controller.filterStudentsStandardListData.length,
                    // shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller
                              .filterStudentsStandardListData[index]
                              .section
                              ?.length ??
                              0,
                          shrinkWrap: true,
                          itemBuilder: (context, index1) {
                            return InkWell(
                              onTap: () async {
                                controller.updateStudentListValue(
                                    index, index1);
                                if (index == 0) {
                                  controller
                                      .standardExamListSelectedIndex = 0;
                                  controller
                                      .standardExamAreaSelectedIndex = 0;
                                  controller
                                      .standardSubjectListSelectedIndex = 0;
                                  controller.update();
                                }
                                print("Dropdown : sectionId - ${controller.filterStudentsStandardListData[index].section![index1].id}");
                                print("Dropdown : standardId - ${controller.filterStudentsStandardListData[index].section![index1].standardId}");
                                Get.back();
                                await controller
                                    .fetchStandardSubjectAssessmentExamListData(
                                    url:
                                    "${ApiHelper
                                        .subjectAssessmentExamListUrl}standard_id=${controller
                                        .filterStudentsStandardListData[controller
                                        .studentsListSelectedIndex]
                                        .section![controller
                                        .studentsListSectionIndex]
                                        .standardId}&group_section_id=${controller
                                        .filterStudentsStandardListData[controller
                                        .studentsListSelectedIndex]
                                        .section![controller
                                        .studentsListSectionIndex]
                                        .id}&exam_list=1&exam_area=1&subject_list=1");
                              },
                              child: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.start,
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  index == 0
                                      ? const Text("-- Select Std --")
                                      .paddingAll(15)
                                      : Text("${controller
                                      .filterStudentsStandardListData[index]
                                      .fullName} - ${controller
                                      .filterStudentsStandardListData[index]
                                      .section?[index1].fullName ?? ""}")
                                      .paddingSymmetric(
                                      horizontal: 25,
                                      vertical: 18),
                                  dividerWidget()
                                ],
                              ),
                            );
                          });
                    }),
              )
                  : Container()
            ],
          );
        });
  }

  Widget _standardExamListBottomSheet(StaffExamResultController controller) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Item",
                    style: AppStyles.NunitoExtrabold.copyWith(fontSize: 16)),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.redColor,
                  ).paddingOnly(right: 20),
                ),
              ],
            ).paddingOnly(left: 20, top: 20),
            TextFormField(
              onChanged: (value) async {
                if (value.length > 3) {
                  controller.filterStandardExamListResults(value);
                }
                if (value.isEmpty) {
                  controller.filteredExamList = [
                    ExamList(code: "-> Exam <-", name: "")
                  ];
                  await controller.fetchStandardSubjectAssessmentExamListData(
                      url:
                      "${ApiHelper
                          .subjectAssessmentExamListUrl}standard_id=${controller
                          .filterStudentsStandardListData[controller
                          .studentsListSelectedIndex].section![controller
                          .studentsListSectionIndex]
                          .standardId}&group_section_id=${controller
                          .filterStudentsStandardListData[controller
                          .studentsListSelectedIndex].section![controller
                          .studentsListSectionIndex].id}&exam_list=1");
                }
              },
              decoration: InputDecoration(
                  prefix: const Icon(
                    Icons.search_rounded,
                    color: AppColors.greyColor,
                  ).paddingOnly(right: 20, left: 20),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Search",
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            controller.filteredExamList.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: controller.filteredExamList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.updateSelectedExamList(index);
                        if (index == 0) {
                          controller.standardExamAreaSelectedIndex = 0;
                          controller.standardSubjectListSelectedIndex = 0;
                          controller.update();
                        }
                        print("Dropdown : examListId - ${controller.filteredExamList[index].examListId}");
                        print("Dropdown : examMarkTypeId - ${controller.filteredExamList[index].examMarkTypeId}");
                        print("Dropdown : standardExamListId - ${controller.filteredExamList[index].standardExamListId}");
                        Get.back();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? const Text("-> Exam <-").paddingAll(15)
                              : Text("${controller.filteredExamList[index]
                              .code} - ${controller.filteredExamList[index]
                              .name ?? ""}")
                              .paddingSymmetric(
                              horizontal: 25, vertical: 18),
                          dividerWidget()
                        ],
                      ),
                    );
                  }),
            )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _standardExamAreaListBottomSheet(
      StaffExamResultController controller) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Item",
                    style: AppStyles.NunitoExtrabold.copyWith(fontSize: 16)),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.redColor,
                  ).paddingOnly(right: 20),
                ),
              ],
            ).paddingOnly(left: 20, top: 20),
            TextFormField(
              onChanged: (value) async {
                if (value.length > 3) {
                  controller.filterStandardExamAreaResults(value);
                }
                if (value.isEmpty) {
                  controller.filteredExamAreaList = [
                    ExamArea(name: "-> Exam Area <-")
                  ];
                  await controller.fetchStandardSubjectAssessmentExamListData(
                      url:
                      "${ApiHelper
                          .subjectAssessmentExamListUrl}standard_id=${controller
                          .filterStudentsStandardListData[controller
                          .studentsListSelectedIndex].section![controller
                          .studentsListSectionIndex]
                          .standardId}&group_section_id=${controller
                          .filterStudentsStandardListData[controller
                          .studentsListSelectedIndex].section![controller
                          .studentsListSectionIndex]
                          .id}&exam_list=1&exam_area=1");
                }
              },
              decoration: InputDecoration(
                  prefix: const Icon(
                    Icons.search_rounded,
                    color: AppColors.greyColor,
                  ).paddingOnly(right: 20, left: 20),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Search",
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            controller.filteredExamAreaList.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: controller.filteredExamAreaList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.updateSelectedExamArea(index);
                        if (index == 0) {
                          controller.standardSubjectListSelectedIndex = 0;
                          controller.update();
                        }
                        print("Dropdown : ExamArea : ${controller.filteredExamAreaList[index].id}");
                        Get.back();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? const Text("-> Exam Area <-")
                              .paddingAll(15)
                              : Text(controller
                              .filteredExamAreaList[index]
                              .name ??
                              "")
                              .paddingSymmetric(
                              horizontal: 25, vertical: 18),
                          dividerWidget()
                        ],
                      ),
                    );
                  }),
            )
                : Container()
          ],
        ),
      ),
    );
  }

  Widget _standardSubjectListBottomSheet(StaffExamResultController controller) {
    return SingleChildScrollView(
      child: SizedBox(
        height: Get.height * 0.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Select Item",
                    style: AppStyles.NunitoExtrabold.copyWith(fontSize: 16)),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    color: AppColors.redColor,
                  ).paddingOnly(right: 20),
                ),
              ],
            ).paddingOnly(left: 20, top: 20),
            TextFormField(
              onChanged: (value) async {
                if (value.length > 3) {
                  controller.filterStandardExamAreaResults(value);
                }
                if (value.isEmpty) {
                  controller.filteredSubjectList = [
                    SubjectList(subject: Subject(name: "Select Subject"))
                  ];
                  await controller.fetchStandardSubjectAssessmentExamListData(
                      url:
                      "${ApiHelper
                          .subjectAssessmentExamListUrl}standard_id=${controller
                          .filterStudentsStandardListData[controller
                          .studentsListSelectedIndex].section![controller
                          .studentsListSectionIndex]
                          .standardId}&group_section_id=${controller
                          .filterStudentsStandardListData[controller
                          .studentsListSelectedIndex].section![controller
                          .studentsListSectionIndex]
                          .id}&exam_list=1&exam_area=1&subject_list=1");
                }
              },
              decoration: InputDecoration(
                  prefix: const Icon(
                    Icons.search_rounded,
                    color: AppColors.greyColor,
                  ).paddingOnly(right: 20, left: 20),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: "Search",
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey))),
            ),
            controller.filteredSubjectList.isNotEmpty
                ? Expanded(
              child: ListView.builder(
                  itemCount: controller.filteredSubjectList.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        controller.updateSelectedSubjectList(
                            index,
                            controller.filteredSubjectList[index]
                                .standardSubjectId ??
                                0,
                            controller.filteredSubjectList[index].id ??
                                0);
                        print("Dropdown : standardSubjectId : ${controller.filteredSubjectList[index].standardSubjectId}");
                        controller.subjectItemId = controller.filteredSubjectList[index].id;
                        print("Dropdown : subjectItemId : ${controller.filteredSubjectList[index].id}");
                        Get.back();
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          index == 0
                              ? const Text("Select Subject")
                              .paddingAll(15)
                              : Text(controller.filteredSubjectList[index]
                              .subject?.name ??
                              "")
                              .paddingSymmetric(
                              horizontal: 25, vertical: 18),
                          dividerWidget()
                        ],
                      ),
                    );
                  }),
            )
                : Container()
          ],
        ),
      ),
    );
  }
}
