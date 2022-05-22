import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/services/storage_services.dart';
import 'package:todo/utilis/appRoutes.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  await GetStorage.init();
  await Get.putAsync(() => StorageService().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.native,
      builder: (context, widget) {
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: widget!);
      },
      title: "ToDo App",
      themeMode: ThemeMode.system,
      initialRoute: Routes.splash,
      getPages: AppScreens.routes,
    );
  }
}
