
import 'package:flutter_projects/parent/model/VoiceTodayModel.dart';

import '../../../../../common/enums/loading_enums.dart';

class CustomVoiceTodayModel{
  String? date;
  int? flag;
  VoiceTodayData? voiceTodayData;

  CustomVoiceTodayModel(this.date, this.flag, this.voiceTodayData);
}


class CustomVoiceTodayLoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  CustomVoiceTodayLoadingState({required this.loadingType, this.error, this.completed});
}
