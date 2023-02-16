import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/apihelper/api_helper.dart';

import '../../../common/widgets/staff_common_widgets.dart';
import '../../model/KnetPaymentResponceModel.dart';
import '../../model/PaymentTokenModel.dart';
import '../../model/fee_model.dart';
import '../../../../common/services/base_client.dart';
import '../../../storage.dart';
import '../../model/payment_error_model.dart';
import '../../model/profile_model.dart';
import '../../view/dialogs/dialog_helper.dart';

class PaymentController extends GetxController {

  FocusNode cardNumber = FocusNode();
  FocusNode month = FocusNode();
  FocusNode year = FocusNode();
  FocusNode cvv = FocusNode();
  FocusNode name = FocusNode();

  FocusNode address1 = FocusNode();
  FocusNode address2 = FocusNode();
  FocusNode city = FocusNode();
  FocusNode state = FocusNode();
  FocusNode zip = FocusNode();
  FocusNode country = FocusNode();
  FocusNode countryCode = FocusNode();
  FocusNode mobilePhone = FocusNode();

  TextEditingController cardNumberController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  String? holderNameTxt = "CARD HOLDER";
  String? cardNumberTxt = "";
  String? mothTxt = "";
  String? yearTxt = "";
  String? cvvTxt = "";

  String? address1Txt = "";
  String? address2Txt = "";
  String? cityTxt = "";
  String? stateTxt = "";
  String? zipTxt = "";
  String? countryTxt = "";
  String? countryCodeTxt = "";
  String? mobilePhoneTxt = "";
  String billingAddress = "";
  String? contactDetails = "";
  int? feeAmt;

  PaymentTokenModel? paymentTokenModel;
  KnetPaymentResponceModel? knetPaymentResponceModel;
  ProfileModel? profileModel;

  PaymentErrorModel? paymentErrorModel;

  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<PaymentTokenModel?> getToken(
      Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    int code=0;
    try {
      final result =
      await BaseService().paymentTokenPostWithoutFormData(userData, "https://api.sandbox.checkout.com/tokens");
      if (result != null) {
        code = result.statusCode;
        if (result.statusCode == 201) {
          paymentTokenModel = PaymentTokenModel.fromJson(result.data);
          print("Api Success");
        }else{
          /*paymentTokenModel = PaymentTokenModel(
              errorCodes: result.data["error_codes"],
          );*/
          print("Api fail");
        }

      }
    } catch (e) {
      print('getToken $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return paymentTokenModel;
  }

  Future<int?> getPayment(
      Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    int code=0;
    try {
      final result =
      await BaseService().paymentPostWithoutFormData(userData, "https://api.sandbox.checkout.com/payments");
      if (result != null) {
        code = result.statusCode;
        if (result.statusCode == 201) {
          knetPaymentResponceModel = KnetPaymentResponceModel.fromJson(result.data);
          print("Api Success");
        }else{
          paymentErrorModel= PaymentErrorModel.fromJson(result.data);
          List<String> errorCode= paymentErrorModel?.errorCodes ?? [];
        print("error code ${errorCode[0]}");
          /* paymentTokenModel = KnetPaymentResponceModel(
            errorCodes: result.data["error_codes"],
          );*/
          print("Api fail");
        }

      }
    } catch (e) {
      print('getToken $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return code;
  }

  Future getProfile() async {
    try {
      final result = await BaseService().getMethod(ApiHelper.profileUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          profileModel = ProfileModel.fromJson(result.data);





          if(profileModel?.profileData?.fatherDetail?.phoneNo!=null){
            mobilePhoneTxt = profileModel?.profileData?.fatherDetail?.phoneNo.toString();
            mobileController.text = mobilePhoneTxt.toString();
            contactDetails = profileModel?.profileData?.fatherDetail?.phoneNo.toString();
          }




          if(profileModel?.profileData?.address.toString()!=null){
            address1Txt = profileModel?.profileData?.address.toString()??"";
            address1Controller.text = address1Txt.toString();
            billingAddress += "${profileModel!.profileData!.address.toString()}\n";
          }
          if(profileModel?.profileData?.city!=null){
            cityTxt = profileModel?.profileData?.city.toString()??"";
            cityController.text = cityTxt.toString();
            billingAddress += "${profileModel!.profileData!.city.toString()}, ";
          }
          if(profileModel?.profileData?.pincode!=null){
            zipTxt = profileModel?.profileData?.pincode.toString()??"";
            zipController.text = zipTxt.toString();
            billingAddress += profileModel!.profileData!.pincode.toString();
          }

          //billingAddress = "${profileModel?.profileData?.address.toString()??""}\n${profileModel?.profileData?.city.toString()??""},${profileModel?.profileData?.pincode.toString()??""}";
        }
      }
    } catch (e) {
      print('Profile Screen $e');
    } finally {}
    update();
  }

}
