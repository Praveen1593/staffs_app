import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';

import '../../../../../common/const/colors.dart';

class StaffExamTimeTableScreen extends StatelessWidget {
  const StaffExamTimeTableScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Exam Time Table"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
