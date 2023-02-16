
import 'package:flutter_projects/parent/model/class_test_model.dart';

import '../../../../../common/enums/loading_enums.dart';

class CustomClassTestTodayModel{
  String? date;
  int? flag;
  ClassTestTodaySubjectModel? classTestTodayData;

  CustomClassTestTodayModel(this.date, this.flag, this.classTestTodayData);
}


class CustomClassTestTodayLoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  CustomClassTestTodayLoadingState({required this.loadingType, this.error, this.completed});
}
