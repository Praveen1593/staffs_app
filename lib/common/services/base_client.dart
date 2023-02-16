import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../parent/view/screens/daily_actvities/homework/homework_submission_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_CT_add_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_classtest/staff_classtest_add_entry_screen.dart';
import '../../staff/view/screens/staff_dailly_activities/staff_home_work/staff_homework_add_entry_screen.dart';
import '../../storage.dart';

class BaseService {
  String token = LocalStorage.getValue('token') ?? "";
  Dio dio = Dio(
    BaseOptions(
      baseUrl: LocalStorage.getValue('url') ?? "",
      connectTimeout: 10000,
      receiveTimeout: 30000,
      responseType: ResponseType.json,
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  ///Login without token
  Future loginPostMethod(Map<String, dynamic> userData, String url) async {
    FormData formData = FormData.fromMap(userData);
    try {
      Response response = await dio.post(
        url.trim(),
        data: formData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  ///Post
  Future postMethod(Map<String, dynamic> userData, String url) async {
    FormData formData = FormData.fromMap(userData);
    try {
      Response response = await dio.post(
        url,
        data: formData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future uploadStaffClassTestCTMultipleFiles(
      {required int classTestId,
        required String classTestTitle,
        required int sectionSubjectItemId,
        required String classTestDesc,
        required int approvalType,
        required int classTestApprovalType,
        required List<StaffClassTestCTAttachment> filesList,
        required String url}) async {
    FormData data = FormData.fromMap({});
    try {
      if (filesList.isNotEmpty) {
        List<MultipartFile> files = [];
        for (int i = 0; i < filesList.length; i++) {
          String fileName = filesList[i].file!.path.split('/').last;
          MultipartFile mFile = await MultipartFile.fromFile(
            filesList[i].file!.path,
            filename: fileName,
          );
          files.add(mFile);
        }
        data = FormData.fromMap({
          "id": classTestId,
          "title": classTestTitle,
          "section_subject_item_id": sectionSubjectItemId,
          "description": classTestDesc,
          "approval_type": approvalType,
          "staff_class_test_approval_type": classTestApprovalType,
          "images[]": files
        });

      } else {
        print("normal method");
        data = FormData.fromMap({
          "id": classTestId,
          "title": classTestTitle,
          "section_subject_item_id": sectionSubjectItemId,
          "description": classTestDesc,
          "approval_type": approvalType,
          "staff_class_test_approval_type": classTestApprovalType,
          "images": []
        });
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future uploadStaffClassTestMultipleFiles(
      {required int classTestId,
      required String classTestTitle,
      required int sectionSubjectItemId,
      required String classTestDesc,
      required int approvalType,
      required int classTestApprovalType,
      required List<StaffClassTestAttachment> filesList,
      required String url}) async {
    FormData data = FormData.fromMap({});
    try {
      if (filesList.isNotEmpty) {
        print("file method");
        for (int i = 0; i < filesList.length; i++) {
          print("image file name: ${filesList[i].fileName}");
          print("image file path: ${filesList[i].file}");
          String fileName = filesList[i].file!.path.split('/').last;
          data = FormData.fromMap({
            "id": classTestId,
            "title": classTestTitle,
            "section_subject_item_id": sectionSubjectItemId,
            "description": classTestDesc,
            "approval_type": approvalType,
            "staff_class_test_approval_type": classTestApprovalType,
            "images[]": await MultipartFile.fromFile(
              filesList[i].file!.path,
              filename: fileName,
            )
          });
        }
      } else {
        print("normal method");
        data = FormData.fromMap({
          "id": classTestId,
          "title": classTestTitle,
          "section_subject_item_id": sectionSubjectItemId,
          "description": classTestDesc,
          "approval_type": approvalType,
          "staff_homework_approval_type": classTestApprovalType,
          "images": []
        });
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

//Post without FormData
  Future postWithoutFormData(Map<String, dynamic> userData, String url) async {
    try {
      Response response = await dio.post(
        url,
        data: userData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token',
              'Accept': "application/json",
              'Content-Type': 'application/json'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future paymentTokenPostWithoutFormData(Map<String, dynamic> userData, String url) async {
    try {
      Response response = await dio.post(
        url,
        data: userData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'pk_sbox_wv3nzfiy73mjiil2ij2gdjsr6u=',
              'Accept': "*/*",
              'Content-Type': 'application/json'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future paymentPostWithoutFormData(Map<String, dynamic> userData, String url) async {
    try {
      Response response = await dio.post(
        url,
        data: userData,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer sk_sbox_3zvo624wv65p2fwtmte7hgxvy4d',
              'Accept': "*/*",
              'Content-Type': 'application/json'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }


  //Multipart
  Future multipartFormData(XFile file, String url) async {
    String fileName = file.path.split('/').last;
    try {
      FormData data = FormData.fromMap({
        "photo": await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });

      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  ///upload multiple files
  Future uploadMultipleFiles(
      {required String homewrkId,
      required String homewrkText,
      required List<FilesUploadModel> filesList,
      required String url}) async {
    FormData data = FormData.fromMap({});
    try {
      List emptyList = [];
      if (filesList.isNotEmpty) {
        for (int i = 0; i < filesList.length; i++) {
          String fileName = filesList[i].file!.path.split('/').last;
          emptyList.add(await MultipartFile.fromFile(
            filesList[i].file!.path,
            filename: fileName,
          ));
        }
      }
      data = FormData.fromMap({
        "student_id": LocalStorage.getValue("studentId"),
        "homework_id": homewrkId,
        "stu_description": homewrkText,
        "stu_homework_file[]": emptyList
      });

      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  Future uploadStaffMultipleFiles(
      {required int homeworkId,
      required String homeworkTitle,
      required String homeworkDate,
      required int sectionSubjectItemId,
      required String hwDesc,
      required int approvalType,
      required int staffHomeworkApprovalType,
      required List<StaffHomeworkAttachment> filesList,
      required String url}) async {
    FormData data = FormData.fromMap({});
    try {
      if (filesList.isNotEmpty) {
        for (int i = 0; i < filesList.length; i++) {
          String fileName = filesList[i].file!.path.split('/').last;
          data = FormData.fromMap({
            "id": homeworkId,
            "title": homeworkTitle,
            "date": homeworkDate,
            "section_subject_item_id": sectionSubjectItemId,
            "description": hwDesc,
            "approval_type": approvalType,
            "staff_homework_approval_type": staffHomeworkApprovalType,
            "images[]": await MultipartFile.fromFile(
              filesList[i].file!.path,
              filename: fileName,
            )
          });
        }
      } else {
        data = FormData.fromMap({
          "id": homeworkId,
          "title": homeworkTitle,
          "date": homeworkDate,
          "section_subject_item_id": sectionSubjectItemId,
          "description": hwDesc,
          "approval_type": approvalType,
          "staff_homework_approval_type": staffHomeworkApprovalType,
          "images": []
        });
      }
      Response response = await dio.post(url,
          data: data,
          options: Options(
              responseType: ResponseType.json,
              validateStatus: (status) {
                return status! < 500;
              },
              headers: {
                HttpHeaders.contentTypeHeader: "application/json",
                'Authorization': 'Bearer $token',
                "Accept": "application/json",
              }));
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }

  ///Get
  Future getMethod(String url) async {
    print("url $url");
    try {
      Response response = await dio.get(
        url,
        options: Options(
            validateStatus: (_) => true,
            responseType: ResponseType.json,
            headers: {
              HttpHeaders.contentTypeHeader: "application/json",
              'Authorization': 'Bearer $token}'
            }),
      );
      return response;
    } on DioError catch (e) {
      print('Dio Error $e');
    }
  }
}
