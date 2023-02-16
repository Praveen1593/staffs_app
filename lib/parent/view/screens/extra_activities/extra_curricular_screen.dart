import 'package:flutter/material.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/widgets/common_widgets.dart';

class ExtraCurricularScreen extends StatelessWidget {
  const ExtraCurricularScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Extra Curricular"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
