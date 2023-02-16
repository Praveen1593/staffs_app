import 'package:flutter/cupertino.dart';
import 'package:flutter_projects/common/apihelper/api_helper.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../common/services/base_client.dart';
import '../../../parent/view/dialogs/dialog_helper.dart';
import '../../model/change_password_model.dart';
import '../../model/marital_status_model.dart';
import '../../model/profile_details_model.dart';
import 'package:flutter_projects/common/const/colors.dart';

class StaffProfileController extends GetxController {
  bool isVisibleBasicDetails = false;
  bool isVisibleAddressDetails = false;
  bool isVisibleProfileDetails = true;
  String maritalStatus = "";
  String selectedResidentialState = "";
  String selectedResidentialCountry = "";
  String selectedPermanentCountry = "";
  String selectedPermanentState = "";
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController permanentAddressController = TextEditingController();
  TextEditingController currentAddressController = TextEditingController();
  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> key = GlobalKey();
  List<MaritalStatusData> maritalStatusData = [];
  List<MaritalStatusData> countryList = [];
  List<MaritalStatusData> stateList = [];
  ProfileData? profileData;
  bool isLoading = false;
  int permanentCountryId = -1;
  int permanentStateId = -1;
  int residencyCountryId = -1;
  int residencyStateId = -1;
  int maritalStatusId = -1;
  ImagePicker picker = ImagePicker();
  bool isVisibleCurrentAddress = false;
  ScrollController scrollController = ScrollController();
  bool isFAB = false;
  bool visiblePassword = false;
  bool visibleCurrentPassword = false;
  bool visibleNewPassword = false;
  ChangePasswordModel? changePasswordModel;

  @override
  void onInit() {
    super.onInit();
    maritalStatus = "";
    selectedResidentialState = "";
    selectedResidentialCountry = "";
    selectedPermanentCountry = "";
    selectedPermanentState = "";
    fetchProfileDetails();
    fetchMaritalStatus();
    fetchCountryList();
    scrollController.addListener(() {
      if (scrollController.offset > 50) {
        isFAB = true;
      } else {
        isFAB = false;
      }
      update();
    });
  }

  void togglePasswordView() {
    visiblePassword = !visiblePassword;
    update();
  }

  void toggleNewPasswordView() {
    visibleNewPassword = !visibleNewPassword;
    update();
  }

  void toggleCurrentPasswordView() {
    visibleCurrentPassword = !visibleCurrentPassword;
    update();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void viewBasicProfile(bool isVisible) {
    isVisibleProfileDetails = isVisible;
    isVisibleAddressDetails = false;
    isVisibleBasicDetails = false;
    update();
  }

  void isVisibleAddress(bool isVisible) {
    isVisibleCurrentAddress = isVisible;
    update();
  }

  void editBasicDetails(bool isVisible) {
    isVisibleBasicDetails = isVisible;
    isVisibleAddressDetails = false;
    isVisibleProfileDetails = false;
    update();
  }

  void editAddressDetails(bool isVisible) {
    isVisibleBasicDetails = false;
    isVisibleAddressDetails = isVisible;
    isVisibleProfileDetails = false;
    update();
  }

  void updateMaritalStatus(String mstatus) {
    maritalStatus = mstatus;
    _getMaritalStatusId();
    update();
  }

  void updatePermanentCountryList(String countryValue) {
    selectedPermanentCountry = countryValue;
    selectedPermanentState = "";
    _getPermanentCountryId();
    update();
  }

  void updateResidencyCountryList(String countryValue) {
    selectedResidentialCountry = countryValue;
    selectedResidentialState = "";
    _getPermanentCountryId();
    update();
  }

  void updatePermanentStateList(String stateValue) {
    selectedPermanentState = stateValue;
    _getPermanentStateID(1);
    update();
  }

  void updateResidencyStateList(String stateValue) {
    selectedResidentialState = stateValue;
    _getPermanentStateID(2);
    update();
  }

  Future fetchProfileDetails() async {
    isLoading = true;
    try {
      final result =
          await BaseService().getMethod("${ApiHelper.staffProfileUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          isLoading = false;
          ProfileDetailsModel profileDetailsModel =
              ProfileDetailsModel.fromJson(result.data);
          profileData = profileDetailsModel.profileData;
          maritalStatus = profileData?.maritalStatus ?? "";
          mobileNumberController.text = profileData?.phone ?? "";
          permanentAddressController.text =
              profileData?.permanentAddress?.address ?? "";
          currentAddressController.text =
              profileData?.residentialAddress?.address ?? "";
          selectedPermanentCountry =
              profileData?.permanentAddress?.country ?? "";
          selectedPermanentState = profileData?.permanentAddress?.state ?? "";
          selectedResidentialCountry =
              profileData?.residentialAddress?.country ?? "";
          selectedResidentialState =
              profileData?.residentialAddress?.state ?? "";
        } else {}
      }
    } catch (e) {
      print(' Fetch Profile Details  $e');
    } finally {
      isLoading = false;
    }
    update();
  }

  Future fetchMaritalStatus() async {
    try {
      final result =
          await BaseService().getMethod("${ApiHelper.martialStatusUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          MaritalStatusModel maritalStatusModel =
              MaritalStatusModel.fromJson(result.data);
          maritalStatusData = maritalStatusModel.maritalStatusData ?? [];
          _getMaritalStatusId();
        } else {}
      }
    } catch (e) {
      print('Marital Status $e');
    } finally {}
    update();
  }

  void _getMaritalStatusId() {
    if (maritalStatusData.isNotEmpty) {
      for (int i = 0; i < maritalStatusData.length; i++) {
        if (maritalStatus == maritalStatusData[i].name) {
          maritalStatusId = maritalStatusData[i].id ?? -1;
        }
      }
    }
  }

  Future fetchCountryList() async {
    try {
      final result =
          await BaseService().getMethod("${ApiHelper.countryListUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          MaritalStatusModel maritalStatusModel =
              MaritalStatusModel.fromJson(result.data);
          countryList = maritalStatusModel.maritalStatusData ?? [];
          _getPermanentCountryId();
        }
      }
    } catch (e) {
      print('Country List $e');
    } finally {}
    update();
  }

  void _getPermanentCountryId() {
    if (countryList.isNotEmpty) {
      for (int i = 0; i < countryList.length; i++) {
        if (selectedPermanentCountry == countryList[i].name) {
          permanentCountryId = countryList[i].id ?? -1;
          fetchStateList(permanentCountryId, 1);
        }
        if (selectedResidentialCountry == countryList[i].name) {
          residencyCountryId = countryList[i].id ?? -1;
          fetchStateList(residencyCountryId, 2);
        }
      }
    }
  }

  Future fetchStateList(int id, int type) async {
    try {
      final result = await BaseService()
          .getMethod("${ApiHelper.stateListUrl}?country_id=$id");
      if (result != null) {
        if (result.statusCode == 200) {
          MaritalStatusModel maritalStatusModel =
              MaritalStatusModel.fromJson(result.data);
          stateList = maritalStatusModel.maritalStatusData ?? [];
          _getPermanentStateID(type);
        } else {}
      }
    } catch (e) {
      print('State List $e');
    } finally {}
    update();
  }

  void _getPermanentStateID(int type) {
    if (stateList.isNotEmpty) {
      for (int i = 0; i < stateList.length; i++) {
        if (type == 1) {
          if (selectedPermanentState == stateList[i].name) {
            permanentStateId = stateList[i].id ?? -1;
          }
        } else {
          if (selectedResidentialState == stateList[i].name) {
            residencyStateId = stateList[i].id ?? -1;
          }
        }
      }
    }
  }

  Future updateProfileDetails(Map<String, dynamic> sentData) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService()
          .postMethod(sentData, "${ApiHelper.profileEditUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          fetchProfileDetails();
          Get.snackbar("","updated" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showToastMsg("Updated");
        } else {}
      }
    } catch (e) {
      print('State List $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future pickGalleryImage() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);
    profilePhotoEdit(image!);
    update();
  }

  Future captureImage() async {
    XFile? image =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 25);
    profilePhotoEdit(image!);
    update();
  }

  Future profilePhotoEdit(XFile file) async {
    showLoadingDialog(Get.context!);
    try {
      final result = await BaseService()
          .multipartFormData(file, "${ApiHelper.profilePhotoEditUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          fetchProfileDetails();
          Get.snackbar("Success","" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showToastMsg("Success");
        } else {
          Get.snackbar("Failed","" ,snackPosition: SnackPosition.BOTTOM, duration: Duration(seconds: 10), backgroundColor: AppColors.blackColor, colorText: AppColors.lightOrange);
         // showToastMsg("Failed");
        }
      }
    } catch (e) {
      print('Profile Screen $e');
    } finally {
      closeLoadingDialog(Get.context!);
    }
    update();
  }

  Future changePassword(Map<String, dynamic> mapData) async {
    try {
      final result = await BaseService()
          .postMethod(mapData, "${ApiHelper.changePasswordUrl}");
      if (result != null) {
        if (result.statusCode == 200) {
          changePasswordModel = ChangePasswordModel.fromJson(result.data);
        }
      }
    } catch (e) {
      print('Change Password $e');
    } finally {}
    update();
  }
}
