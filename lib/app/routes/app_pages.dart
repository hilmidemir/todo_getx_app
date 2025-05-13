import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import 'package:todo_getx_app/app/modules/home/home_view.dart';
import 'package:todo_getx_app/app/modules/task_detail/task_detail_controller.dart';
import 'package:todo_getx_app/app/modules/task_detail/task_detail_view.dart';
import 'package:todo_getx_app/app/modules/trash/trash_controller.dart';
import 'package:todo_getx_app/app/modules/trash/trash_view.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    routePage(Routes.home, const HomeView(), () => HomeController()),
    routePage(Routes.detail, const TaskDetailView(), () => TaskDetailController()),
    routePage(Routes.trash, const TrashView(), () => TrashController()),
  ];

  static GetPage<T> routePage<T>(
    String route,
    Widget page,
    T Function() controller,
  ) {
    return GetPage(
      name: route,
      page: () => page,
      binding: BindingsBuilder(() {
        Get.lazyPut<T>(controller);
      }),
    );
  }
}
