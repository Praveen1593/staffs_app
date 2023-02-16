import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'change_password__form_field_screen.dart';
import 'package:get/get.dart';
import '../../../../common/const/colors.dart';
import '../../../../common/widgets/common_widgets.dart';
import '../../../../common/widgets/staff_common_widgets.dart';
import '../../../../parent/themes/app_styles.dart';
import '../../../controller/staff_profile_contrller/staff_profile_controller.dart';
import '../custom_dropdown.dart';

class StaffProfileScreen extends StatelessWidget {
  StaffProfileScreen({Key? key}) : super(key: key);
  var width = Get.width;
  var height = Get.height;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<StaffProfileController>(
        init: StaffProfileController(),
        builder: (profileController) {
          return Scaffold(
            appBar: smsAppbar("Profile"),
            body: profileController.isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : _buildBody(profileController, context),
            floatingActionButton: profileController.isFAB
                ? buildFAB()
                : buildExtendedFAB(profileController),
          );
        });
  }

  Widget buildExtendedFAB(StaffProfileController profileController) =>
      AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        height: 50,
        width: Get.width * 0.5,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.darkPinkColor,
          onPressed: () {
            showModalBottomSheet(
                context: Get.context!,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => changePasswordWidget(profileController));
          },
          icon: const Icon(
            Icons.lock,
            size: 18,
          ),
          label: const Center(
            child: Text(
              "CHANGE PASSWORD",
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ),
      );

  Widget changePasswordWidget(StaffProfileController profileController) {
    return DraggableScrollableSheet(
      initialChildSize: .5,
      minChildSize: .1,
      maxChildSize: .7,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          color: Colors.grey[300],
          child: Form(
            key: profileController.key,
            child: ListView(
              controller: scrollController,
              children: [
                Text(
                  "Change Password",
                  style: AppStyles.NunitoExtrabold.copyWith(fontSize: 17),
                ).paddingOnly(top: 5, bottom: 5),
                Text(
                  "Set the Change password for your account so you can login and access all the features",
                  style: AppStyles.NunitoRegular.copyWith(fontSize: 15),
                ).paddingOnly(top: 5, bottom: 15),
                Text(
                  "Current Password",
                  style: AppStyles.arimBold.copyWith(fontSize: 15),
                ).paddingOnly(bottom: 10),
                ChangePasswordTextInput(
                  controller: profileController.currentPasswordController,
                  onChanged: (newValue) {},
                  suffixIcon: InkWell(
                    onTap: () {
                      profileController.toggleCurrentPasswordView();
                    },
                    child: Icon(
                      profileController.visibleCurrentPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.greyColor,
                    ),
                  ),
                  lablestyle: const TextStyle(
                      color: AppColors.blackColor, fontSize: 14),
                ).paddingOnly(bottom: 10),
                Text(
                  "New Password",
                  style: AppStyles.arimBold.copyWith(fontSize: 15),
                ).paddingOnly(bottom: 10, top: 10),
                ChangePasswordTextInput(
                  controller: profileController.newPasswordController,
                  onChanged: (newValue) {},
                  suffixIcon: InkWell(
                    onTap: () {
                      profileController.toggleNewPasswordView();
                    },
                    child: Icon(
                      profileController.visibleNewPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.greyColor,
                    ),
                  ),
                  lablestyle: const TextStyle(
                      color: AppColors.blackColor, fontSize: 14),
                ).paddingOnly(bottom: 10),
                Text(
                  "Confirm Password",
                  style: AppStyles.arimBold.copyWith(fontSize: 15),
                ).paddingOnly(bottom: 10, top: 10),
                ChangePasswordTextInput(
                  controller: profileController.confirmPasswordController,
                  onChanged: (newValue) {},
                  suffixIcon: InkWell(
                    onTap: () {
                      profileController.togglePasswordView();
                    },
                    child: Icon(
                      profileController.visiblePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: AppColors.greyColor,
                    ),
                  ),
                  lablestyle: const TextStyle(
                      color: AppColors.blackColor, fontSize: 14),
                ).paddingOnly(bottom: 10),
                Container(
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: const LinearGradient(colors: [
                        AppColors.indigo1Color,
                        AppColors.indigo2Color,
                        //add more colors
                      ]),
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (profileController.key.currentState!.validate()) {
                          if (profileController.newPasswordController.text ==
                              profileController
                                  .confirmPasswordController.text) {
                            Map<String, dynamic> sendData = {
                              "current_password": profileController
                                  .currentPasswordController.text,
                              "new_password":
                                  profileController.newPasswordController.text
                            };
                            await profileController.changePassword(sendData);
                            if (profileController.changePasswordModel?.code ==
                                200) {
                              // showStaffToastMsg(profileController
                              //         .changePasswordModel?.messages ??
                              //     "");
                              Get.back();
                            } else {
                              // showStaffToastMsg(profileController
                              //         .changePasswordModel?.error ??
                              //     "");
                            }
                          } else {
                         //   showStaffToastMsg("confirm password doesn't match");
                          }
                        } else {
                          // showStaffToastMsg("All fields are required");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        foregroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                      ),
                      child: Text("CHANGE PASSWORD",
                          style: AppStyles.arimBold.copyWith(
                              fontSize: 15,
                              color: Colors.white,
                              letterSpacing: 1)),
                    )).paddingOnly(bottom: 10, top: 15)
              ],
            ).paddingAll(20),
          ),
        );
      },
    );
  }

  Widget buildFAB() => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
        width: 50,
        height: 50,
        child: FloatingActionButton.extended(
          backgroundColor: AppColors.darkPinkColor,
          onPressed: () {},
          icon: const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Icon(Icons.lock),
          ),
          label: const SizedBox(),
        ),
      );

  Widget _buildBody(
      StaffProfileController profileController, BuildContext context) {
    return SizedBox(
      height: height,
      child: Stack(
        children: [
          Visibility(
            visible: profileController.isVisibleProfileDetails ? true : false,
            child: SingleChildScrollView(
              controller: profileController.scrollController,
              child: Column(
                children: [
                  _buildSizedBox(10),
                  _profileImage(profileController),
                  _buildSizedBox(10),
                  _usernameAndCodeText(profileController, 18,
                      profileController.profileData?.userName ?? ""),
                  _buildSizedBox(10),
                  _usernameAndCodeText(profileController, 13,
                      profileController.profileData?.code ?? ""),
                  _buildSizedBox(20),
                  _basicDetails(profileController),
                  _addressDetails(profileController)
                ],
              ),
            ),
          ),
          Visibility(
              visible: profileController.isVisibleBasicDetails ? true : false,
              child: editBasicDetails(profileController)),
          Visibility(
            visible: profileController.isVisibleAddressDetails ? true : false,
            child: editAddressDetails(profileController),
          )
        ],
      ),
    );
  }

  Padding _basicDetails(StaffProfileController profileController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black12, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Basic details",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
                  InkWell(
                      onTap: () {
                        profileController.editBasicDetails(true);
                        profileController.fetchProfileDetails();
                        profileController.fetchMaritalStatus();
                        profileController.fetchCountryList();
                      },
                      child: const SMSImageAsset(
                        image: "assets/edit_icons.png",
                        height: 20,
                        width: 20,
                      ))
                ],
              ),
            ),
            _buildSizedBox(10),
            _buildRowWidget(
                "Date of birth",
                profileController.profileData?.dob ?? "",
                "Gender",
                profileController.profileData?.gender ?? ""),
            _buildRowWidget(
                "Mother tongue",
                profileController.profileData?.motherTongue ?? "",
                "Nationality",
                profileController.profileData?.nationality ?? ""),
            _buildRowWidget(
                "Blood Group",
                profileController.profileData?.bloodGroup ?? "",
                "Date of joining",
                profileController.profileData?.doj ?? ""),
            _buildRowWidget(
                "Mobile Number",
                profileController.profileData?.phone ?? "",
                "Email Address",
                profileController.profileData?.email ?? ""),
            _buildRowWidget(
                "Marital Status",
                profileController.profileData?.maritalStatus ?? "",
                "Salary Type",
                profileController.profileData?.salarytype ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _addressDetails(StaffProfileController profileController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: width * 0.9,
        decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: Colors.black12, style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Address",
                      style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18)),
                  InkWell(
                      onTap: () {
                        profileController.editAddressDetails(true);
                        profileController.fetchProfileDetails();
                        profileController.fetchMaritalStatus();
                        profileController.fetchCountryList();
                      },
                      child: const SMSImageAsset(
                        image: "assets/edit_icons.png",
                        height: 20,
                        width: 20,
                      ))
                ],
              ),
            ),
            _buildSizedBox(10),
            _buildRowWidget(
                "Permanent Country",
                profileController.profileData?.permanentAddress?.country ?? "",
                "Permanent state",
                profileController.profileData?.permanentAddress?.state ?? ""),
            _buildRowWidget(
                "Residential Country",
                profileController.profileData?.residentialAddress?.country ??
                    "",
                "Residential state",
                profileController.profileData?.residentialAddress?.state ?? ""),
            _buildAddressText("Permanent Address",
                profileController.profileData?.permanentAddress?.address ?? ""),
            _buildSizedBox(10),
            _buildAddressText(
                "Residential Address",
                profileController.profileData?.residentialAddress?.address ??
                    ""),
            _buildSizedBox(10),
          ],
        ),
      ),
    );
  }

  Widget editBasicDetails(StaffProfileController profileController) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headingText(
                      "Basic details",
                    ),
                    _buildSizedBox(20),
                    Text(
                        "You can change or modify your basic details information at anytime",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 14)),
                    _buildSizedBox(20),
                    _buildText(
                      "Mobile Number",
                    ),
                    TextFormField(
                      controller: profileController.mobileNumberController,
                      maxLength: 10,
                    ),
                    _buildSizedBox(10),
                    _buildText(
                      "Marital Status",
                    ),
                    _buildSizedBox(10),
                    AppDropdownInput(
                      options: profileController.maritalStatusData.isNotEmpty
                          ? profileController.maritalStatusData
                          : [],
                      hintText: profileController.maritalStatus != ""
                          ? profileController.maritalStatus
                          : "Select marital status",
                      onChanged: (value) {
                        print("value in onchange $value");
                        profileController.updateMaritalStatus(value);
                      },
                    ),
                  ]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _cancelButton(profileController),
            _buildSizedBox(20),
            _basicDetailsSubmitButton(profileController, 1)
          ],
        ).paddingOnly(right: 10, bottom: 10)
      ],
    );
  }

  Widget editAddressDetails(StaffProfileController profileController) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _headingText(
                      "Address details",
                    ),
                    _buildSizedBox(20),
                    Text(
                        "You can change or modify your basic details information at anytime",
                        style: AppStyles.NunitoLight.copyWith(fontSize: 14)),
                    _buildSizedBox(20),
                    _buildText(
                      "Current Address",
                    ),
                    _buildSizedBox(10),
                    _addressWidget(profileController.currentAddressController),
                    _buildSizedBox(20),
                    Visibility(
                      visible: profileController.isVisibleCurrentAddress
                          ? false
                          : true,
                      child: SMSButtonWidget(
                        onPress: () {
                          profileController.permanentAddressController.text =
                              profileController.currentAddressController.text;
                          profileController.isVisibleAddress(true);
                        },
                        text: "SAME AS CURRENT ADDRESS",
                        width: width,
                        height: 40,
                        primaryColor: AppColors.darkPinkColor,
                        borderRadius: 5,
                        fontSize: 12,
                      ),
                    ),
                    Visibility(
                      visible: profileController.isVisibleCurrentAddress
                          ? true
                          : false,
                      child: _buildText(
                        "Permanent Address",
                      ),
                    ),
                    _buildSizedBox(10),
                    _addressWidget(
                        profileController.permanentAddressController),
                    _buildSizedBox(20),
                    _buildText(
                      "Permanent Country",
                    ),
                    _buildSizedBox(10),
                    AppDropdownInput(
                      options: profileController.countryList.isNotEmpty
                          ? profileController.countryList
                          : [],
                      hintText: profileController.selectedPermanentCountry != ""
                          ? profileController.selectedPermanentCountry
                          : "Select Country",
                      onChanged: (value) {
                        profileController.updatePermanentCountryList(value);
                      },
                    ),
                    _buildSizedBox(20),
                    _buildText(
                      "Permanent State",
                    ),
                    _buildSizedBox(10),
                    AppDropdownInput(
                      options: profileController.stateList.isNotEmpty
                          ? profileController.stateList
                          : [],
                      hintText: profileController.selectedPermanentState != ""
                          ? profileController.selectedPermanentState
                          : "Select State",
                      onChanged: (value) {
                        profileController.updatePermanentStateList(value);
                      },
                    ),
                    _buildSizedBox(20),
                    _buildText(
                      "Residential Country",
                    ),
                    _buildSizedBox(10),
                    AppDropdownInput(
                      options: profileController.countryList.isNotEmpty
                          ? profileController.countryList
                          : [],
                      hintText:
                          profileController.selectedResidentialCountry != ""
                              ? profileController.selectedResidentialCountry
                              : "Select Country",
                      onChanged: (value) {
                        profileController.updateResidencyCountryList(value);
                      },
                    ),
                    _buildSizedBox(20),
                    _buildText(
                      "Residential State",
                    ),
                    _buildSizedBox(10),
                    AppDropdownInput(
                      options: profileController.stateList.isNotEmpty
                          ? profileController.stateList
                          : [],
                      hintText: profileController.selectedResidentialState != ""
                          ? profileController.selectedResidentialState
                          : "Select State",
                      onChanged: (value) {
                        profileController.updateResidencyStateList(value);
                      },
                    ),
                    _buildSizedBox(20),
                  ]),
            ),
          ),
        ),
        Container(
          color: AppColors.whiteColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _cancelButton(profileController),
              _buildSizedBox(20),
              _basicDetailsSubmitButton(profileController, 2)
            ],
          ).paddingOnly(right: 10, bottom: 10),
        )
      ],
    );
  }

  Widget _addressWidget(TextEditingController cntrl) {
    return TextFormField(
      minLines: 3,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      controller: cntrl,
      decoration: InputDecoration(
        hintText: "address",
        filled: true,
        fillColor: Colors.white,
        errorStyle: const TextStyle(height: 0, color: AppColors.redColor),
        hintStyle: const TextStyle(
          fontSize: 16,
          color: Color(0xFF969A9D),
          fontWeight: FontWeight.w300,
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: AppColors.greyColor, width: 1)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide:
                const BorderSide(color: AppColors.darkPinkColor, width: 1.5)),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.0),
          borderSide: const BorderSide(color: AppColors.redColor, width: 1.5),
        ),
      ),
    );
  }

  Widget _basicDetailsSubmitButton(
      StaffProfileController profileController, int type) {
    return SMSButtonWidget(
      onPress: () async {
        if (type == 1) {
          if (profileController.mobileNumberController.text.isNotEmpty) {
            if (profileController.maritalStatus != "") {
              Map<String, dynamic> mapData = {
                "marital_status_id": profileController.maritalStatusId,
                "per_address":
                    profileController.profileData?.permanentAddress?.address ??
                        "",
                "per_country_id": profileController.permanentCountryId,
                "per_state_id": profileController.permanentStateId,
                "res_address": profileController
                        .profileData?.residentialAddress?.address ??
                    "",
                "res_country_id": profileController.residencyCountryId,
                "res_state_id": profileController.residencyStateId,
                "phone_no": profileController.mobileNumberController.text
              };
              print("mapData $mapData");
              await profileController.updateProfileDetails(mapData);
              profileController.viewBasicProfile(true);
            } else {
              //showStaffToastMsg("select marital status");
            }
          } else {
           // showStaffToastMsg("The phone no field is required.");
          }
        } else {
          if (profileController.currentAddressController.text.isNotEmpty) {
            if (profileController.permanentAddressController.text.isNotEmpty) {
              if (profileController.selectedPermanentCountry != "") {
                if (profileController.selectedPermanentState != "") {
                  if (profileController.selectedResidentialCountry != "") {
                    if (profileController.selectedResidentialState != "") {
                      Map<String, dynamic> mapData = {
                        "marital_status_id": profileController.maritalStatusId,
                        "per_address": profileController
                                .profileData?.permanentAddress?.address ??
                            "",
                        "per_country_id": profileController.permanentCountryId,
                        "per_state_id": profileController.permanentStateId,
                        "res_address": profileController
                                .profileData?.residentialAddress?.address ??
                            "",
                        "res_country_id": profileController.residencyCountryId,
                        "res_state_id": profileController.residencyStateId,
                        "phone_no":
                            profileController.mobileNumberController.text
                      };
                      print("mapData $mapData");
                      await profileController.updateProfileDetails(mapData);
                      profileController.viewBasicProfile(true);
                    } else {
                      //showStaffToastMsg("select Residency state");
                    }
                  } else {
                  //  showStaffToastMsg("select Residency country");
                  }
                } else {
                 // showStaffToastMsg("select permanent state");
                }
              } else {
               // showStaffToastMsg("select permanent country");
              }
            } else {
             // showStaffToastMsg("Permanent Address field is required.");
            }
          } else {
          //  showStaffToastMsg("Current Address field is required.");
          }
        }
      },
      text: "Submit",
      width: width * 0.1,
      height: 35,
      borderRadius: 20,
      primaryColor: AppColors.darkPinkColor,
    );
  }

  Widget _cancelButton(StaffProfileController profileController) {
    return TextButton(
        onPressed: () {
          profileController.viewBasicProfile(true);
        },
        child: Text(
          "CANCEL",
          style: AppStyles.NunitoRegular.copyWith(
              color: Colors.black, fontSize: 15),
        ));
  }

  Text _buildText(String text) {
    return Text(text,
        style: AppStyles.NunitoRegular.copyWith(
            fontSize: 14, color: Colors.black));
  }

  Text _headingText(String text) {
    return Text(text, style: AppStyles.NunitoExtrabold.copyWith(fontSize: 18));
  }

  Widget _buildRowWidget(
      String key, String keyValue, String key1, String keyValue1) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: Row(
        children: [
          _buildTextWithValue(key, keyValue),
          _buildTextWithValue(key1, keyValue1),
        ],
      ),
    );
  }

  Widget _buildTextWithValue(String key, String keyValue) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(key, style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
            const SizedBox(
              height: 5,
            ),
            Text(keyValue,
                style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressText(String key, String keyValue) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(key, style: AppStyles.NunitoLight.copyWith(fontSize: 13)),
            const SizedBox(
              height: 5,
            ),
            Text(keyValue,
                style: AppStyles.NunitoRegular.copyWith(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _usernameAndCodeText(
      StaffProfileController profileController, double fontSize, String text) {
    return Text(
      text,
      style: AppStyles.NunitoExtrabold.copyWith(fontSize: fontSize),
    );
  }

  Widget _buildSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  Widget _profileImage(StaffProfileController profileController) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: Get.context!,
            builder: (context) => _buildSheet(profileController));
      },
      child: Stack(
        children: [
          Center(
            child: Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 1, color: Colors.black, style: BorderStyle.solid),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          profileController.profileData?.photo ?? ""))),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 10,
            right: 0,
            child: Container(
                width: 30.0,
                height: 30.0,
                decoration: BoxDecoration(
                  color: AppColors.darkPinkColor,
                  border: Border.all(
                      width: 1,
                      color: AppColors.darkPinkColor,
                      style: BorderStyle.solid),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.camera_alt_sharp,
                  color: AppColors.whiteColor,
                  size: 13,
                )).paddingOnly(left: 30, top: 30),
          )
        ],
      ),
    );
  }

  Widget _buildSheet(StaffProfileController profileController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Upload Image",
              style:
                  nunitoExtraBoldTextStyle(fontSize: 15, color: Colors.black)),
          const SizedBox(
            height: 10,
          ),
          Text(
              "Upload the homework Image View below option like Gallery or Camera",
              style:
                  nunitoRegularTextStyle(fontSize: 13, color: Colors.black87)),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                  profileController.pickGalleryImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/gallery_pick_icon.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Gallery",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 14, color: Colors.black)),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              InkWell(
                onTap: () {
                  Get.back();
                  profileController.captureImage();
                },
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/camera_picker_icon.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text("Camera",
                          style: nunitoExtraBoldTextStyle(
                              fontSize: 14, color: Colors.black)),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
