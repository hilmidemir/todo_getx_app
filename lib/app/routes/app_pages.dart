import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import '../modules/home/home_view.dart';
import '../modules/task_detail/task_detail_view.dart';
import '../modules/trash/trash_view.dart';
import '../modules/task_detail/task_detail_controller.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
        name: Routes.home,
        page: () => const HomeView(),
        binding: BindingsBuilder(() {
          Get.put(HomeController());
        })),
    GetPage(
        name: Routes.detail,
        page: () => const TaskDetailView(),
        binding: BindingsBuilder(() {
          Get.put(TaskDetailController());
        })),
    GetPage(
      name: Routes.trash,
      page: () => const TrashView(),
      binding: BindingsBuilder(() {
        Get.lazyPut(() => HomeController()); //eğer zaten aktifse buna gerek yok
      }),
    )
  ];
}
