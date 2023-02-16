import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';

class LiveClassesScreen extends StatelessWidget {
  const LiveClassesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Live Classes"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
