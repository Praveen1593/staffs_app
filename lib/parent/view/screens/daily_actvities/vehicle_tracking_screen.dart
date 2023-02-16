import 'package:flutter/material.dart';

import '../../../../../common/widgets/common_widgets.dart';
import '../../../../common/const/colors.dart';

class VehicleTRackingScreen extends StatelessWidget {
  const VehicleTRackingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Vehicle Tracking"),
      body: Container(),
    );
  }
}
