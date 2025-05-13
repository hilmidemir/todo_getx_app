import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/widgets/task_input.dart';
import 'package:todo_getx_app/app/modules/home/widgets/task_list.dart';
import 'package:todo_getx_app/app/routes/app_pages.dart';
import '../home/home_controller.dart';
import 'widgets/tag_selector.dart';
import '../../core/responsive_constants.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To-Do List',
          style: TextStyle(fontSize: AppSizes.fontL),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              controller.clearCompleatedTasksWithUndo(context);
            },
            icon: const Icon(Icons.delete_sweep),
            tooltip: 'Clear Completed',
          ),
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.trash);
            },
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Trash',
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Etiket ve renk Seçimi
            TagSelectorWidget(),
            SizedBox(height: AppSizes.spacingM),
            // Görev Ekleme
            TaskInputWidget(),
            SizedBox(height: AppSizes.spacingM),
            // Görev Listesi
            Expanded(child: TaskListWidget())
          ],
        ),
      ),
    );
  }
}
