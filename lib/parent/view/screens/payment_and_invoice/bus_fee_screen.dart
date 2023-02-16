import 'package:flutter/material.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../../common/widgets/common_widgets.dart';
import '../../../themes/app_styles.dart';

class BusFeeScreen extends StatelessWidget {
  const BusFeeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            itemCount: 2,
            shrinkWrap: true,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15.0, top: 10, bottom: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(bottom: 6.0),
                            child: Text(
                              "Bus Fee",
                              style: AppStyles.arimBold.copyWith(
                                  color: AppColors.darkPinkColor,
                                  fontSize: 16),
                            ),
                          ),
                          buildText("Total:${Constants.RUPEESYMBOOL} 0"),
                          buildText("Discount:${Constants.RUPEESYMBOOL} 0"),
                          buildText("Paid:${Constants.RUPEESYMBOOL} 0"),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${Constants.RUPEESYMBOOL} 0.00",
                              style: AppStyles.arimBold.copyWith(
                                  color: AppColors.blackColor,
                                  fontSize: 20),
                            ),
                            Text("pending",
                                style: AppStyles.arimBold.copyWith(
                                    color: AppColors.lytGreyColor,
                                    fontSize: 12))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )),
        _feePendingTotalAMountCard()
      ],
    );
  }


  Widget _feePendingTotalAMountCard() {
    return Expanded(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: SizedBox(
          width: double.infinity,
          height: 80,
          child: Card(
              elevation: 10,
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 4.0, bottom: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Total: ${Constants.RUPEESYMBOOL} 500"),

                        Padding(
                          padding: EdgeInsets.only(top: 12.0, bottom: 12),
                          child: Text("Discount :${Constants.RUPEESYMBOOL} 0"),
                        ),

                        Text("Paid: ${Constants.RUPEESYMBOOL} 0"),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0.0, bottom: 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${Constants.RUPEESYMBOOL} 4550.00",
                            style: AppStyles.arimBold.copyWith(
                                color: AppColors.darkPinkColor,
                                fontSize: 20),
                          ),
                          Text(
                            "Total Pending",
                            style: AppStyles.normal.copyWith(
                                color: AppColors.greyColor, fontSize: 16),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
