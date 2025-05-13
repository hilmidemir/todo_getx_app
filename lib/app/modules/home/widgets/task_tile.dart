import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/models/task_model.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import 'package:todo_getx_app/app/core/responsive_constants.dart';

class TaskTile extends StatelessWidget {
  final TaskModel task;
  final int index;

  const TaskTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: AppSizes.spacingS,
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingS,
        ),
        tileColor: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        leading: Checkbox(
          value: task.isDone,
          onChanged: (_) => controller.toggleTask(index),
        ),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: AppSizes.fontM,
            decoration: task.isDone ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        subtitle: Text(
          '${task.tagLabel} - ${_formatDate(task.createdAt)}',
          style: TextStyle(
            fontSize: AppSizes.fontS,
            color: Colors.grey.shade700,
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: AppSizes.paddingS10,
              height: AppSizes.spacingXL40,
              color: Color(task.tagColorValue),
            ),
            SizedBox(
              width: AppSizes.paddingS,
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
                size: AppSizes.iconM,
              ),
              onPressed: () => controller.removeTask(index),
            ),
          ],
        ),
        onTap: () {
          print("📦 Gidiyor: ${task.title}");
          Get.toNamed('/detail', arguments: task);
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final d = date.toLocal();
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  }
}
