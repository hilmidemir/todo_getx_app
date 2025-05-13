import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:todo_getx_app/app/data/services/task_service.dart';
import '../../models/task_model.dart';
import '../../data/services/task_storage_service.dart';

class HomeController extends GetxController {
  // Rx List: Reactive (Tepkisel bir görev listesi) tanımlıyoruz
  RxList<TaskModel> tasks = <TaskModel>[].obs;
  // Silinenleri tutacağımız bir rxlist
  RxList<TaskModel> deletedTasks = <TaskModel>[].obs;
  // Kullanıcının seçtiği kategorinin adı
  RxString selectedTag = 'Work'.obs;
  // Kullanıcının seçtiği renk
  RxInt selectedColorValue = 0xFF2196F3.obs; // varsayılan mavi
  final TaskStorageService _storageService = TaskStorageService();

  final TaskService taskService = Get.find<TaskService>();

  // Inputtan metin almak için controller
  final TextEditingController textController = TextEditingController();

  // Secure Storage Örneği
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  final String taskKey = 'task_list';
  final String deletedKey = 'deleted_task_list';

  @override
  void onInit() {
    super.onInit();
    loadTasks(); //Görevleri servisle yükleme
    loadDeletedTasks(); //Çöp kutusunu servisle yükle
    saveFakeUserID(); //ornek amaclı yazma
    readUserID(); //ornek amaclı okuma
  }

  // SharedPreferences den görevleri yükle
  Future<void> loadTasks() async {
    final loadedTasks = await _storageService.loadTasks();
    tasks.value = loadedTasks;
  }

  // Görevleri kaydetme
  Future<void> saveTasks() async {
    await _storageService.saveTasks(tasks);
  }

  // Silinenleri yükleme
  Future<void> loadDeletedTasks() async {
    final deleted = await _storageService.loadDeletedTasks();
    deletedTasks.value = deleted;
  }

  // Silinen task kurtarma
  Future<void> saveDeletedTasks() async {
    await _storageService.saveDeletedTasks(deletedTasks);
  }

  // Yenş görev Ekleme
  void submitTask() {
    final text = textController.text.trim();

    if (text.isNotEmpty) {
      taskService.addTask(
        text,
        selectedTag.value,
        selectedColorValue.value,
      );
      textController.clear();
    }
  }

  //Görev Silme
  void removeTask(int index) {
    final task = tasks[index];
    deletedTasks.add(task);
    tasks.removeAt(index);
    saveTasks(); // Silerken güncelle
    saveDeletedTasks();
  }

  void clearCompleatedTasksWithUndo(BuildContext context) {
    final completedTasks = tasks.where((task) => task.isDone).toList();
    if (completedTasks.isEmpty) return;

    deletedTasks.addAll(completedTasks);
    tasks.removeWhere((task) => task.isDone);
    saveTasks();
    saveDeletedTasks();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Completed tasks cleared'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            tasks.addAll(completedTasks);
            saveTasks();
            // Geri alınanları çöp kutusundan çıkar
            deletedTasks.removeWhere((t) => completedTasks.contains(t));
            saveDeletedTasks();
          },
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  //Görev Tamamlandı Durumunu değiştirme
  void toggleTask(int index) {
    final updated = tasks[index].copyWith(
      isDone: !tasks[index].isDone,
    );
    tasks[index] = updated;
    saveTasks();
  }

  // Secure Storage Örneği
  Future<void> saveFakeUserID() async {
    await secureStorage.write(key: 'user_id', value: 'user_123123');
  }

  // Secure Storageden user_id oku ve logla
  Future<void> readUserID() async {
    final id = await secureStorage.read(key: 'user_id');
    if (id != null) {
      print('✅ Kullanici ID: $id');
    } else {
      print('❌ Kullanici ID bulunamadi.');
    }
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
