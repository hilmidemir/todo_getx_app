import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/data/services/task_service.dart';
import 'package:todo_getx_app/app/modules/trash/trash_list.dart';

class TrashView extends StatelessWidget {
  const TrashView({super.key});

  @override
  Widget build(BuildContext context) {
    final TaskService taskService = Get.find<TaskService>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
        actions: [
          IconButton(
            onPressed: () {
              taskService.clearTrash();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Trash Emptied'),
                ),
              );
            },
            icon: const Icon(Icons.delete_forever),
          ),
        ],
      ),
      body: const TrashListWidget(),
    );
  }
}
