import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import 'package:todo_getx_app/core/responsive_constants.dart';

class TaskInputWidget extends StatelessWidget {
  const TaskInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Row(
      children: [
        // Yazı Girişi
        Expanded(
          child: TextField(
            controller: controller.textController,
            style: TextStyle(fontSize: AppSizes.fontM),
            decoration: InputDecoration(
              hintText: 'Add a new task',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusM),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: AppSizes.paddingSM,
                vertical: AppSizes.spacingS,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.paddingS),

        // Ekleme butonu
        IconButton(
          onPressed: controller.submitTask,
          tooltip: 'Add task',
          icon: Icon(
            Icons.add,
            size: AppSizes.iconM,
          ),
        ),
      ],
    );
  }
}
