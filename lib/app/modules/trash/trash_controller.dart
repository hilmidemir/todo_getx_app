import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';

class TrashController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();

  void restoreTask(int index) {
    final task = homeController.deletedTasks[index];
    homeController.tasks.add(task);
    homeController.deletedTasks.removeAt(index);
    homeController.saveTasks();
    homeController.saveDeletedTasks();
  }

  void clearTrash() {
    homeController.deletedTasks.clear();
    homeController.saveDeletedTasks();
  }
}
