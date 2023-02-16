import 'package:get/get.dart';

import '../../parent/controllers/attendance_controller/attendance_details_binding.dart';
import '../../parent/controllers/daily_activity_controller/class_test_controller1/classtest_binding1.dart';
import '../../parent/controllers/daily_activity_controller/class_time_table_controller/class_timetable_binding.dart';
import '../../parent/controllers/daily_activity_controller/news_circular_event_controller/news_circular_event_binding.dart';
import '../../parent/controllers/home_controller/home_binding.dart';
import '../../parent/controllers/inventory_controller/material_bill_binding.dart';
import '../../parent/controllers/library_controller/barrow_binding.dart';
import '../../parent/controllers/library_controller/fine_invoice_binding.dart';
import '../../parent/controllers/library_controller/fine_list_binding.dart';
import '../../parent/controllers/library_controller/renew_binding.dart';
import '../../parent/controllers/profile_controller/profile_binding.dart';
import '../../parent/view/screens/Home/home_screen.dart';
import '../../parent/view/screens/daily_actvities/attendance/attendance_calender.dart';
import '../../parent/view/screens/daily_actvities/attendance/attendance_details_screen.dart';
import '../../parent/view/screens/daily_actvities/attendance/leave_status_screen.dart';
import '../../parent/view/screens/daily_actvities/circular/circular_screen.dart';
import '../../parent/view/screens/daily_actvities/class_time_table/class_time_table_screen.dart';
import '../../parent/view/screens/daily_actvities/classtest1/classtest_screen1.dart';
import '../../parent/view/screens/daily_actvities/event/event_screen.dart';
import '../../parent/view/screens/daily_actvities/homework/homework_screen.dart';
import '../../parent/view/screens/daily_actvities/news/news_screen.dart';
import '../../parent/view/screens/daily_actvities/sms/sms_screen.dart';
import '../../parent/view/screens/daily_actvities/staff/staff_details_screen.dart';
import '../../parent/view/screens/daily_actvities/voice/voice_screen.dart';
import '../../parent/view/screens/exam_manager/exam_result_and_timetable_screen.dart';
import '../../parent/view/screens/extra_activities/extra_curricular_screen.dart';
import '../../parent/view/screens/extra_activities/refreshment_screen.dart';
import '../../parent/view/screens/inventory/material_bill_screen.dart';
import '../../parent/view/screens/library/barrow_list_screen.dart';
import '../../parent/view/screens/library/fine_invoice_screen.dart';
import '../../parent/view/screens/library/fine_list_screen.dart';
import '../../parent/view/screens/library/renew_list_screen.dart';
import '../../parent/view/screens/online_classes/live_classes_screen.dart';
import '../../parent/view/screens/online_classes/study_labs_screen.dart';
import '../../parent/view/screens/payment_and_invoice/fee_invoice_screen.dart';
import '../../parent/view/screens/payment_and_invoice/fee_payment_screen.dart';
import '../../parent/view/screens/payment_and_invoice/fee_pending.dart';
import '../../parent/view/screens/profile/profile_main.dart';
import '../../parent/view/screens/school_calender/school_calender_screen.dart';
import '../../splash_screen.dart';
import '../../staff/controller/payroll_controller/advance_salarylist_controller/AdvanceSalaryListBinding.dart';
import '../../staff/controller/payroll_controller/leave_list_controller/leave_list_binding.dart';
import '../../staff/controller/payroll_controller/loan_controller/LoanBinding.dart';
import '../../staff/controller/payroll_controller/salary_list_controller/SalaryListBinding.dart';
import '../../staff/controller/staff_calender_controller/staff_calender_binding.dart';
import '../../staff/controller/staff_exam_manager_controller/staff_exam_result_binding.dart';
import '../../staff/controller/staff_home_controller/home_binding.dart';
import '../../staff/controller/staff_profile_contrller/staff_profile_binding.dart';
import '../../staff/controller/students_controller/students_binding.dart';
import '../../staff/view/screens/payroll/epf_esi_manage/epf_esi_manage_screen.dart';
import '../../staff/view/screens/payroll/loan_details/staff_loan_details.dart';
import '../../staff/view/screens/payroll/staff_advance_salary/staff_advance_salary.dart';
import '../../staff/view/screens/payroll/staff_attendance/staff_attendance_details_screen.dart';
import '../../staff/view/screens/payroll/staff_leave_list/staff_leave_list.dart';
import '../../staff/view/screens/payroll/staff_salary_list/staff_salary_list_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_circular/staff_circular_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_class_time_table/staff_class_timetable.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_class_time_table/staff_class_timetable_view.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_CT_add_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_add_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_class_teacher_view_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_report_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_result_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_view_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_event/staff_event_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_add_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_class_teacher_view_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_staff_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_reply_staff_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_report_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_subject_add_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_view_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_news/staff_news_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_sms/staff_sms_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_voice/staff_voice_screen.dart';
import '../../staff/view/screens/staff_exam_manager/class_teacher_exam_result/class_teacher_exam_result.dart';
import '../../staff/view/screens/staff_exam_manager/staff_exam_result/staff_exam_result_screen.dart';
import '../../staff/view/screens/staff_exam_manager/staff_exam_time_table/staff_exam_time_table_screen.dart';
import '../../staff/view/screens/staff_home/staff_home_screen.dart';
import '../../staff/view/screens/staff_profile/staff_profile_screen.dart';
import '../../staff/view/screens/staff_school_calender/staff_school_calender_screen.dart';
import '../../staff/view/screens/students/student_list_details/student_list_details_screen.dart';
import '../../staff/view/screens/students/students_attendance/student_attendance_screen.dart';
import '../../staff/view/screens/students/students_leave_request/students_leave_request_screen.dart';
import '../common_controller/login_binding.dart';
import '../view/screen/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<GetPage> routes = [
    GetPage(
        name: AppRoutes.SPLASHVIEW,
        page: () => const SplashScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.LOGINVIEW,
        page: () => LoginScreen(),
        bindings: [LoginBinding()]),
    GetPage(
        name: AppRoutes.HOMESCREEN,
        page: () => HomeScreen(),
        bindings: [HomeBinding(), NewsCircularEventBinding()]),
    GetPage(
        name: AppRoutes.CLASSTIEMTABLE,
        page: () => const ClassTimeTableScreen(),
        bindings: [ClassTimeTableBinding()]),
    GetPage(
        name: AppRoutes.FEEPAYMENT,
        page: () => FeePaymentScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.FEEINVOICE,
        page: () => const FeeInvoiceScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.FEEPENDING,
        page: () => FeePendingScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFDETAILS,
        page: () => StaffDetailsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.EXAMRESULT,
        page: () => const ExamResultScreen(tag: "Exam Result"),
        bindings: [],
        arguments: const {"name": "Exam Result"}),
    GetPage(
        name: AppRoutes.EXAMTIMETABLE,
        page: () => const ExamResultScreen(tag: "Exam TimeTable"),
        bindings: [],
        arguments: const {"name": "Exam TimeTable"}),
    GetPage(
        name: AppRoutes.SMSView,
        page: () => SMSScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "SMS"}),
    GetPage(
        name: AppRoutes.NEWS,
        page: () => const NewsScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "News"}),
    GetPage(
        name: AppRoutes.CIRCULAR,
        page: () => const CircularScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "Circular"}),
    GetPage(
        name: AppRoutes.EVENT,
        page: () => const EventScreen(),
        bindings: [NewsCircularEventBinding()],
        arguments: const {"tag": "Event"}),
    GetPage(
        name: AppRoutes.HOMEWORK,
        page: () => const HomeWorkScreen(),
        bindings: [HomeBinding()],
        arguments: const {"tag": "Homework"}),
    GetPage(
        name: AppRoutes.CLASSTEST,
        page: () => const ClassTestScreen1(),//const ClassTestScreen()
        bindings: [ClassTestBinding1()],
        arguments: const {"tag": "ClassTest"}),//ClassTest
    GetPage(
        name: AppRoutes.ATTENDANCEDETAILS,
        page: () => AttendanceDetailsScreen(),
        bindings: [AttendanceDetailsBinding()]),
    GetPage(
        name: AppRoutes.VOICE,
        page: () => const VoiceScreen(),
        bindings: [],
        arguments: const {"tag": "Voice"}),
 /*   GetPage(
        name: AppRoutes.VEHICLETRACKING,
        page: () => const VehicleTRackingScreen(),
        bindings: []),*/
    GetPage(
        name: AppRoutes.LIVECLASSES,
        page: () => const LiveClassesScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STUDYLABS,
        page: () => const StudyLabsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.BAROWLIST,
        page: () => const BarrowListScreen(),
        bindings: [BarrowBinding()]),
    GetPage(
        name: AppRoutes.FINELIST,
        page: () => FineListScreen(),
        bindings: [FineListBinding()]),
    GetPage(
        name: AppRoutes.RENEWLIST,
        page: () => const RenewListScreen(),
        bindings: [RenewBinding()]),
    GetPage(
        name: AppRoutes.FINEINVOICELIST,
        page: () => FineInvoiceScreen(),
        bindings: [FineInvoiceBinding()]),
    GetPage(
        name: AppRoutes.MATERIALBILL,
        page: () => const MaterialBillScreen(),
        bindings: [MaterialBillBinding()]),
    GetPage(
        name: AppRoutes.EXTRACURRICULAR,
        page: () => const ExtraCurricularScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.REFRESHMENT,
        page: () => const RefreshmentScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.SCHOOLCALENDER,
        page: () => const SchoolCalenderScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.PROFILE,
        page: () => Profile(),
        bindings: [ProfileBinding()]),
    GetPage(
        name: AppRoutes.LEAVESTATUS,
        page: () => const LeaveStatusScreen(),
        bindings: [AttendanceDetailsBinding()]),
    GetPage(
        name: AppRoutes.ATTENDANCECALENDER,
        page: () => const AttendanceCalender(),
        bindings: [AttendanceDetailsBinding()]),

    /* GetPage(
        name: AppRoutes.STAFFHOEWORK,
        page: () => const StaffHomeworkScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTEST,
        page: () => const StaffClassTestScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTIETABLE,
        page: () => const StaffClassTimeTableScreen(),
        bindings: []),*/
    GetPage(
        name: AppRoutes.STAFFHOME,
        page: () => StaffHomeScreen(),
        bindings: [StaffHomeBinding()]),
    GetPage(
        name: AppRoutes.STAFFCIRCULAR,
        page: () => const StaffCircularScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFEVENT,
        page: () => const StaffEventScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFNEWS,
        page: () => const StaffNewsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFSMS,
        page: () => SMSScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFVOICE,
        page: () => const StaffVoiceScreen(),
        bindings: []),

    //Staff
    GetPage(
        name: AppRoutes.STAFFVIEWHOMEWORK,
        page: () => StaffViewHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPLYHOMEWORK,
        page: () => StaffReplyHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPLYHOMEWORK2,
        page: () => StaffReplyStaffHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFADDENTRYHOMEWORK,
        page: () => StaffAddEntryHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPLYENTRYHOMEWORK,
        page: () => StaffReplyEntryHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPLYENTRYHOMEWORK2,
        page: () => StaffReplyStaffEntryHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPORTHOMEWORK,
        page: () => StaffReportHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTEACHERVIEWHOMEWORK,
        page: () => StaffClassTeacherViewHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFVIEWCLASSTEST,
        page: () => StaffViewClasstest(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPLYCLASSTEST,
        page: () => StaffResultClasstest(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFADDENTRYCLASSTEST,
        page: () => StaffAddEntryClasstest(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFREPORTCLASSTEST,
        page: () => StaffReportClasstest(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTEACHERVIEWCLASSTEST,
        page: () => StaffClassTeacherViewClasstest(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTIMETABLE,
        page: () => const StaffClassTimetable(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTIMETABLEVIEW,
        page: () => StaffClassTimetableView(0),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFATTENDANCEDETAILS,
        page: () => StaffAttendanceDetailsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFLEAVELIST,
        page: () => StaffLeaveList(),
        bindings: [LeaveListBinding()]),
    GetPage(
        name: AppRoutes.STAFFSALARYLIST,
        page: () => const StaffSalaryListScreen(),
        bindings: [SalaryListBinding()]),
    GetPage(
        name: AppRoutes.STAFFCIRCULAR,
        page: () => const StaffCircularScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFEVENT,
        page: () => const StaffEventScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFNEWS,
        page: () => const StaffNewsScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFSMS,
        page: () => StaffSMSScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFVOICE,
        page: () => const StaffVoiceScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFSALARYLIST,
        page: () => const StaffSalaryListScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFEPFESIMANAGE,
        page: () => const EpfAndEsiManageScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFADVANCESALARY,
        page: () => const StaffAdvanceSalaryScreen(),
        bindings: [AdvanceSalaryBinding()]),
    GetPage(
        name: AppRoutes.STAFFLOANDETAILS,
        page: () => const StaffLoanDetailsScreen(),
        bindings: [LoanBinding()]),
    GetPage(
        name: AppRoutes.STAFFEXAMRESULT,
        page: () => StaffExamResultScreen(),
        bindings: [StaffExamResultBinding()]),
    GetPage(
        name: AppRoutes.STAFFEXAMTIMETABLE,
        page: () => const StaffExamTimeTableScreen(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCLASSTEACHEREXAMRESULT,
        page: () => const StaffClassTeacherExamResult(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFSTUDENTLISTDETAILS,
        page: () => StudentsListDetailsScreen(),
        bindings: [StudentsBinding()]),
    GetPage(
        name: AppRoutes.STAFFSTUDENTATTENDANE,
        page: () => const StudentAttendanceDetailsScreen(),
        bindings: [StudentsBinding()]),
    GetPage(
        name: AppRoutes.STAFFSTUDENTLEAVEREQUEST,
        page: () => StudentLeaveRequestScreen(),
        bindings: [StudentsBinding()]),
    GetPage(
        name: AppRoutes.STAFFSCHOOLCALENDER,
        page: () => const StaffSchoolCalenderScreen(),
        bindings: [StaffCalenderBinding()]),
    GetPage(
        name: AppRoutes.STAFFPROFILE,
        page: () => StaffProfileScreen(),
        bindings: [StaffProfileBinding()]),
    GetPage(
        name: AppRoutes.STAFFSUBJECTADDENTRYHOMEWORK,
        page: () => SubjectStaffAddEntryHomework(),
        bindings: []),
    GetPage(
        name: AppRoutes.STAFFCTADDENTRYCLASSTEST,
        page: () => StaffCTAddEntryClasstest(),
        bindings: []),
  ];
}
