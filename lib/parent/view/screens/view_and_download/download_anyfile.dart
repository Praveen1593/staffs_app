import 'dart:io';
import 'dart:isolate';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadFiles extends StatefulWidget {
  final String file;
  const DownloadFiles({Key? key, required this.file}) : super(key: key);

  @override
  State<DownloadFiles> createState() => _DownloadFilesState();
}

class _DownloadFilesState extends State<DownloadFiles> {
  String? downloadId;
  String? _localPath;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');
    FlutterDownloader.registerCallback(downloadCallback);

    _localPath = '${await _findLocalPath()}/Download';
    final savedDir = Directory(_localPath!);
    bool hasExisted = await savedDir.exists();
    if (!hasExisted) {
      savedDir.create();
    }
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    send!.send([id, status, progress]);
  }

  Future<String> _findLocalPath() async {
    final directory = await getExternalStorageDirectory();
    return directory!.path;
  }

  Future<bool> _checkPermission() async {
    if (Theme.of(context).platform == TargetPlatform.android) {
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
          onTap: () async {
            if (await _checkPermission()) {
              final taskId = await FlutterDownloader.enqueue(
                url: widget.file,
                savedDir: _localPath!,
                showNotification:
                    true, // show download progress in status bar (for Android)
                openFileFromNotification:
                    true, // click on notification to open downloaded file (for Android)
              );
              downloadId = taskId;
            }
          },
          child: const Text(
            'DownloadFile',
            style: TextStyle(color: Colors.teal),
          )),
    );
  }
}
