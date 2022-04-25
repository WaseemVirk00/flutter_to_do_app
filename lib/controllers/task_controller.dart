import 'package:flutter_to_do_app/db/db_helper.dart';
import 'package:get/get.dart';
import '../models/task.dart';

class TaskController extends GetxController {
  @override
  void onReady() {
    getTasks();
    super.onReady();
  }

  var tasklist = <Task>[].obs;

  Future<int> addTask({Task? task}) async {
    return await DbHelper.insert(task);
  }

  void getTasks() async {
    List<Map<String, dynamic>> tasks = await DbHelper.query();
    tasklist.assignAll(tasks.map((data) => new Task.fromJson(data)).toList());
  }

  void delete(Task task) {
    var val = DbHelper.delete(task);
    getTasks();
  }

  Future<void> markTaskCompleted(int id) async {
    await DbHelper.update(id);
    getTasks();
  }
}
