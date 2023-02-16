import 'package:flutter/material.dart';

import '../../../../../common/const/colors.dart';
import '../../../../../common/widgets/common_widgets.dart';

class StaffClassTeacherExamResult extends StatelessWidget {
  const StaffClassTeacherExamResult({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("Class Teacher"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
