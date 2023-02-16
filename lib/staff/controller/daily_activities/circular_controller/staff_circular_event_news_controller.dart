import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/common_controller/base_controller.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/apihelper/api_helper.dart';
import '../../../../common/enums/loading_enums.dart';
import '../../../../parent/model/custom_model.dart';
import '../../../../parent/model/news_circular_event_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../../storage.dart';

class StaffNewsCircularEventController extends BaseController
    with GetTickerProviderStateMixin{
  DateTime currentDate = DateTime.now();
  String startDate = "";
  String endDate = "";
  List combineListData = [];
  List<CustomModel> customModel = [];
  List<CustomModel> finalList = <CustomModel>[].obs;
  List dateList = [];
  final arguments = Get.arguments;
  String selectedDate = "";
  ScrollController scrollController = ScrollController();
  int _pageNo = 1;
  final isLoading = true.obs;
  final loadingState = LoadingState(loadingType: LoadingType.stable).obs;
  String type = "";
  String startingDateValue = "";
  String endingDateValue = "";
  bool isVisiblePastView = true;
  TabController? tabController;
  int currentTab = 0;
  AnimationController? lottieController;

  @override
  void onInit() {
    super.onInit();
    lottieController = AnimationController(
      vsync: this,
    );
    currentTab = 0;
    tabController = TabController(vsync: this, length: 2);
    finalList = [];
    isVisiblePastView = true;
    _getData();
    scrollController.addListener(_scrollListener);
    tabController?.addListener(() {
      currentTab = tabController?.index ?? 0;
      if (currentTab == 0) {
        finalList = [];
        isVisiblePastView = true;
        _getData();
      } else {
        isVisiblePastView = false;
        finalList = [];
      }
    });
  }

  @override
  void dispose() {
    lottieController?.dispose();
    super.dispose();
  }

  @override
  void onClose() {
    lottieController?.dispose();
    super.onClose();
  }

  updateTabIndex(int index) {
    currentTab = index;
    update();
  }

  void _getData() async {
    if (_pageNo == 1) {
      isLoading.value = true;
    }
    finalList = [];
    List<CustomModel> listOfData = [];
    if (arguments["tag"] != null) {
      if (arguments["tag"] == "Circular") {
        _pageNo = 1;
        if (currentTab == 0) {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.circularUrl}page=$_pageNo");
        } else {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.pastUrl}type=$type&start_date=$startingDateValue&end_date=$endingDateValue&page=$_pageNo");
        }
      } else if (arguments["tag"] == "Event") {
        _pageNo = 1;
        if (currentTab == 0) {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.eventUrl}page=$_pageNo");
        } else {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.pastUrl}type=$type&start_date=$startingDateValue&end_date=$endingDateValue&page=$_pageNo");
        }
      } else if (arguments["tag"] == "News") {
        _pageNo = 1;
        if (currentTab == 0) {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.newsUrl}page=$_pageNo");
        } else {
          listOfData = await fetchData(
              url:
                  "${ApiHelper.pastUrl}type=$type&start_date=$startingDateValue&end_date=$endingDateValue&page=$_pageNo");
        }
      } else {}
    }
    finalList.clear();
    finalList.assignAll(listOfData);
    isLoading.value = false;
  }

  void _scrollListener() async {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      loadingState.value = LoadingState(loadingType: LoadingType.loading);
      try {
        List<CustomModel> listOfData = [];
        await Future.delayed(const Duration(seconds: 5));
        if (arguments["tag"] != null) {
          if (arguments["tag"] == "Circular") {
            if (currentTab == 0) {
              listOfData = await fetchData(
                  url:
                      "${ApiHelper.circularUrl}page=${++_pageNo}");
            } else {
              listOfData = await fetchData(
                  url:
                      "${ApiHelper.pastUrl}type=$type&start_date=$startingDateValue&end_date=$endingDateValue&page=${++_pageNo}");
            }
          } else if (arguments["tag"] == "Event") {
            if (currentTab == 0) {
              listOfData = await fetchData(
                  url:
                      "l${ApiHelper.eventUrl}page=${++_pageNo}");
            } else {
              listOfData = await fetchData(
                  url:
                      "${ApiHelper.pastUrl}type=$type&start_date=$startingDateValue&end_date=$endingDateValue&page=${++_pageNo}");
            }
          } else if (arguments["tag"] == "News") {
            if (currentTab == 0) {
              listOfData = await fetchData(
                  url:
                      "${ApiHelper.newsUrl}page=${++_pageNo}");
            } else {
              listOfData = await fetchData(
                  url:
                      "${ApiHelper.pastUrl}type=$type&start_date=$startingDateValue&end_date=$endingDateValue&page=${++_pageNo}");
            }
          } else {}
        }
        if (listOfData.isEmpty) {
          loadingState.value =
              LoadingState(loadingType: LoadingType.completed, completed: "");
        } else {
          finalList.addAll(listOfData);
          loadingState.value = LoadingState(loadingType: LoadingType.loaded);
        }
      } catch (err) {
        loadingState.value =
            LoadingState(loadingType: LoadingType.error, error: err.toString());
      }
    }
  }

  Future<List<CustomModel>> fetchData({String? url}) async {
    customModel = [];
    dateList = [];
    try {
      final result = await BaseService().getMethod(url ?? "");
      if (result != null) {
        if (result.statusCode == 200) {
          NewsCircularModel newsCircularModel =
              NewsCircularModel.fromJson(result.data);
          List<NewModel> newsData = newsCircularModel.newsData;
          if (newsData.isNotEmpty) {
            for (int i = 0; i < newsData.length; i++) {
              dateList.add(newsData[i].date);
            }
            LinkedHashSet set = LinkedHashSet();
            set.addAll(dateList);
            dateList.clear();
            dateList.addAll(set);
            for (int i = 0; i < dateList.length; i++) {
              customModel.add(CustomModel(
                  date: dateList[i], flag: -1, customResponse: null));
              for (int j = 0; j < newsData.length; j++) {
                if (newsData[j].date == dateList[i]) {
                  customModel.add(CustomModel(
                      date: "", flag: 1, customResponse: newsData[j]));
                }
              }
            }
          } else {
            customModel = [];
            dateList = [];
          }
        }
      }
    } catch (e) {
      print('Fetch News / Circular / Event  $e');
    }
    update();
    return customModel;
  }

  Future sendMultipleDays(
      String startingDate, String endingDate, String eventType) async {
    Future.delayed(const Duration(seconds: 1));
    finalList = [];
    type = eventType;
    startingDateValue = startingDate;
    isVisiblePastView = false;
    endingDateValue = endingDate;
    _getData();
    update();
  }

  updateFinalList() {
    finalList = [];
    update();
  }

  Future sendSingleDay(String eventType, String startingDate) async {
    Future.delayed(const Duration(seconds: 1));
    finalList = [];
    type = eventType;
    startingDateValue = startingDate;
    isVisiblePastView = false;
    endingDateValue = "";
    _getData();
    update();
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(1800),
        lastDate: DateTime(3000),
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
    if (pickedDate != null) {
      currentDate = pickedDate;
      selectedDate = currentDate.toString().split(' ')[0];
      if (arguments["tag"] == "Circular") {
        sendSingleDay("1", selectedDate);
      } else if (arguments["tag"] == "Event") {
        sendSingleDay("2", selectedDate);
      } else if (arguments["tag"] == "News") {
        sendSingleDay("3", selectedDate);
      } else {}
      update();
    }
  }

  Future<void> dateRangeDialog(BuildContext context) async {
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
      if (arguments["tag"] == "Circular") {
        sendMultipleDays(startDate, endDate, "1");
      } else if (arguments["tag"] == "Event") {
        sendMultipleDays(startDate, endDate, "2");
      } else if (arguments["tag"] == "News") {
        sendMultipleDays(startDate, endDate, "3");
      } else {}
      update();
    }
  }
}
