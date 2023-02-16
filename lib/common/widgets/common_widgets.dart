import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/screens/daily_actvities/homework/homework_submission_screen.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../common/const/image_constants.dart';
import '../../parent/controllers/daily_activity_controller/home_work_controller/homework_controller.dart';
import '../../parent/model/home_work_model.dart';
import '../../parent/themes/app_styles.dart';
import '../../storage.dart';
import '../common_controller/base_controller.dart';
import '../enums/enum_navigation.dart';
import '../routes/app_routes.dart';

class SMSImageAsset extends StatelessWidget {
  final String image;
  final BoxFit? boxfit;
  final double? height;
  final double? width;

  const SMSImageAsset(
      {Key? key, required this.image, this.boxfit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      image,
      fit: boxfit,
      height: height,
      width: width,
    );
  }
}

class SMSInputText extends StatelessWidget {
  const SMSInputText(
      {Key? key,
      required this.onChanged,
      required this.hintText,
      this.validator,
      this.obscureText = false,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      required this.lableText,
      this.textInputAction,
      required this.controller,
      this.textCapitalization,
      required this.lablestyle,
      this.maxLength,
      this.focusNode})
      : super(key: key);

  final Function(String?) onChanged;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String lableText;
  final TextInputAction? textInputAction;
  final TextEditingController controller;
  final TextCapitalization? textCapitalization;
  final TextStyle lablestyle;
  final FocusNode? focusNode;
  final int? maxLength;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        counterText: "",
        // contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
        // hintText: hintText,
        filled: true,
        labelText: lableText,
        labelStyle: lablestyle,
        errorStyle: const TextStyle(height: 0, color: AppColors.redColor),
        // hintStyle: const TextStyle(
        //   fontSize: 16,
        //   color: Color(0xFF969A9D),
        //   fontWeight: FontWeight.w300,
        // ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.greyColor, width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.greyColor, width: 1.5)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
            borderSide:
                const BorderSide(color: AppColors.darkPinkColor, width: 2.5)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.redColor, width: 1.5),
        ),
      ),
      style: const TextStyle(
        fontSize: 16,
        color: Color(0xFF3C3C43),
      ),
    );
  }
}

class SMSButtonWidget extends StatelessWidget {
  final String text;
  final Color? primaryColor;
  final Color? onPrimaryColor;
  final Function() onPress;
  final double width;
  final double height;
  final double borderRadius;
  final double? fontSize;

  const SMSButtonWidget(
      {Key? key,
      required this.onPress,
      required this.text,
      this.onPrimaryColor,
      this.primaryColor,
      required this.width,
      required this.height,
      required this.borderRadius,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: onPrimaryColor ?? AppColors.whiteColor,
        minimumSize: Size(width, height),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      child: Text(text,
          style: AppStyles.arimBold.copyWith(
              fontSize: fontSize, color: Colors.white, letterSpacing: 1)),
    );
  }
}

class ButtonWithLinearGradiantWidget extends StatelessWidget {
  final String text;
  final Function() onPress;
  final double width;
  final double? fontSize;
  final double height;

  const ButtonWithLinearGradiantWidget(
      {Key? key,
      required this.onPress,
      required this.height,
      required this.text,
      required this.width,
      this.fontSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.zero,
      margin: EdgeInsets.zero,
      width: Get.width,
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          AppColors.indigo1Color,
          AppColors.indigo2Color,
          //add more colors
        ]),
      ),
      child: ElevatedButton(
        onPressed: onPress,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
        ),
        child: Text(text,
            style: AppStyles.arimBold
                .copyWith(fontSize: 15, color: Colors.white, letterSpacing: 1)),
      ),
    );
  }
}

PreferredSizeWidget smsAppbar(String text) {
  return AppBar(
      title:
          Text(text, style: AppStyles.PoppinsBold.copyWith(fontSize: 18,fontWeight: FontWeight.w500)),
      leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.3),
              ),
              child: Center(
                child: SMSImageAsset(image: 'assets/campuseasy/back_arrow.png',width: 15,height: 15,),
              ),
            ),
          )),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: <Color>[
            Color(0XFF407BFF),
            Color(0XFF8FC4FF),
            ],
        )),
      ));
}

Widget buildText(String text) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Text(
      text,
      style:
          AppStyles.normal.copyWith(fontSize: 14, color: AppColors.blackColor),
    ),
  );
}

void updateStatusOfTheRoute(Status state) {
  switch (state) {
    case Status.HOMEWORK:
      {
        Get.toNamed(AppRoutes.HOMEWORK, arguments: const {"tag": "Homework"});
      }
      break;
    case Status.CLASSTEST:
      {
        Get.toNamed(AppRoutes.CLASSTEST, arguments: const {"tag": "ClassTest"});
      }
      break;
    case Status.ATTENDANCEDETAILS:
      {
        Get.toNamed(AppRoutes.ATTENDANCEDETAILS);
      }
      break;
    case Status.CLASSTIMETABLE:
      {
        Get.toNamed(AppRoutes.CLASSTIEMTABLE);
      }
      break;
    case Status.CIRCULAR:
      {
        Get.toNamed(AppRoutes.CIRCULAR, arguments: {"tag": "Circular"});
      }
      break;
    case Status.EVENT:
      {
        Get.toNamed(AppRoutes.EVENT, arguments: {"tag": "Event"});
      }
      break;
    case Status.NEWS:
      {
        Get.toNamed(AppRoutes.NEWS, arguments: {"tag": "News"});
      }
      break;
    case Status.SMS:
      {
        Get.toNamed(AppRoutes.SMSView, arguments: {"tag": "SMS"});
      }
      break;
    case Status.VOICE:
      {
        Get.toNamed(AppRoutes.VOICE, arguments: {"tag": "Voice"});
      }
      break;
    case Status.STAFFDETAILS:
      {
        Get.toNamed(AppRoutes.STAFFDETAILS);
      }
      break;
/*    case Status.VEHICLETRACKING:
      {
        Get.toNamed(AppRoutes.VEHICLETRACKING);
      }
      break;*/
    case Status.FEEPAYMENT:
      {
        Get.toNamed(AppRoutes.FEEPAYMENT);
      }
      break;
    case Status.FEEINVOICE:
      {
        Get.toNamed(AppRoutes.FEEINVOICE);
      }
      break;
    case Status.FEEPENDING:
      {
        Get.toNamed(AppRoutes.FEEPENDING);
      }
      break;
    case Status.EXAMRESULT:
      {
        Get.toNamed(AppRoutes.EXAMRESULT, arguments: {"name": "Exam Result"});
      }
      break;
    case Status.EXAMTIMETABLE:
      {
        Get.toNamed(AppRoutes.EXAMTIMETABLE,
            arguments: {"name": "Exam TimeTable"});
      }
      break;
    case Status.LIVECLASSES:
      {
        Get.toNamed(AppRoutes.LIVECLASSES);
      }
      break;
    case Status.STUDYLAB:
      {
        Get.toNamed(AppRoutes.STUDYLABS);
      }
      break;
    case Status.BARROWLIST:
      {
        Get.toNamed(AppRoutes.BAROWLIST);
      }
      break;
    case Status.RENEWLIST:
      {
        Get.toNamed(AppRoutes.RENEWLIST);
      }
      break;

    case Status.FINELIST:
      {
        Get.toNamed(AppRoutes.FINELIST);
      }
      break;
    case Status.FINEINVOICE:
      {
        Get.toNamed(AppRoutes.FINEINVOICELIST);
      }
      break;
    case Status.MATERIALBILL:
      {
        Get.toNamed(AppRoutes.MATERIALBILL);
      }
      break;
    /* case Status.MATERIALBILLISSUED:
      {
        Get.toNamed(AppRoutes.MATERIALBILL);
      }
      break;*/
    case Status.EXTRACURRICULAR:
      {
        Get.toNamed(AppRoutes.EXTRACURRICULAR);
      }
      break;
    case Status.REFRESHMENT:
      {
        Get.toNamed(AppRoutes.REFRESHMENT);
      }
      break;
    case Status.SCHOOLCALENDER:
      {
        Get.toNamed(AppRoutes.SCHOOLCALENDER);
      }
      break;
    default:
      {}
      break;
  }
}

class SMSTextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final Function()? onTap;

  SMSTextFieldWidget({required this.controller, this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          fillColor: Colors.white,
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 1.0),
              borderRadius: BorderRadius.circular(10)),
        ),
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }
}

TextStyle arimoBoldTextStyle(
        {required double fontSize,
        required Color color,
        double? letterSpacing}) =>
    AppStyles.arimBold.copyWith(
        fontSize: fontSize, color: color, letterSpacing: letterSpacing ?? 0);

TextStyle arimoRegularTextStyle(
        {required double fontSize, required Color color}) =>
    AppStyles.arimoRegular.copyWith(fontSize: fontSize, color: color);

TextStyle nunitoRegularTextStyle(
        {required double fontSize, required Color color}) =>
    AppStyles.NunitoRegular.copyWith(fontSize: fontSize, color: color);

TextStyle nunitoExtraBoldTextStyle(
        {required double fontSize, required Color color}) =>
    AppStyles.NunitoExtrabold.copyWith(fontSize: fontSize, color: color);

Center circularProgressIndicator() =>
    const Center(child: CircularProgressIndicator.adaptive());

void showBottomModelSheet(BuildContext ctx, HomeworkController controller) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Padding(
            padding: const EdgeInsets.symmetric(vertical:20,horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Attachment",
                      style: AppStyles.PoppinsBold.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0XFF252525),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        //Gallery
                        Get.back();
                        controller.filePicker();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0XFFEEF3FF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Gallery",
                                style: AppStyles.PoppinsRegular.copyWith(
                                  fontSize: 14,
                                  color: Color(0XFF252525),
                                ),
                              ),
                              Icon(Icons.image,color: Color(0XFF252525),)
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    InkWell(
                      onTap: (){
                        //Camera
                        Get.back();
                        controller.captureImage();
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0XFFEEF3FF),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Camera",
                                style: AppStyles.PoppinsRegular.copyWith(
                                  fontSize: 14,
                                  color: Color(0XFF252525),
                                ),
                              ),
                              Icon(Icons.camera,color: Color(0XFF252525),)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

               /* Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "Attachment",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ).paddingOnly(bottom: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                            controller.filePicker();
                          },
                          child: Column(
                            children: [
                              Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.red,
                                        style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    alignment: Alignment.center,
                                    ImageConstants.galleryImg,
                                    color: AppColors.whiteColor,
                                  ).paddingOnly(top: 15, bottom: 15)),
                              Text("Gallery",
                                      style: AppStyles.arimoRegular.copyWith(
                                          fontSize: 14,
                                          color: AppColors.blackColor))
                                  .paddingOnly(top: 10)
                            ],
                          ).paddingAll(8),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                            controller.captureImage();
                          },
                          child: Column(
                            children: [
                              Container(
                                  width: 50.0,
                                  height: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.purple,
                                    border: Border.all(
                                        width: 1,
                                        color: Colors.purple,
                                        style: BorderStyle.solid),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.asset(
                                    ImageConstants.cameraImg,
                                    height: 20,
                                    width: 20,
                                    color: AppColors.whiteColor,
                                  ).paddingOnly(top: 15, bottom: 15)),
                              Text("Camera",
                                      style: AppStyles.arimoRegular.copyWith(
                                          fontSize: 14,
                                          color: AppColors.blackColor))
                                  .paddingOnly(top: 10)
                            ],
                          ).paddingAll(8),
                        ),
                      ],
                    ).paddingOnly(left: 5),
                  ],
                ),*/
              ],
            ),
          ));
}

void showImageViewerBottomModelSheet(
    BuildContext ctx, BaseController controller, String file,int delete,{Subject? subjectList,int? index,HomeworkController? homeworkController}) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Choose",
                  style: AppStyles.PoppinsBold.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0XFF252525),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    //View Image

                    Get.back();
                    showDialog(
                        context: Get.context!,
                        builder: (ctx) {
                          return AlertDialog(
                            contentPadding: const EdgeInsets.all(5),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [Image.network(file)]),
                          );
                        });
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: Color(0XFFEEF3FF),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("View Image",
                            style: AppStyles.PoppinsRegular.copyWith(
                              fontSize: 14,
                              color: Color(0XFF252525),
                            ),
                          ),
                          Icon(Icons.visibility,color: Color(0XFF252525),)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: (){
                    //Download
                    Get.back();
                    controller.downloadFileWidget(file);
                    snackbar_widget(Get.context!);
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0XFFEEF3FF),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Download",
                            style: AppStyles.PoppinsRegular.copyWith(
                              fontSize: 14,
                              color: Color(0XFF252525),
                            ),
                          ),
                          Icon(Icons.file_download,color: Color(0XFF252525),)
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                delete!=0?
                InkWell(
                  onTap: ()async{
                    //Download
                    Map<String, dynamic> mapData = {
                      "student_id": LocalStorage.getValue("studentId"),
                      "homework_id": subjectList?.id,
                      "stu_homework_file_id":
                      "${subjectList?.homeworkReply?.studentReply?.stuHomeworkFile![index!].id ?? 0}",
                      "homework_student_reply_id": subjectList?.homeworkReply?.id ?? 0
                    };
                    await homeworkController?.deleteReplyImage(mapData);
                    homeworkController?.removeIteFromList(subjectList!, index!);
                  },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Color(0XFFEEF3FF),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Delete",
                            style: AppStyles.PoppinsRegular.copyWith(
                              fontSize: 14,
                              color: Color(0XFF252525),
                            ),
                          ),
                          Icon(Icons.delete,color: Color(0XFF252525),)
                        ],
                      ),
                    ),
                  ),
                ):Container(),
               /* Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                        showDialog(
                            context: Get.context!,
                            builder: (ctx) {
                              return AlertDialog(
                                contentPadding: const EdgeInsets.all(5),
                                content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [Image.network(file)]),
                              );
                            });
                      },
                      child: Column(
                        children: [
                          Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                    width: 1,
                                    color: Colors.red,
                                    style: BorderStyle.solid),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                alignment: Alignment.center,
                                ImageConstants.galleryImg,
                                color: AppColors.whiteColor,
                              ).paddingOnly(top: 15, bottom: 15)),
                          Text("View",
                                  style: AppStyles.arimoRegular.copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackColor))
                              .paddingOnly(top: 10)
                        ],
                      ).paddingAll(8),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Get.back();
                        controller.downloadFileWidget(file);
                        snackbar_widget(Get.context!);
                      },
                      child: Column(
                        children: [
                          Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                border: Border.all(
                                    width: 1,
                                    color: Colors.purple,
                                    style: BorderStyle.solid),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                ImageConstants.downloadImage,
                                height: 20,
                                width: 20,
                                color: AppColors.whiteColor,
                              ).paddingOnly(top: 15, bottom: 15)),
                          Text("Download",
                                  style: AppStyles.arimoRegular.copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackColor))
                              .paddingOnly(top: 10)
                        ],
                      ).paddingAll(8),
                    ),
                  ],
                ).paddingOnly(left: 5),*/
              ],
            ),
          ));
}

void showAnyFileDownloaderBottomModelSheet(
    BuildContext ctx, BaseController controller, String file) {
  showModalBottomSheet(
      elevation: 10,
      backgroundColor: Colors.white,
      context: ctx,
      builder: (ctx) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                        controller.downloadFileWidget(file);
                        snackbar_widget(Get.context!);
                      },
                      child: Column(
                        children: [
                          Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Colors.purple,
                                border: Border.all(
                                    width: 1,
                                    color: Colors.purple,
                                    style: BorderStyle.solid),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                ImageConstants.downloadImage,
                                height: 20,
                                width: 20,
                                color: AppColors.whiteColor,
                              ).paddingOnly(top: 15, bottom: 15)),
                          Text("Download",
                                  style: AppStyles.arimoRegular.copyWith(
                                      fontSize: 14,
                                      color: AppColors.blackColor))
                              .paddingOnly(top: 10)
                        ],
                      ).paddingAll(8),
                    ),
                  ],
                ).paddingOnly(left: 5),
              ],
            ),
          ));
}

void snackbar_widget(BuildContext context) {
  final snackBar = SnackBar(
    content: const Text('File Downloading...'),
    backgroundColor: (Colors.grey[500]),
    action: SnackBarAction(
      label: 'dismiss',
      onPressed: () {},
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

