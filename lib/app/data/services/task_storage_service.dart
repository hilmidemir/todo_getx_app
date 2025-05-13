import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/task_model.dart';

class TaskStorageService {
  final String taskKey = 'task_list';
  final String deletedKey = 'deleted_task_list';

  // Görevleri kaydetme
  Future<void> saveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = tasks.map((e) => e.toJson()).toList();
    await prefs.setString(taskKey, jsonEncode(jsonList));
    //final jsonEncoded = jsonEncode(jsonList);
    //print('💾 Kaydedilen JSON: $jsonEncoded');      bu 3 satır debug içindi eğer kayıtlı görev yüklemezse kullanıyorum
    //await prefs.setString(taskKey, jsonEncoded);
  }

  // SharedPreferences den görevleri yükle
  Future<List<TaskModel>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(taskKey);
    // print('📥 Yüklenen JSON: $jsonString');      debug
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    }
    return [];
  }

  // Silinen task kurtarma
  Future<void> saveDeletedTasks(List<TaskModel> deletedTasks) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = deletedTasks.map((e) => e.toJson()).toList();
    //final jsonStr = jsonEncode(jsonList);
    //print('🗑️ Kaydedilen trash JSON: $jsonStr'); // çöp kutusu silme debug
    await prefs.setString(deletedKey, jsonEncode(jsonList));
  }

  // Silinenleri yükleme
  Future<List<TaskModel>> loadDeletedTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(deletedKey);
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      return decoded.map((e) => TaskModel.fromJson(e)).toList();
    }
    return [];
  }
}
