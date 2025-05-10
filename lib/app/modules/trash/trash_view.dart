import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';

class TrashView extends StatelessWidget {
  const TrashView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trash'),
        actions: [
          IconButton(
            onPressed: () {
              controller.deletedTasks.clear();
              controller.saveDeletedTasks();
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
      body: Obx(
        () {
          final deleted = controller.deletedTasks;

          if (deleted.isEmpty) {
            return const Center(
              child: Text('Tresh is empty'),
            );
          }
          return ListView.builder(
            itemCount: deleted.length,
            itemBuilder: (context, index) {
              final task = deleted[index];
              return ListTile(
                leading: const Icon(Icons.delete),
                title: Text(
                  task.title,
                  style: const TextStyle(decoration: TextDecoration.lineThrough),
                ),
                subtitle: Text('Deleted: ${task.createdAt}'),
                trailing: IconButton(
                  icon: const Icon(Icons.restore),
                  tooltip: 'Restore',
                  onPressed: () {
                    controller.tasks.add(task);
                    controller.deletedTasks.removeAt(index);
                    controller.saveTasks();
                    controller.saveDeletedTasks();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Task restored')));
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
