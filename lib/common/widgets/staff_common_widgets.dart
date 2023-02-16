import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../enums/staff_enum_navigation.dart';
import '../routes/app_routes.dart';

void updateStaffStatus(StaffStatus state) {
  switch (state) {
    case StaffStatus.HOMEWORK:
      {
        Get.toNamed(AppRoutes.STAFFVIEWHOMEWORK);
      }
      break;
    case StaffStatus.CLASSTEST:
      {
        Get.toNamed(AppRoutes.STAFFVIEWCLASSTEST);
      }
      break;
    case StaffStatus.CLASSTIMETABLE:
      {
        Get.toNamed(AppRoutes.STAFFCLASSTIMETABLE);
      }
      break;
    case StaffStatus.CIRCULAR:
      {
        Get.toNamed(AppRoutes.STAFFCIRCULAR, arguments: {"tag": "Circular"});
      }
      break;
    case StaffStatus.EVENT:
      {
        Get.toNamed(AppRoutes.STAFFEVENT, arguments: {"tag": "Event"});
      }
      break;
    case StaffStatus.NEWS:
      {
        Get.toNamed(AppRoutes.STAFFNEWS, arguments: {"tag": "News"});
      }
      break;
    case StaffStatus.SMS:
      {
        Get.toNamed(AppRoutes.STAFFSMS, arguments: {"tag": "SMS"});
      }
      break;
    case StaffStatus.VOICE:
      {
        Get.toNamed(AppRoutes.STAFFVOICE, arguments: {"tag": "Voice"});
      }
      break;
    case StaffStatus.ATTENDANCE:
      {
        Get.toNamed(AppRoutes.STAFFATTENDANCEDETAILS);
      }
      break;
    case StaffStatus.LEAVELIST:
      {
        Get.toNamed(AppRoutes.STAFFLEAVELIST);
      }
      break;
    case StaffStatus.SALARYLIST:
      {
        Get.toNamed(AppRoutes.STAFFSALARYLIST);
      }
      break;
    case StaffStatus.EPFESIMANAGE:
      {
        Get.toNamed(AppRoutes.STAFFEPFESIMANAGE);
      }
      break;
    case StaffStatus.ADAVANCESALARY:
      {
        Get.toNamed(AppRoutes.STAFFADVANCESALARY);
      }
      break;
    case StaffStatus.LOANDETAILS:
      {
        Get.toNamed(
          AppRoutes.STAFFLOANDETAILS,
        );
      }
      break;
    case StaffStatus.EXAMRESULT:
      {
        Get.toNamed(AppRoutes.STAFFEXAMRESULT);
      }
      break;
    case StaffStatus.EXAMTIMETABLE:
      {
        Get.toNamed(AppRoutes.STAFFEXAMTIMETABLE);
      }
      break;
    case StaffStatus.CLASSTEACHEREXAMRESULT:
      {
        Get.toNamed(AppRoutes.STAFFCLASSTEACHEREXAMRESULT);
      }
      break;
    case StaffStatus.STUDENTLISTDETAILS:
      {
        Get.toNamed(AppRoutes.STAFFSTUDENTLISTDETAILS);
      }
      break;

    case StaffStatus.STUDENTATTENDANCE:
      {
        Get.toNamed(AppRoutes.STAFFSTUDENTATTENDANE);
      }
      break;
    case StaffStatus.STUDENTLEAVEREQUEST:
      {
        Get.toNamed(AppRoutes.STAFFSTUDENTLEAVEREQUEST);
      }
      break;
    /* case StaffStatus.MULTICHOOSESUBJECTSTUDENTS:
      {
        Get.toNamed(AppRoutes.STAFFMULTICHOOSESUBJECTSTUDENTS);
      }
      break;*/
    case StaffStatus.SCHOOLCALENDER:
      {
        Get.toNamed(AppRoutes.STAFFSCHOOLCALENDER);
      }
      break;
    default:
      {}
      break;
  }
}

// Future<void> showStaffToastMsg(String message) async {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_SHORT,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 1,
//       backgroundColor: Colors.black54,
//       textColor: Colors.white,
//       fontSize: 12.0);
// }

Widget verticalDIviderWidget() {
  return const VerticalDivider(
    color: Colors.grey,
    thickness: 1,
  ).paddingOnly(top: 10, bottom: 5);
}

Widget dividerWidget() {
  return Divider(
    thickness: 1,
    height: 1,
    color: Colors.grey[300],
  );
}
