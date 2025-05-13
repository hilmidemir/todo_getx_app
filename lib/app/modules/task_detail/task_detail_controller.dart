import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/models/task_model.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';

class TaskDetailController extends GetxController {
  late TaskModel task;
  final TextEditingController editController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    print('Get arguments: ${Get.arguments}');
    final arg = Get.arguments;
    if (arg is TaskModel) {
      task = arg;
      editController.text = task.title;
    } else
      print('HATA: Get.arguments null veya geçersiz');

    task = Get.arguments as TaskModel; // Sayfaya gelen görev
  }

  void updateTask() {
    final updatedTitle = editController.text.trim();
    if (updatedTitle.isNotEmpty && updatedTitle != task.title) {
      final updatedTask = task.copyWith(title: updatedTitle);
      final homeController = Get.find<HomeController>();

      //Görev id ye göre bul ve güncelle
      final index = homeController.tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        homeController.tasks[index] = updatedTask;
        homeController.saveTasks();
        Get.back(); // Geri dön
      }
    }
  }

  @override
  void onClose() {
    editController.dispose();
    super.onClose();
  }
}
