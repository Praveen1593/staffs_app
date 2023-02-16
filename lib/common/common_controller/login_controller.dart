import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../parent/model/login_model.dart';
import '../../parent/view/dialogs/dialog_helper.dart';
import '../../storage.dart';
import '../apihelper/api_helper.dart';
import '../services/base_client.dart';

class LoginController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool visiblePassword = false;
  LoginModel? loginModel;
  FocusNode userName = FocusNode();
  FocusNode password = FocusNode();
  int type = 1;
  bool isHidden = false;
  AnimationController? lottieController;
  @override
  void onInit() {
    super.onInit();
    LocalStorage.setValue("type", 1);
    LocalStorage.setValue("url", "https://demoschool.campuseasy.net/api/parent/v2/");//https://test.schoolec.in/api/parent/v2/
    lottieController = AnimationController(
      vsync: this,
    );
    userNameController.text = "";
    passwordController.text = "";
  }

  void togglePasswordView() {
    visiblePassword = !visiblePassword;
    update();
  }

  @override
  void dispose() {
    lottieController?.dispose();
    super.dispose();
  }



  void updateEnvironmentType(int value) {
    type = value;
    if (type == 1) {
      LocalStorage.setValue("type", 1);
      LocalStorage.setValue("url", "https://demoschool.campuseasy.net/api/parent/v2/");//https://test.schoolec.in/api/parent/v2/
    } else if (type == 2) {
      LocalStorage.setValue("type", 2);
      LocalStorage.setValue("url", "https://demoschool.campuseasy.net/api/staff/v2/");//https://test.schoolec.in/api/staff/v2/"//https://demoschool.campuseasy.net/api/staff/v2/
    } else {
      LocalStorage.setValue("type", 3);
      LocalStorage.setValue("url", "https://demoschool.campuseasy.net/api/admin/v2/");//https://test.schoolec.in/api/admin/v2/
    }
    update();
  }

  Future<LoginModel?> loginAuthentication(Map<String, dynamic> userData) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService()
          .loginPostMethod(userData, ApiHelper.loginUrl);
      if (result != null) {
        if (result.statusCode == 200) {
          loginModel = LoginModel.fromJson(result.data);
          LocalStorage.setValue('login', true);
          LocalStorage.setValue('token', loginModel?.loginData?.token ?? "");
          LocalStorage.setValue("studentId", loginModel?.loginData?.studentId);
          LocalStorage.setValue("code", loginModel?.loginData?.code);
          LocalStorage.setValue("username", loginModel?.loginData?.username);
          LocalStorage.setValue("phoneNumber", loginModel?.loginData?.phone);
          LocalStorage.setValue(
              "verification_token", loginModel?.loginData?.uuid);
          LocalStorage.setValue("photo", loginModel?.loginData?.photo);
          LocalStorage.setValue("studentPhoto", loginModel?.loginData?.studentPhoto);

          print(
              "studentId ${loginModel?.loginData?.studentId} ${loginModel?.loginData?.token}");
        } else {
          loginModel = LoginModel(
              status: "Failed",
              code: 400,
              message: result.data.containsKey("message")
                  ? result.data["message"]
                  : "");
        }
      }
    } catch (e) {
      print('Login Screen $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
    return loginModel;
  }
}
