import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/data/services/task_service.dart';
import 'app/routes/app_pages.dart';

void main() {
  Get.put(TaskService());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Tasarımlarda genelliklle referans alınan telefon boyutu iphone x
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'To-Do GetX App',
          initialRoute: Routes.home,
          getPages: AppPages.routes,
          theme: ThemeData(
            useMaterial3: true,
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.white,
          ),
        );
      },
    );
  }
}
