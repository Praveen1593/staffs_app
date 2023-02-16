import 'package:flutter/material.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/widgets/common_widgets.dart';

class RefreshmentScreen extends StatelessWidget {
  const RefreshmentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Refreshment"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
