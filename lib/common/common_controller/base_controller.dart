import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BaseController extends GetxController{

  ///download url
  String? downloadId;
  final ReceivePort _port = ReceivePort();


  @override
  void onInit() {
    super.onInit();
    _init();
  }


  Future<void> _init() async {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = data[1];
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  Future get localpath async {
    final result = await Permission.storage.request();
    if (result == PermissionStatus.granted) {
      String localPath =
          '${await _findLocalPath()}${Platform.pathSeparator}Download/$downloadId';
      final savedDir = Directory(localPath);
      bool hasExisted = await savedDir.exists();
      if (!hasExisted) {
        savedDir.create();
      }
      return localPath;
    }
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
    IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  Future<String> _findLocalPath() async {
    final directory = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  Future<bool> _checkPermission() async {
    if (Theme.of(Get.context!).platform == TargetPlatform.android) {
      final status = await Permission.storage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }
    return false;
  }

  Future downloadFileWidget(String url) async {
    if (await _checkPermission()) {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: await localpath,
        showNotification: true,
        // show download progress in status bar (for Android)
        openFileFromNotification: true,
        // click on notification to open downloaded file (for Android)
        saveInPublicStorage: true,
      );
      downloadId = taskId;
    }
  }
}