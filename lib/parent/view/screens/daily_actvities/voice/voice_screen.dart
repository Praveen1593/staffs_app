import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/view/screens/daily_actvities/voice/voice_overall.dart';
import 'package:flutter_projects/parent/view/screens/daily_actvities/voice/voice_specific.dart';
import 'package:get/get.dart';
import '../../../../../common/const/colors.dart';
import '../../../../controllers/daily_activity_controller/voice_controller/voice_controller.dart';
import '../../../../../common/widgets/common_widgets.dart';
import 'voice_custom.dart';

class VoiceScreen extends StatelessWidget {
  const VoiceScreen({Key? key}) : super(key: key);



  Widget _buildBody(VoiceController voiceController,BuildContext context){
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: smsAppbar("Voice"),
        body: DefaultTabController(
            length: 3, // length of tabs
            initialIndex: 0,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.all(20.0),
                     child: Container(
                       height: 45,
                       decoration: BoxDecoration(
                         color: Color(0XFFECF4FF),
                         borderRadius: BorderRadius.circular(
                           25.0,
                         ),
                       ),
                       child: TabBar(
                        labelColor: Color(0XFFFFFFFF),
                        unselectedLabelColor: AppColors.greyColor,
                        indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0XFF407BFF)
                        ),
                        indicatorColor: AppColors.darkPinkColor,
                        isScrollable: false,
                        tabs: [
                          Tab(
                            child: Text('LATEST',style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Tab(
                            child: Text('SPECIFIC',style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                          Tab(
                            child: Text('OVERALL',style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                  ),
                     ),
                   ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.8,
                    child:   TabBarView(children: <Widget>[
                      VoiceCustom(),
                      VoiceSpecific(),
                      VoiceOverall(),
                    ]),
                  )
                ])));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VoiceController>(
        init: VoiceController(),
        builder: (voiceController){
          return _buildBody(voiceController, context);
        });
  }
}
