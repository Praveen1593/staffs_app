import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/screens/Home/home_screen.dart';
import 'package:flutter_projects/staff/view/screens/staff_home/staff_home_screen.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../common/const/colors.dart';
import 'common/const/contsants.dart';
import 'common/const/image_constants.dart';
import 'common/routes/app_routes.dart';
import 'common/widgets/common_widgets.dart';
import 'parent/themes/app_styles.dart';
import 'storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
   AnimationController? lottieController;
  bool lottieValue = false;

  @override
  void initState() {
    super.initState();
    lottieController = AnimationController(
      vsync: this,
    );

    Timer(const Duration(milliseconds: 3000), () {
      lottieValue = true;
      setState(() {});
    });
    Timer(const Duration(milliseconds: 4000), () {
      if (LocalStorage.getValue('login') == true) {
        if (LocalStorage.getValue("type") == 1) {
          Get.offAll(HomeScreen());
            } else if (LocalStorage.getValue("type") == 2) {
          Get.offAll(StaffHomeScreen());
        } else {}
      } else {
        Get.offNamed(AppRoutes.LOGINVIEW);
      }
    });
  }

  @override
  void dispose() {
    lottieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        body: lottieValue
            ? Stack(
                children: [
                  smsBandSplashWidget(),
                  cblazeinfotechText(),
                ],
              )
            : animatedSplashWidget());
  }

  Widget smsBandSplashWidget() => const Center(
          child: SMSImageAsset(
        image: ImageConstants.smsBandSplashImg,
        width: 200,
        height: 200,
      ));

  Widget animatedSplashWidget() => Center(
        child: Lottie.asset(ImageConstants.splashJsonImg,
            animate: false,
            controller: lottieController, onLoaded: (composition) {
          lottieController?.duration = const Duration(milliseconds: 3200);
          lottieController?.forward();
        }),
      );

  Widget cblazeinfotechText() => Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(Constants.DEVELOPEDBY,style: AppStyles.PoppinsRegular
              .copyWith(fontSize: 12, color: AppColors.blackColor)),
          const SizedBox(height: 2,),
          Text(Constants.CBLAZEINFOTECHTEXT,
              style: AppStyles.PoppinsBold
                  .copyWith(fontSize: 15, color: AppColors.blackColor)),
        ],
      ));
}
