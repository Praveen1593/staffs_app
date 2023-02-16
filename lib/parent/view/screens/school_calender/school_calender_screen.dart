import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../common/common_model/custom_school_calender_model.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../controllers/daily_activity_controller/calender/calender_controller.dart';
import '../../../../common/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SchoolCalenderScreen extends StatefulWidget {
  const SchoolCalenderScreen({Key? key}) : super(key: key);

  @override
  State<SchoolCalenderScreen> createState() => _SchoolCalenderScreenState();
}

class _SchoolCalenderScreenState extends State<SchoolCalenderScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final controller = Get.put(CalenderController());

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<dynamic> _getEventsForDay(DateTime day) {
    return controller.getEvent()[day] ?? [];
  }

  List<CustomSchoolCalenderModel> myEvent = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar(Constants.SCHOOLCALENDER),
      body: GetBuilder<CalenderController>(
        init: CalenderController(),
        builder: (calenderController) {
          return calenderController.isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    TableCalendar(
                      firstDay: DateTime.utc(DateTime.now().year - 10,
                          DateTime.now().month, DateTime.now().day),
                      lastDay: DateTime.utc(DateTime.now().year + 1,
                          DateTime.now().month, DateTime.now().day),
                      focusedDay: _focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(_selectedDay, day);
                      },
                      rangeStartDay: _rangeStart,
                      rangeEndDay: _rangeEnd,
                      rowHeight: 75.0,
                      headerStyle: const HeaderStyle(
                        titleCentered: true,
                        titleTextStyle: TextStyle(
                            fontSize: 17.0, color: AppColors.whiteColor),
                        decoration:
                            BoxDecoration(color: AppColors.darkPinkColor),
                        headerMargin: EdgeInsets.only(top: 8.0, bottom: 8.0),
                        leftChevronIcon: Icon(
                          Icons.chevron_left,
                          color: AppColors.whiteColor,
                        ),
                        rightChevronIcon: Icon(
                          Icons.chevron_right,
                          color: AppColors.whiteColor,
                        ),
                      ),
                      calendarFormat: _calendarFormat,
                      sixWeekMonthsEnforced: false,
                      eventLoader: _getEventsForDay,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Month'
                      },
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      calendarStyle: CalendarStyle(
                        canMarkersOverflow: false,
                        rangeHighlightScale: 0.5,
                        markerSizeScale: 0.5,
                        markersAnchor: 0.5,
                        markersMaxCount: 1,
                        rowDecoration: const BoxDecoration(
                            border: Border.fromBorderSide(BorderSide(
                                width: 0.5,
                                color: AppColors.greyColor,
                                style: BorderStyle.solid))),
                        cellAlignment: Alignment.center,
                        cellMargin: const EdgeInsets.all(10.0),
                        markersAlignment: const Alignment(0.0, 0.7)
                            .add(Alignment.bottomCenter),
                        markerMargin: const EdgeInsets.symmetric(vertical: 10),
                        markerDecoration: const BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  "https://spng.pinpng.com/pngs/s/27-278581_check-mark-computer-icons-clip-art-green-check.png",
                                ),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle),
                        outsideDaysVisible: false,
                      ),
                      onDaySelected: (selectedDate, date) {
                        _selectedDay = selectedDate;
                        _focusedDay = date;
                        myEvent = [];
                        for (var i = 0;
                            i < calenderController.calenderData.length;
                            i++) {
                          List<DateTime> noOfDays = [];

                          noOfDays = calenderController.calculateDaysInterval(
                              DateTime.parse(calenderController
                                  .calenderData[i].startDate
                                  .toString()),
                              DateTime.parse(calenderController
                                  .calenderData[i].endDate
                                  .toString()));

                          List<DateTime> myDate = [];
                          for (int m = 0; m < noOfDays.length; m++) {
                            myDate.add(noOfDays[m]);
                          }
                          for (int n = 0; n < myDate.length; n++) {
                            if (myDate[n].toString() ==
                                selectedDate.toString().replaceAll("Z", "")) {
                              myEvent.add(CustomSchoolCalenderModel(
                                  title:
                                      calenderController.calenderData[i].title,
                                  description: calenderController
                                      .calenderData[i].description,
                                  eventName: calenderController
                                      .calenderData[i].eventTypeName));
                            }
                          }
                        }
                        setState(() {});
                      },
                      onFormatChanged: (format) {
                        if (_calendarFormat != format) {
                          setState(() {
                            _calendarFormat = format;
                          });
                        }
                      },
                      onPageChanged: (focusedDay) {
                        setState(() {
                          calenderController.isLoading = true;
                          myEvent = [];
                          _selectedDay = DateTime.now();
                        });
                        _focusedDay = focusedDay;
                        calenderController.fetchMonthList(
                            DateFormat("MMMM").format(_focusedDay));
                      },
                    ),
                    const SizedBox(height: 8.0),
                    Expanded(
                        child: myEvent.isNotEmpty
                            ? ListView.builder(
                                itemCount: myEvent.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    elevation: 5,
                                    child: ListTile(
                                      title: Text(
                                        myEvent[index].title ?? "",
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      subtitle: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(myEvent[index].description ?? "",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.grey,
                                                      fontSize: 10))
                                              .paddingOnly(bottom: 10),
                                          Text(myEvent[index].eventName ?? "",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.black,
                                                      fontSize: 13))
                                              .paddingOnly(bottom: 5),
                                        ],
                                      ),
                                      leading: Container(
                                        height: 30,
                                        width: 30,
                                        decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                  "https://spng.pinpng.com/pngs/s/27-278581_check-mark-computer-icons-clip-art-green-check.png",
                                                ),
                                                fit: BoxFit.cover),
                                            shape: BoxShape.circle),
                                      ),
                                    ).paddingAll(5),
                                  );
                                },
                              )
                            : Container()),
                  ],
                );
        },
      ),
    );
  }
}
