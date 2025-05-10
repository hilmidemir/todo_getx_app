import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/task_detail/task_detail_controller.dart';

class TaskDetailView extends GetView<TaskDetailController> {
  const TaskDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Task')),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: controller.editController,
                decoration: const InputDecoration(
                  labelText: 'Task',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: controller.updateTask,
                label: const Text('Save Changes'),
                icon: const Icon(Icons.save),
              )
            ],
          )),
    );
  }
}
