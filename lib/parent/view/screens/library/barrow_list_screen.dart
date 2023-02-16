import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../controllers/library_controller/barrow_controller.dart';
import '../../../../../common/enums/loading_enums.dart';
import '../../../themes/app_styles.dart';
import '../../../../../common/widgets/common_widgets.dart';

class BarrowListScreen extends GetView<BarrowController> {
  const BarrowListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: AppColors.whiteColor,
      appBar: smsAppbar("Barrow List"),
      body: Obx(() {
        final loadingType = controller.loadingState.value.loadingType;
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (controller.finalList.isEmpty) {
          return const Center(child: Text("No Data"));
        }
        return  ListView(
          controller: controller.scrollController,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: loadingType == LoadingType.loading ||
                    loadingType == LoadingType.error ||
                    loadingType == LoadingType.completed
                    ? controller.finalList.length + 1
                    : controller.finalList.length,
                itemBuilder: (BuildContext context, int index) {
                  final isLastItem = index == controller.finalList.length;

                  if (isLastItem && loadingType == LoadingType.loading) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (isLastItem && loadingType == LoadingType.error) {
                    return Text(controller.loadingState.value.error.toString());
                  } else if (isLastItem && loadingType == LoadingType.completed) {
                    return Text(
                        controller.loadingState.value.completed.toString());
                  } else {
                    return _buildBody(context);
                  }
                },
                separatorBuilder: (context, index) => Container(),
              ),
            )
          ],
        );
      })
    );
  }

  Widget _buildBody(BuildContext context){

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
        height: height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, bottom: 10, right: 5, left: 5),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.finalList.length,
                  itemBuilder: (BuildContext context,int index){
                    return Padding(
                      padding: const EdgeInsets.only(top: 10,bottom: 10,right: 5,left: 5),
                      child: SizedBox(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.finalList[index].bookName??"",
                                        style: AppStyles.NunitoExtrabold.copyWith(
                                            fontSize: 15
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Academic Year : ${controller.finalList[index].academic??""}",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 12
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Library Code : ${controller.finalList[index].code??""}",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 12
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Get Date : ${controller.finalList[index].getDate??""}",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 12
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "Due Date : ${controller.finalList[index].dueDate??""}",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 12
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        controller.finalList[index].status??"",
                                        style: AppStyles.NunitoExtrabold.copyWith(
                                          fontSize: 15,
                                          color: AppColors.darkPinkColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        controller.finalList[index].fineStatus??"",
                                        style: AppStyles.NunitoRegular.copyWith(
                                            fontSize: 11
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));

}
}
