import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import 'task_storage_service.dart';
import '../../models/task_model.dart';

class TaskService extends GetxService {
  final RxList<TaskModel> tasks = <TaskModel>[].obs;
  final RxList<TaskModel> deletedTasks = <TaskModel>[].obs;

  final TaskStorageService _storage = TaskStorageService();

  Future<void> loadAllTasks() async {
    tasks.value = await _storage.loadTasks();
    deletedTasks.value = await _storage.loadDeletedTasks();
  }

  Future<void> addTask(String title, String tagLabel, int tagColor) async {
    final newTask = TaskModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      isDone: false,
      createdAt: DateTime.now(),
      tagLabel: tagLabel,
      tagColorValue: tagColor,
    );

    final HomeController home = Get.find<HomeController>();
    home.tasks.add(newTask);
    await home.saveTasks(); // Her görev Eklemede kaydet
  }

  Future<void> removeTask(int index) async {
    final removed = tasks[index];
    deletedTasks.add(removed);
    tasks.removeAt(index);
    await _storage.saveTasks(tasks);
    await _storage.saveDeletedTasks(deletedTasks);
  }

  Future<void> toggleTask(int index) async {
    final task = tasks[index];
    tasks[index] = task.copyWith(isDone: !task.isDone);
    await _storage.saveTasks(tasks);
  }

  Future<void> clearCompletedTasksWithUndo(Function(List<TaskModel>)? onUndo) async {
    final completed = tasks.where((t) => t.isDone).toList();

    if (completed.isEmpty) return;

    deletedTasks.addAll(completed);
    tasks.removeWhere((t) => t.isDone);

    await _storage.saveTasks(tasks);
    await _storage.saveDeletedTasks(deletedTasks);

    if (onUndo != null) {
      onUndo(completed); // controllerdan gelen undo aksiyonu çalışır
    }
  }

  Future<void> restoreTask(TaskModel task) async {
    tasks.add(task);
    deletedTasks.remove(task);
    await _storage.saveTasks(tasks);
    await _storage.saveDeletedTasks(deletedTasks);
  }

  Future<void> clearTrash() async {
    deletedTasks.clear();
    await _storage.saveDeletedTasks(deletedTasks);
  }
}
