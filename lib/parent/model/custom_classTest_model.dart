
import 'package:flutter_projects/parent/model/class_test_past_model.dart';

import '../../../../../common/enums/loading_enums.dart';

class CustomClassTestModel{
  String? date;
  int? flag;
  ClassTestPastSubject? classTestPastSubject;

  CustomClassTestModel(this.date, this.flag, this.classTestPastSubject);
}


class CustomClassTestLoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  CustomClassTestLoadingState({required this.loadingType, this.error, this.completed});
}
