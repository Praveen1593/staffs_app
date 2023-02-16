
import 'package:flutter_projects/parent/model/voiceOverallModel.dart';

import '../../../../../common/enums/loading_enums.dart';

class CustomVoiceOverallModel{
  String? date;
  int? flag;
  VoiceOverallData? voiceOverallData;

  CustomVoiceOverallModel(this.date, this.flag, this.voiceOverallData);

}


class CustomVoiceLoadingState {
  LoadingType? loadingType;
  String? error;
  String? completed;

  CustomVoiceLoadingState({required this.loadingType, this.error, this.completed});
}
