import 'package:flutter/material.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/voice_controller/voice_controller.dart';
import '../../../../sample_audio_file.dart';
import '../../../../themes/app_styles.dart';

class VoiceCustom extends GetView<VoiceController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceController>(
        init: VoiceController(),
        builder: (controller) {
          return controller.finalList.isNotEmpty
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.finalList.length,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 25, left: 8.0),
                                    child: Text(
                                        "${controller.finalList[index].date}",
                                        style: AppStyles.PoppinsBold.copyWith(
                                          fontSize: 14,
                                          color: Color(0XFF252525),
                                        )),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 8.0, right: 8.0, top: 5),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Card(
                                        elevation: 5,
                                        child: Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Container(
                                                  width: 80,
                                                  color: Color(0XFFF2F5FA),
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.09,
                                                  child: Center(
                                                    child: SMSImageAsset(
                                                      image:
                                                      "assets/campuseasy/voice_image.png",
                                                      width: 45,
                                                      height: 45,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(top: 7),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                          "Voice",
                                                          style:
                                                          AppStyles.PoppinsRegular
                                                              .copyWith(
                                                            fontSize: 12,
                                                            color: Color(0XFF93A0A7),
                                                          )),
                                                      SizedBox(height: 10,),
                                                      Text(
                                                          "${controller.finalList[index].title}",
                                                          style:
                                                          AppStyles.PoppinsRegular
                                                              .copyWith(
                                                            fontSize: 15,
                                                            color: Color(0XFF252525),
                                                          )),
                                                      SizedBox(height: 5,),
                                                      Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              SMSImageAsset(image: "assets/campuseasy/voice_clock.png",width: 10,height: 10,),
                                                              SizedBox(width: 5,),
                                                              Text(
                                                                  "${controller.finalList[index].timeStamp}",
                                                                  style:
                                                                  AppStyles.PoppinsRegular
                                                                      .copyWith(
                                                                    fontSize: 8,
                                                                    color: Color(0XFF93A0A7),
                                                                  )),
                                                            ],
                                                          ),
                                                          InkWell(
                                                            child: Padding(
                                                              padding: const EdgeInsets.all(10.0),
                                                              child: SMSImageAsset(
                                                                image: "assets/campuseasy/voice_play_image.png",
                                                                width: 40,
                                                                height: 40,
                                                              ),
                                                            ),
                                                            onTap: (){
                                                              Get.to(SampleAudioPlayer(
                                                                  voiceTodayData:
                                                                  controller.finalList[index]));
                                                            },
                                                          ),
                                                        ],
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        mainAxisSize: MainAxisSize.max,
                                                      ),
                                                      SizedBox(height: 5,),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                )
              : SizedBox(
                  height: MediaQuery.of(context).size.height / 1.3,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
        });
  }
}
