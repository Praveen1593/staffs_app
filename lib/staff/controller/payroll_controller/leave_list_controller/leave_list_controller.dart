import 'package:flutter/material.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/enums/loading_enums.dart';
import '../../../../common/services/base_client.dart';
import '../../../../parent/model/attendance_model.dart';
import '../../../../parent/view/dialogs/dialog_helper.dart';
import '../../../model/PayrollLeaveRequestCreateReponce.dart';
import '../../../model/PayrollLeaveRequestListModel.dart';
import '../../../model/PayrollLeaveTypeModel.dart';

class LeaveListController extends GetxController {
  bool isExtended = true;
  TextEditingController leaveReasonController = TextEditingController();
  int? type = 0;
  String selectedDate = "";
  String startDate = "";
  String endDate = "";
  String startingDateValue = "";
  String endingDateValue = "";
  double? leaveCount = 0;
  String? noOfLeaves;
  PayrollLeaveTypeModel? payrollLeaveTypeModel;
  List<String> leaveList = [];
  String? selectedLeaveType;
  PayrollLeaveRequestListModel? payrollLeaveRequestListModel;
  List<LeaveRequestListData>? leaveRequestList;
  List<Datum> leaveTypeListData = [];
  String selectLeaveType = "Select Type";
  int? selectedLeaveTypeId;
  PayrollLeaveRequestCreateReponce? createResponce;
  int? leaveRequestId;

  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState =
      LeaveRequestListState(loadingType: LoadingType.stable).obs;

  List<LeaveRequestListData> finalList = <LeaveRequestListData>[].obs;

  void updateValue() {
    isExtended = !isExtended;
    update();
  }

  updateSelectedLeaveType(String selectType){
    selectLeaveType = selectType;
    update();
  }

  void typeUpdate(int value) {
    type = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getLeaveListData();
    fetchLeaveTypeListData();
    scrollController.addListener(_scrollListener);
  }

  Future getLeaveListData() async {
    if (_pageNo == 1) {
      isLoading.value = true;
    }
    try {
      final result = await BaseService().getMethod(
          "https://test.schoolec.in/api/staff/v2/payroll/leave-request/list?page=$_pageNo");
      if (result != null) {
        if (result.statusCode == 200) {
          payrollLeaveRequestListModel =
              PayrollLeaveRequestListModel.fromJson(result.data);
          finalList.assignAll(payrollLeaveRequestListModel?.data ?? []);
          isLoading.value = false;
          print("getLeaveListData : ${result.statusCode}");
        } else {
          print("getLeaveListData : ${result.statusCode}");
        }
      }
    } catch (e) {
      print("getLeaveListData : error");
    } finally {}
    update();
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value =
          LeaveRequestListState(loadingType: LoadingType.loading);
      try {
        List<LeaveRequestListData> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        listOfData = await getLeaveListData();

        if (listOfData.isEmpty) {
          loadingState.value = LeaveRequestListState(
              loadingType: LoadingType.completed,
              completed: "there is no data");
        } else {
          finalList.addAll(listOfData);
          loadingState.value =
              LeaveRequestListState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value = LeaveRequestListState(
            loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

/*  void _getData() async {
    List<LeaveRequestListData> listOfData = [];
    listOfData = await fetchLeaveRequestData(url: "https://test.schoolec.in/api/staff/v2/payroll/leave-request/list&page=$_pageNo");
    leaveRequestList?.clear();
    leaveRequestList?.assignAll(listOfData);
    isLoading.value = false;
  }*/

  Future fetchLeaveRequestData({String? url}) async {
    leaveRequestList = [];
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          payrollLeaveRequestListModel =
              PayrollLeaveRequestListModel.fromJson(result.data);
          if (payrollLeaveRequestListModel!.data != null) {
            leaveRequestList?.addAll(payrollLeaveRequestListModel!.data!);
          }
        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
  }


  Future leaveListData() async {
    final result = await BaseService().getMethod(
        "https://test.schoolec.in/api/staff/v2/payroll/leave-type-list");
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          payrollLeaveTypeModel = PayrollLeaveTypeModel.fromJson(result.data);
          if (payrollLeaveTypeModel!.data != null &&
              payrollLeaveTypeModel!.data!.isNotEmpty) {
            for (int i = 0; i < payrollLeaveTypeModel!.data!.length; i++) {
              leaveList.add(payrollLeaveTypeModel!.data![i].name ?? "");
            }
          }
        } else {
          print("standardListData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("standardListData $e");
    } finally {}
    update();
  }

  Future fetchLeaveTypeListData() async {
    final result = await BaseService().getMethod(ApiHelper.leaveTypeListUrl);
    try {
      if (result != null) {
        if (result.statusCode == 200) {
          print("result.data ${result.data}");
          PayrollLeaveTypeModel payrollModel =
              PayrollLeaveTypeModel.fromJson(result.data);
          leaveTypeListData = payrollModel.data ?? [];
          print("leaveTypeListData ${leaveTypeListData}");
        } else {
          print("standardListData: ${result.statusCode}");
        }
      }
    } catch (e) {
      print("standardListData $e");
    } finally {}
    update();
  }

  Future selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015),
        lastDate: DateTime(2050),
        currentDate: DateTime.now(),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    startDate = DateFormat('yyyy-MM-dd').format(pickedDate ?? DateTime.now());
    endDate = "";
    selectedDate = startDate;
    leaveCount = 1;
    print("selected Date : $selectedDate");
    update();
  }


  Future leaveRequestEdit(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    dynamic result;
    try {
      result = await BaseService().postMethod(userData, "https://test.schoolec.in/api/staff/v2/payroll/leave-request/edit");//ApiHelper.leaveRequestEdit
      if (result != null) {
        if (result.statusCode == 200) {
         // createResponce = PayrollLeaveRequestCreateReponce.fromJson(result.data);
          print('leaveRequestCreate: ${result.statusCode}');
        } else {
          print('leaveRequestCreate: ${result.statusCode}');
        }
      }
    } catch (e) {
      print('leaveRequestCreate $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }




  Future leaveRequestCreate(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    dynamic result;
    try {
      result = await BaseService().postMethod(userData, ApiHelper.leaveRequestCreate);
      if (result != null) {
        if (result.statusCode == 200) {
          createResponce = PayrollLeaveRequestCreateReponce.fromJson(result.data);
          print('leaveRequestCreate: ${result.statusCode}');
        } else {
          print('leaveRequestCreate: ${result.statusCode}');
        }
      }
    } catch (e) {
      print('leaveRequestCreate $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future dateRangeDialog(BuildContext context) async {
    DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(1800, 1, 1),
        lastDate: DateTime(3000, 12, 31),
        currentDate: DateTime.now(),
        saveText: 'SAVE',
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.darkPinkColor, // <-- SEE HERE
                onPrimary: AppColors.whiteColor, // <-- SEE HERE
                surface: AppColors.blackColor,
              ),
            ),
            child: child!,
          );
        });
    if (result != null) {
      startDate = result.start.toString().split(' ')[0];
      endDate = result.end.toString().split(' ')[0];
      selectedDate = "$startDate - $endDate";
      noOfLeaves = result.end.difference(result.start).inDays.toString();
      if (noOfLeaves != null && noOfLeaves != "") {
        leaveCount = double.parse(noOfLeaves!);
      }

      //sendMultipleDays(startDate, endDate);
      update();
    }
  }

/* Future sendMultipleDays(String startingDate, String endingDate, String eventType) async {
    Future.delayed(const Duration(seconds: 1));
    startingDateValue = startingDate;
    endingDateValue = endingDate;
    _getData();
    update();
  }*/

}
