import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkUtils {
  static StreamSubscription? subscription;
  static Future<Null> Function(ConnectivityResult result)? networkListener;

  /// Method to check Network connectivity.
  static Future<bool> checkNetwork() async {
    bool boolNetConnected = false;
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      boolNetConnected = false;
    } else if (connectivityResult == ConnectivityResult.mobile) {
      boolNetConnected = true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      boolNetConnected = true;
    }
    return boolNetConnected;
  }

  streamSubscribeConnectivityListener() {
    networkListener = (ConnectivityResult result) async {
      switch (result) {
        case ConnectivityResult.wifi:
          isConnected();
          break;
        case ConnectivityResult.ethernet:
        case ConnectivityResult.mobile:
          isConnected();
          break;
        case ConnectivityResult.none:
          await Get.dialog(NoInternetWidget(), barrierDismissible: false);

          await 2.seconds.delay();
          break;
      }
    };
    subscription = Connectivity().onConnectivityChanged.listen(networkListener);
  }

  static cancelNetworkSubscription() async {
    await subscription!.cancel();
  }

  void isConnected() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }
}

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Dialog(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.wifi_off_outlined),
              SizedBox(
                height: Get.height * 0.02,
              ),
              const Text(
                'NO INTERNET CONNECTION',
                style: TextStyle(
                    color: Colors.orange, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: Get.height * 0.01,
              ),
              const Text(
                'You don\'t have internet connection, continue offline mode?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
