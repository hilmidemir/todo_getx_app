import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/widgets/task_tile.dart';
import '../home_controller.dart';
import '../../../../core/responsive_constants.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Obx(() {
      final tasks = controller.tasks;
      if (tasks.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.spacingL),
            child: Text(
              'No tasks yet',
              style: TextStyle(fontSize: AppSizes.fontM),
            ),
          ),
        );
      }
      return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return TaskTile(task: task, index: index);
        },
      );
    });
  }
}
