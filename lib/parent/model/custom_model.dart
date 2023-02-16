import '../../../../../common/enums/loading_enums.dart';
import 'news_circular_event_model.dart';

class CustomModel{
  String? date;
  int? flag;
  NewModel? customResponse;

  CustomModel({this.date, this.flag, this.customResponse});
}


class LoadingState {
  LoadingType loadingType;
  String? error;
  String? completed;

  LoadingState({required this.loadingType, this.error, this.completed});
}
