import 'package:flutter/material.dart';
import 'package:flutter_projects/common/const/colors.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';
class EpfAndEsiManageScreen extends StatelessWidget {
  const EpfAndEsiManageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: smsAppbar("EPF & ESI Manage"),
      body: Container(
        color: AppColors.whiteColor,
      ),
    );
  }
}
