import 'package:flutter/material.dart';
import 'package:flutter_projects/parent/themes/app_styles.dart';
import 'package:get/get.dart';
import '../../../parent/model/login_model.dart';
import '../../../parent/view/dialogs/dialog_helper.dart';
import '../../../parent/view/screens/Home/home_screen.dart';
import '../../../staff/view/screens/staff_home/staff_home_screen.dart';
import '../../../storage.dart';
import '../../common_controller/login_controller.dart';
import '../../const/colors.dart';
import '../../const/contsants.dart';
import '../../const/image_constants.dart';
import '../../widgets/common_widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: _buildBodyNew(context),
      ),
    );
  }

  Widget _buildBodyNew(BuildContext context){

    int? parentVal;
    int? staffVal;
    Color selectStaffColor1 = Color(0XFFDEE2E6);
    Color selectStaffColor2 = Color(0XFFDEE2E6);
    Color selectStaffTextColor1 = Color(0XFF263238);
    Color selectStaffTextColor2 = Color(0XFF263238);

    Color selectParentColor1 = Color(0XFFDEE2E6);
    Color selectParentColor2 = Color(0XFFDEE2E6);
    Color selectParentTextColor1 = Color(0XFF263238);
    Color selectParentTextColor2 = Color(0XFF263238);

    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginController) {
          if(loginController.type==1){
            selectParentColor1 = Color(0xFF525CFF);
            selectParentColor2 = Color(0xFF8FC4FF);
            selectStaffColor1 = Color(0XFFDEE2E6);
            selectStaffColor2 = Color(0XFFDEE2E6);

            selectParentTextColor1 = Color(0xFF525CFF);
            selectParentTextColor2 = Color(0xFF8FC4FF);
            selectStaffTextColor1 = Color(0XFF263238);
            selectStaffTextColor2 = Color(0XFF263238);

          }else if(loginController.type==2){
            selectStaffColor1 = Color(0xFF525CFF);
            selectStaffColor2 = Color(0xFF8FC4FF);
            selectParentColor1 = Color(0XFFDEE2E6);
            selectParentColor2 = Color(0XFFDEE2E6);

            selectParentTextColor1 = Color(0XFF263238);
            selectParentTextColor2 = Color(0XFF263238);
            selectStaffTextColor1 = Color(0xFF525CFF);
            selectStaffTextColor2 = Color(0xFF525CFF);


          }
          return  SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 400,
                  child: Stack(
                    children: [
                      SMSImageAsset(
                        image: ImageConstants.campuseasyLoginBG,
                        boxfit: BoxFit.fill,
                        height: 380,
                        width: MediaQuery.of(Get.context!).size.width,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 80,top: 20),
                        child: SMSImageAsset(
                          image: ImageConstants.campuseasyLoginBoy,
                          boxfit: BoxFit.fill,
                          width: 230,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Text("Welcome to CAMPUSEASY",style: AppStyles.MontserratBold.copyWith(
                              color: const Color(0XD9343A40), fontSize: 21,fontWeight: FontWeight.w600),),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: InkWell(
                                onTap:(){
                                  staffVal=2;
                                  loginController.userNameController.text = "";
                                  loginController.passwordController.text = "";
                                  loginController.updateEnvironmentType(staffVal!);
                                  if(loginController.type==2){
                                    selectStaffColor1 = Color(0xFF525CFF);
                                    selectStaffColor2 = Color(0xFF8FC4FF);
                                    selectParentColor1 = Color(0XFFDEE2E6);
                                    selectParentColor2 = Color(0XFFDEE2E6);

                                    selectParentTextColor1 = Color(0XFF263238);
                                    selectParentTextColor2 = Color(0XFF263238);
                                    selectStaffTextColor1 = Color(0xFF525CFF);
                                    selectStaffTextColor2 = Color(0xFF525CFF);
                                  }
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      GradientText("Staff",style: AppStyles.NunitoExtrabold.copyWith(fontSize: 19,fontWeight: FontWeight.w500), gradient: LinearGradient(
                                        colors: <Color>[
                                          selectStaffTextColor1,
                                          selectStaffTextColor2,
                                        ],
                                      )),
                                      const SizedBox(height: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                selectStaffColor1,
                                                selectStaffColor2,
                                              ],
                                            )
//color: loginController.type==1?const Color(0XFF8FC4FF):const Color(0xFF565656),
                                        ),
// color: loginController.type==2?const Color(0xFFED893E):const Color(0xFF565656),
                                        width: MediaQuery.of(context).size.width,
                                        height: 5,
                                      )
                                    ],
                                  ),//
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.white,
                              child: InkWell(
                                onTap: (){
                                  parentVal=1;
                                  loginController.userNameController.text = "";
                                  loginController.passwordController.text = "";
                                  loginController.updateEnvironmentType(parentVal!);
                                  if(loginController.type==1){
                                    selectParentColor1 = Color(0xFF525CFF);
                                    selectParentColor2 = Color(0xFF8FC4FF);
                                    selectStaffColor1 = Color(0XFFDEE2E6);
                                    selectStaffColor2 = Color(0XFFDEE2E6);

                                    selectParentTextColor1 = Color(0xFF525CFF);
                                    selectParentTextColor2 = Color(0xFF8FC4FF);
                                    selectStaffTextColor1 = Color(0XFF263238);
                                    selectStaffTextColor2 = Color(0XFF263238);
                                  }
                                },
                                child: Center(
                                  child: Column(
                                    children: [
                                      GradientText("Parent",style: AppStyles.NunitoExtrabold.copyWith(fontSize: 19,fontWeight: FontWeight.w500), gradient: LinearGradient(
                                        colors: <Color>[
                                          selectParentTextColor1,
                                          selectParentTextColor2,
                                        ],
                                      )),
                                      const SizedBox(height: 10,),
                                      Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: <Color>[
                                                selectParentColor1,
                                                selectParentColor2,
                                              ],
                                            )
//color: loginController.type==1?const Color(0XFF8FC4FF):const Color(0xFF565656),
                                        ),

                                        width: MediaQuery.of(context).size.width,
                                        height: 5,
                                      )
                                    ],
                                  ),

                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      Text(loginController.type==1?"PARENT LOGIN":"STAFF LOGIN",style: AppStyles.NunitoExtrabold.copyWith(
                          color: const Color(0XD9343A40), fontSize: 15),),
                      const SizedBox(height: 30,),
                      Form(
                        key: globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Username",style: AppStyles.NunitoRegular.copyWith(
                                color: const Color(0XFF343A40), fontSize: 14),),
                            const SizedBox(height: 10,),
                            Container(
                              height: 45,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(color: const Color(0XFF525CFF),width: 0.5),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  onChanged: (val) {
                                  },
                                  focusNode: loginController.userName,
                                  textCapitalization: TextCapitalization.characters,
                                  controller: loginController.userNameController,
                                  decoration: const InputDecoration(
                                    hintText: "Enter your username",
                                    border: InputBorder.none,
                                    errorStyle: TextStyle(height: 0),
                                    hintStyle:  TextStyle(fontSize: 13.0, color: const Color(0XFF253238),fontWeight: FontWeight.w300),
                                  ),
                                  validator: (userName) {
                                    if (userName == null || userName.isEmpty) {
                                      return Constants.login_key7;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      color: AppColors.blackColor, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20,),
                            Text("Password",style: AppStyles.NunitoRegular.copyWith(
                                color: const Color(0XFF343A40), fontSize: 14),),
                            const SizedBox(height: 10,),
                            Container(
                              height: 50,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: const Color(0XFF525CFF),width: 0.5)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: TextFormField(
                                  onChanged: (val) {
                                  },
                                  focusNode: loginController.password,
                                  textCapitalization: TextCapitalization.characters,
                                  controller: loginController.passwordController,
                                  obscureText: loginController.isHidden?false:true,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter your password",
                                    suffixIcon: InkWell(
                                      onTap: (){
                                        loginController.isHidden = !loginController.isHidden;
                                        loginController.update();
                                      },
                                      child: Icon(
                                        loginController.isHidden?Icons.visibility_off:Icons.visibility,color: const Color(0xFF9ca1a9),
                                      ),
                                    ),
                                    errorStyle: TextStyle(height: 0),
                                    hintStyle: TextStyle(fontSize: 13.0, color: const Color(0XFF253238),fontWeight: FontWeight.w300),
                                  ),
                                  validator: (password) {
                                    if (password == null || password.isEmpty) {
                                      return Constants.login_key8;
                                    } else if (password.length < 6) {
                                      return Constants.login_key9;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  style: AppStyles.NunitoExtrabold.copyWith(
                                      color: AppColors.blackColor, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            InkWell(
                              onTap: ()async{
                                if (!globalKey.currentState!.validate()) {
                                  Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                  //showToastMsg(Constants.login_key6);
                                } else {
                                  Map<String, dynamic> mapData = {
                                    "code":
                                    loginController.userNameController.text.trim(),
                                    "password": loginController.passwordController.text
                                  };
                                  LoginModel? loginModel =
                                  await loginController.loginAuthentication(mapData);
                                  if (loginModel != null && loginModel.code == 200) {
                                    Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);

                                   // showToastMsg(loginModel.loginData?.message ?? "");
                                    if(LocalStorage.getValue("type")==1){
                                      Get.offAll(HomeScreen());
                                    }else if(LocalStorage.getValue("type")==2){
                                      Get.offAll(StaffHomeScreen());
                                    }
                                  } else {
                                    Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                   // showToastMsg(loginModel?.message ?? "");
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient: LinearGradient(
                                      colors: <Color>[
                                        Color(0XFF525CFF),
                                        Color(0XFF8FC4FF),
                                      ],
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text("Sign in",style: AppStyles.NunitoRegular.copyWith(
                                              color: AppColors.whiteColor, fontSize: 18,fontWeight: FontWeight.w600),),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 20),
                                        child: SMSImageAsset(
                                          image: ImageConstants.campuseasyLoginArrow,
                                          height: 20,
                                          width: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15,)
                          ],
                        ),
                      )
                    ],
                  ),
                )

              ],
            ),
          );
        }
    );




  }

  Widget _buildBody1(BuildContext context){

    int? parentVal;
    int? staffVal;
    int? adminVal;

    return GetBuilder<LoginController>(
        init: LoginController(),
        builder: (loginController) {
          return SafeArea(
            child: Container(
              decoration:  const BoxDecoration(
                  gradient: LinearGradient(
                    colors: <Color>[AppColors.indigo1Color, AppColors.indigo2Color],
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: SingleChildScrollView(
                      child: Center(
                        child: Column(
                          children: [
                            _smsIcon(),
                            /* Lottie.asset(ImageConstants.loginLottie,
                            width: Get.width * 0.5,
                            repeat: true,
                            controller: loginController.lottieController,
                            onLoaded: (composition) {
                              loginController.lottieController
                                ..duration = composition.duration
                                ..forward();
                              loginController.lottieController.repeat();
                            }),*/
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const SizedBox(height: 30,),
                  Expanded(
                    flex: 3,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration:  const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))

                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: globalKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Text(Constants.login_key1,
                                      style: nunitoExtraBoldTextStyle(fontSize: 30, color: Colors.black87)),
                                ),
                                const SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          color: loginController.type==1?AppColors.darkPinkColor.withAlpha(50):AppColors.whiteColor,
                                          child: Row(
                                            children: [
                                              Radio(value: 1, groupValue: loginController.type, onChanged: (value){
                                                parentVal = value;
                                                loginController.userNameController.text = "";
                                                loginController.passwordController.text = "";
                                                loginController.updateEnvironmentType(parentVal!);
                                              }),
                                              InkWell(
                                                onTap: (){
                                                  parentVal=1;
                                                  loginController.userNameController.text = "";
                                                  loginController.passwordController.text = "";
                                                  loginController.updateEnvironmentType(parentVal!);
                                                },
                                                child: Text("Parent",
                                                    style: nunitoRegularTextStyle(fontSize: 15, color: Colors.black87)),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          parentVal=1;
                                          loginController.userNameController.text = "";
                                          loginController.passwordController.text = "";
                                          loginController.updateEnvironmentType(parentVal!);
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: InkWell(
                                        child: Container(
                                          color: loginController.type==2?AppColors.darkPinkColor.withAlpha(50):AppColors.whiteColor,
                                          child: Row(
                                            children: [
                                              Radio(value: 2, groupValue: loginController.type, onChanged: (value){
                                                staffVal = value;
                                                loginController.userNameController.text = "";
                                                loginController.passwordController.text = "";
                                                loginController.updateEnvironmentType(staffVal!);
                                              }),
                                              InkWell(
                                                onTap: (){
                                                  staffVal=2;
                                                  loginController.userNameController.text = "";
                                                  loginController.passwordController.text = "";
                                                  loginController.updateEnvironmentType(staffVal!);
                                                },
                                                child: Text("Staff",
                                                    style: nunitoRegularTextStyle(fontSize: 15, color: Colors.black87)),
                                              )
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          staffVal=2;
                                          loginController.userNameController.text = "";
                                          loginController.passwordController.text = "";
                                          loginController.updateEnvironmentType(staffVal!);
                                        },
                                      ),
                                    ),
                                    /* Expanded(
                                    child: Row(
                                      children: [
                                        Radio(value: 3, groupValue: loginController.type, onChanged: (value){
                                          loginController.updateEnvironmentType(value!);
                                        }),
                                        Expanded(child: Text("Admin",
                                            style: nunitoRegularTextStyle(fontSize: 15, color: Colors.black87)))
                                      ],
                                    ),
                                  )*/
                                  ],
                                ),
                                const SizedBox(height: 20,),
                                _userNameTextField(context, loginController),
                                const Padding(
                                  padding: EdgeInsets.only(left: 50,right: 5),
                                  child: Divider(height: 3,color: AppColors.darkPinkColor,),
                                ),
                                const SizedBox(height: 20,),
                                _pwdTextField(context, loginController),
                                const SizedBox(height: 20,),
                                SMSButtonWidget(
                                  onPress: () async {
                                    if (!globalKey.currentState!.validate()) {
                                      Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                      //showToastMsg(Constants.login_key6);
                                    } else {
                                      Map<String, dynamic> mapData = {
                                        "code":
                                        loginController.userNameController.text.trim(),
                                        "password": loginController.passwordController.text
                                      };
                                      LoginModel? loginModel =
                                      await loginController.loginAuthentication(mapData);
                                      if (loginModel != null && loginModel.code == 200) {
                                        Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                       // showToastMsg(loginModel.loginData?.message ?? "");
                                        if(LocalStorage.getValue("type")==1){
                                          Get.offAll(HomeScreen());
                                        }else if(LocalStorage.getValue("type")==2){
                                          Get.offAll(StaffHomeScreen());
                                        }else{

                                        }

                                      } else {
                                        Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                                       // showToastMsg(loginModel?.message ?? "");
                                      }
                                    }
                                  },
                                  text: Constants.login_key5,
                                  primaryColor: AppColors.darkPinkColor,
                                  onPrimaryColor: AppColors.whiteColor,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  borderRadius: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],

              ),
            ),
          );
        }
    );




  }

  Widget _buildBody(BuildContext context) {
    return GetBuilder<LoginController>(
      init: LoginController(),
      builder: (loginController) => Stack(
        children: [
          _loinBg(),
          _smsIcon(),
          Padding(
            padding: const EdgeInsets.only(left: 24.0, top: 0),
            child: Form(
              key: globalKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _loginText(),
                  _userNameTextField(context, loginController),
                  _pwdTextField(context, loginController),
                  // _forgetPasswordText(),
                  SMSButtonWidget(
                    onPress: () async {
                      if (!globalKey.currentState!.validate()) {
                        Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                        //showToastMsg(Constants.login_key6);
                      } else {
                        Map<String, dynamic> mapData = {
                          "code":
                          loginController.userNameController.text.trim(),
                          "password": loginController.passwordController.text
                        };
                        LoginModel? loginModel =
                        await loginController.loginAuthentication(mapData);
                        if (loginModel != null && loginModel.code == 200) {
                          Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                        //  showToastMsg(loginModel.loginData?.message ?? "");
                          if (LocalStorage.getValue("type") == 1) {
                            Get.offAll(HomeScreen());
                          } else if (LocalStorage.getValue("type") == 2) {
                            Get.offAll(StaffHomeScreen());
                          } else {}
                        } else {
                          Get.snackbar("", Constants.login_key6, snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
                         // showToastMsg(loginModel?.message ?? "");
                        }
                      }
                    },
                    text: Constants.login_key5,
                    primaryColor: AppColors.darkPinkColor,
                    onPrimaryColor: AppColors.whiteColor,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 45,
                    borderRadius: 32,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _loinBg() {
    return const SMSImageAsset(
      image: ImageConstants.loginBgImg,
      boxfit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
    );
  }

  Widget _smsIcon() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 40),
      child: SMSImageAsset(
        image: ImageConstants.smsBandSplashImg,
        boxfit: BoxFit.cover,
        height: MediaQuery.of(Get.context!).size.height * 0.15,
        width: MediaQuery.of(Get.context!).size.width * 0.4,
      ),
    );
  }

  Widget _loginText() {
    return Text(Constants.login_key1,
        style: arimoBoldTextStyle(fontSize: 16, color: AppColors.blackColor));
  }

  Widget _userNameTextField(
      BuildContext context, LoginController loginController) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,//* 0.55
      child: SMSInputText(
          hintText: Constants.login_key1,
          focusNode: loginController.userName,
          textCapitalization: TextCapitalization.characters,
          controller: loginController.userNameController,
          prefixIcon: const Icon(
            Icons.person,
            color: AppColors.greyColor,
          ),
          onChanged: (val) {},
          validator: (userName) {
            if (userName == null || userName.isEmpty) {
              return Constants.login_key7;
            }
            return null;
          },
          lableText: Constants.login_key2,
          lablestyle: arimoRegularTextStyle(
              fontSize: 14,
              color: loginController.userName.hasFocus
                  ? AppColors.darkPinkColor
                  : AppColors.greyColor)),
    );
  }

  Widget _pwdTextField(BuildContext context, LoginController loginController) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      width: MediaQuery.of(context).size.width,//* 0.55
      child: SMSInputText(
        obscureText: !loginController.visiblePassword,
        hintText: Constants.login_key3,
        focusNode: loginController.password,
        textInputAction: TextInputAction.done,
        keyboardType: TextInputType.visiblePassword,
        prefixIcon: const Icon(
          Icons.lock,
          color: AppColors.greyColor,
        ),
        controller: loginController.passwordController,
        onChanged: (val) {},
        validator: (password) {
          if (password == null || password.isEmpty) {
            return Constants.login_key8;
          } else if (password.length < 6) {
            return Constants.login_key9;
          }
          return null;
        },
        suffixIcon: InkWell(
          onTap: () {
            loginController.togglePasswordView();
          },
          child: Icon(
            loginController.visiblePassword
                ? Icons.visibility_off
                : Icons.visibility,
            color: AppColors.greyColor,
          ),
        ),
        lableText: Constants.login_key3,
        lablestyle: arimoRegularTextStyle(
            fontSize: 14,
            color: loginController.userName.hasFocus
                ? AppColors.darkPinkColor
                : AppColors.greyColor),
      ),
    );
  }

  Widget _forgetPasswordText() {
    return Text(
      Constants.login_key4,
      style: arimoBoldTextStyle(
          fontSize: 14, color: AppColors.darkPinkColor, letterSpacing: 1.5),
    ).paddingOnly(left: 8, right: 8, top: 8, bottom: 20);
  }
}

class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}
