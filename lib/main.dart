import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'common/common_controller/login_binding.dart';
import 'common/internet_connection_service/internet_connect_checker.dart';
import 'common/routes/app_pages.dart';
import 'common/routes/app_routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await GetStorage.init();
  await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget with WidgetsBindingObserver {
  MyApp({super.key}) {
    NetworkUtils().streamSubscribeConnectivityListener();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: LoginBinding(),
      initialRoute: AppRoutes.SPLASHVIEW,
      getPages: AppPages.routes,
    );
  }
}
