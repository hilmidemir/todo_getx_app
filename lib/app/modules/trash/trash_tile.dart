import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/models/task_model.dart';
import 'package:todo_getx_app/app/modules/trash/trash_controller.dart';
import 'package:todo_getx_app/core/responsive_constants.dart';

class TrashTile extends StatelessWidget {
  final TaskModel task;
  final int index;
  const TrashTile({super.key, required this.task, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TrashController>();
    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppSizes.spacingS),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppSizes.paddingM,
          vertical: AppSizes.paddingS,
        ),
        tileColor: Colors.grey.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radiusM),
        ),
        leading: const Icon(Icons.delete_outline),
        title: Text(
          task.title,
          style: TextStyle(
            fontSize: AppSizes.fontM,
            decoration: TextDecoration.lineThrough,
          ),
        ),
        subtitle: Text(
          'Deleted: ${_formatDate(task.createdAt)}',
          style: TextStyle(
            fontSize: AppSizes.fontS,
            color: Colors.grey.shade600,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.restore, size: AppSizes.iconM),
          tooltip: 'Restore',
          onPressed: () => controller.restoreTask(index),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final d = date.toLocal();
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  }
}
