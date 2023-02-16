import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:flutter_credit_card/glassmorphism_config.dart';
import 'package:flutter_projects/common/widgets/common_widgets.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../../common/const/colors.dart';
import '../../../../common/const/contsants.dart';
import '../../../../common/widgets/staff_common_widgets.dart';
import '../../../../staff/themes/app_styles.dart';
import '../../../controllers/payment_controller/payment_controller.dart';
import '../../../model/KnetPaymentResponceModel.dart';
import '../../../model/PaymentTokenModel.dart';

class PaymentScreen extends StatelessWidget {
 int? feeAmt;

 PaymentScreen(this.feeAmt);

 @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: smsAppbar("payment"),
        resizeToAvoidBottomInset: false,
        body: GetBuilder<PaymentController>(
            init: PaymentController(),
            builder: (paymentController) {
              return paymentController.profileModel!=null?
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CreditCardWidget(
                    cardNumber: paymentController.cardNumberTxt.toString(),
                    expiryDate:
                    "${paymentController.mothTxt.toString()}/${paymentController.yearTxt.toString()}",
                    cardHolderName: paymentController.holderNameTxt.toString(),
                    cvvCode: paymentController.cvvTxt.toString(),
                    showBackView: paymentController.cvvTxt.toString().isNotEmpty
                        ? true
                        : false,
                    cardBgColor: Colors.orange,
                    obscureCardNumber: true,
                    obscureCardCvv: true,
                    isHolderNameVisible: true,
                    height: 175,
                    textStyle: const TextStyle(color: Colors.black),
                    width: MediaQuery.of(context).size.width,
                    isChipVisible: true,
                    isSwipeGestureEnabled: true,
                    animationDuration: const Duration(milliseconds: 1000),
                    onCreditCardWidgetChange: (CreditCardBrand) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _textField(
                        context,
                        paymentController,
                        "Account holder name",
                        paymentController.nameController,
                        15,
                        paymentController.name,
                        TextInputType.text,
                        1),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: _textField(
                        context,
                        paymentController,
                        "Card Number",
                        paymentController.cardNumberController,
                        16,
                        paymentController.cardNumber,
                        TextInputType.number,
                        2),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                            child: _textField(
                                context,
                                paymentController,
                                "MM",
                                paymentController.monthController,
                                2,
                                paymentController.month,
                                TextInputType.number,
                                3)),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _textField(
                                context,
                                paymentController,
                                "YY",
                                paymentController.yearController,
                                2,
                                paymentController.year,
                                TextInputType.number,
                                4)),
                        const SizedBox(width: 10),
                        Expanded(
                            child: _textField(
                                context,
                                paymentController,
                                "CVV",
                                paymentController.cvvController,
                                3,
                                paymentController.cvv,
                                TextInputType.number,
                                5)),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Billing Address",
                            style: AppStyles.NunitoExtrabold
                                .copyWith(fontSize: 18)),
                        InkWell(
                            onTap: (){
                              showModalBottomSheet(
                                  elevation: 10,
                                  isScrollControlled: true,
                                  backgroundColor: Colors.white,
                                  context: context,
                                  builder: (ctx) => Padding(
                                    padding: const EdgeInsets.only(
                                        top: 50, left: 10, right: 10),
                                    child: Stack(
                                      children: [
                                        SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                width: 30,
                                              ),
                                              Text("Billing Address",
                                                  style: AppStyles.NunitoExtrabold
                                                      .copyWith(fontSize: 18)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              _textField(
                                                  context,
                                                  paymentController,
                                                  "Address Line1",
                                                  paymentController
                                                      .address1Controller,
                                                  30,
                                                  paymentController.address1,
                                                  TextInputType.text,
                                                  6),
                                              _textField(
                                                  context,
                                                  paymentController,
                                                  "Address Line2",
                                                  paymentController
                                                      .address2Controller,
                                                  30,
                                                  paymentController.address2,
                                                  TextInputType.text,
                                                  7),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: _textField(
                                                          context,
                                                          paymentController,
                                                          "City",
                                                          paymentController
                                                              .cityController,
                                                          20,
                                                          paymentController.city,
                                                          TextInputType.text,
                                                          8)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: _textField(
                                                          context,
                                                          paymentController,
                                                          "State",
                                                          paymentController
                                                              .stateController,
                                                          20,
                                                          paymentController.state,
                                                          TextInputType.text,
                                                          9)),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: _textField(
                                                          context,
                                                          paymentController,
                                                          "Zip",
                                                          paymentController
                                                              .zipController,
                                                          15,
                                                          paymentController.zip,
                                                          TextInputType.text,
                                                          10)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: _textField(
                                                          context,
                                                          paymentController,
                                                          "County",
                                                          paymentController
                                                              .countryController,
                                                          20,
                                                          paymentController.country,
                                                          TextInputType.text,
                                                          11)),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text("Contact Details",
                                                  style: AppStyles.NunitoExtrabold
                                                      .copyWith(fontSize: 18)),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: _textField(
                                                          context,
                                                          paymentController,
                                                          "Country Code",
                                                          paymentController
                                                              .countryCodeController,
                                                          2,
                                                          paymentController.countryCode,
                                                          TextInputType.text,
                                                          12)),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                      child: _textField(
                                                          context,
                                                          paymentController,
                                                          "Mobile Number",
                                                          paymentController
                                                              .mobileController,
                                                          10,
                                                          paymentController.mobilePhone,
                                                          TextInputType.text,
                                                          13)),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: Align(
                                            alignment: Alignment.bottomCenter,
                                            child: SizedBox(
                                              width: MediaQuery.of(context).size.width,
                                              child: ElevatedButton(
                                                onPressed: () async {

                                                  paymentController.billingAddress = "${paymentController.address1Txt.toString()}\n${paymentController.address2Txt.toString()}, ${paymentController.cityTxt.toString()}, ${paymentController.stateTxt.toString()}\n${paymentController.zipTxt.toString()},${paymentController.countryTxt.toString()}";
                                                  paymentController.contactDetails = "+${paymentController.countryCodeTxt.toString()} ${paymentController.mobilePhoneTxt.toString()}";
                                                  paymentController.update();
                                                  Get.back();
                                                },
                                                child: const Text("Submit"),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                            },
                            child: Icon(Icons.edit,color: Colors.black,size: 20,))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(paymentController.billingAddress.toString(),
                        style: AppStyles.NunitoRegular
                            .copyWith(fontSize: 15)),
                  ), const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text("Contact Details",
                        style: AppStyles.NunitoExtrabold
                            .copyWith(fontSize: 18)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(paymentController.contactDetails.toString(),
                        style: AppStyles.NunitoRegular
                            .copyWith(fontSize: 15)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        onPressed: () async {
                          print("address1Txt : ${paymentController.address1Txt.toString()}");
                          print("address2 : ${paymentController.address2Txt.toString()}");
                          print("cityTxt : ${paymentController.cityTxt.toString()}");
                          print("stateTxt : ${paymentController.stateTxt.toString()}");
                          print("zipTxt : ${paymentController.zipTxt.toString()}");
                          print("countryTxt : ${paymentController.countryTxt.toString()}");
                          print("countryCodeTxt : ${paymentController.countryCodeTxt.toString()}");
                          print("mobilePhoneTxt : ${paymentController.mobilePhoneTxt.toString()}");
                          Map<String, dynamic> getToken = {
                            "type": "card",
                            "number": paymentController.cardNumberTxt.toString(),
                            "expiry_month": paymentController.mothTxt.toString(),
                            "expiry_year": "20${paymentController.yearTxt.toString()}",
                            "name": paymentController.holderNameTxt.toString(),
                            "cvv": paymentController.cvvTxt.toString(),
                            "billing_address": {
                              "address_line1": paymentController.address1Txt.toString(),
                              "address_line2": paymentController.address2Txt.toString(),
                              "city": paymentController.cityTxt.toString(),
                              "state": paymentController.stateTxt.toString(),
                              "zip": paymentController.zipTxt.toString(),
                              "country": "KW"
                            },
                            "phone": {
                              "country_code": "+${paymentController.countryCodeTxt.toString()}",
                              "number": paymentController.mobilePhoneTxt.toString()
                            }
                          };
                          PaymentTokenModel? paymentTokenModel = await paymentController.getToken(getToken);
                          if (paymentTokenModel!=null) {
                            print("Success Token");
                            print("token : ${paymentTokenModel.token}");
                            Map<String, dynamic> getPayment = {
                              "source": {
                                "type": "token",
                                "token": paymentTokenModel.token.toString()
                              },
                              "amount": feeAmt,
                              "currency": "KWD",
                              "processing_channel_id": "pc_q7urunzjdjiulh5qpu2lpiucle",
                              "reference": "get started guide",
                              "description": "Set of 3 masks",
                              "capture": true,
                              "customer": {
                                "email": paymentController.profileModel?.profileData?.fatherDetail?.email,
                                "name": paymentController.profileModel?.profileData?.fatherDetail?.name,
                                "phone": {
                                  "country_code": "+${paymentController.countryCodeTxt.toString()}",
                                  "number": paymentController.mobilePhoneTxt.toString()
                                }
                              },
                              "shipping": {
                                "address": {
                                  "address_line1": paymentController.address1Txt.toString(),
                                  "address_line2": paymentController.address2Txt.toString(),
                                  "city": paymentController.cityTxt.toString(),
                                  "state": paymentController.stateTxt.toString(),
                                  "zip": paymentController.zipTxt.toString(),
                                  "country": "KW"
                                },
                                "phone": {
                                  "country_code": "+${paymentController.countryCodeTxt.toString()}",
                                  "number": paymentController.mobilePhoneTxt.toString()
                                }
                              }
                            };
                            int? result = await paymentController.getPayment(getPayment);
                            if(result==201){
                              print("Payment Success");
                              //showStaffToastMsg("Payment Success");
                            }else{
                            //  showStaffToastMsg("${paymentController.paymentErrorModel?.errorCodes?[0]}");
                            }
                          }else {
                            print("fail Token");
                            // print("$code Fail");
                            /*if(paymentTokenModel!=null&&paymentTokenModel!.errorCodes!=null){
                            for(int i=0;i<paymentTokenModel!.errorCodes!.length;i++){
                              print(paymentTokenModel.errorCodes![i].toString());
                            }
                          }*/


                          }
                        },
                        child: const Text("Pay"),
                      ),
                    ),
                  ),
                ],
              ):SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }));
  }

  Widget _textField(
      BuildContext context,
      PaymentController paymentController,
      String label,
      TextEditingController controller,
      int maxLength,
      FocusNode focusNode,
      TextInputType inputType,
      int type) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width, //* 0.55
      child: SMSInputText(
          hintText: "Card number",
          maxLength: maxLength,
          keyboardType: inputType,
          focusNode: focusNode,
          textCapitalization: TextCapitalization.characters,
          controller: controller,
          prefixIcon: const Icon(
            Icons.person,
            color: AppColors.greyColor,
          ),
          onChanged: (val) {
            if (type == 1) {
              paymentController.holderNameTxt = val;
            } else if (type == 2) {
              paymentController.cardNumberTxt = val;
            } else if (type == 3) {
              paymentController.mothTxt = val;
            } else if (type == 4) {
              paymentController.yearTxt = val;
            } else if (type == 5) {
              paymentController.cvvTxt = val;
            } else if (type == 6) {
              paymentController.address1Txt = val;
            } else if (type == 7) {
              paymentController.address2Txt = val;
            } else if (type == 8) {
              paymentController.cityTxt = val;
            } else if (type == 9) {
              paymentController.stateTxt = val;
            } else if (type == 10) {
              paymentController.zipTxt = val;
            } else if (type == 11) {
              paymentController.countryTxt = val;
            } else if (type == 12) {
              paymentController.countryCodeTxt = val;
            } else if (type == 13) {
              paymentController.mobilePhoneTxt = val;
            }
            paymentController.update();
          },
          validator: (userName) {
            if (userName == null || userName.isEmpty) {
              return Constants.login_key7;
            }
            return null;
          },
          lableText: label,
          lablestyle: arimoRegularTextStyle(
              fontSize: 14,
              color: focusNode.hasFocus
                  ? AppColors.darkPinkColor
                  : AppColors.greyColor)),
    );
  }
}

