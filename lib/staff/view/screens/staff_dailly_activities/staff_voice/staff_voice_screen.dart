import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';

import '../../../../../common/const/colors.dart';

class StaffVoiceScreen extends StatelessWidget {
  const StaffVoiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Voice"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
