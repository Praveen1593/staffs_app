import 'package:flutter/material.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/widgets/common_widgets.dart';

class StudyLabsScreen extends StatelessWidget {
  const StudyLabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Study Lab"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
