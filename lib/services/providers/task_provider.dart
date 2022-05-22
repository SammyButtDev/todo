import 'dart:convert';

import 'package:get/get.dart';
import 'package:todo/screens/modules/home/home_model.dart';
import 'package:todo/services/storage_services.dart';
import 'package:todo/utilis/keys.dart';

class TaskProvider{
   final _storage = Get.find<StorageService>();

  List<Task> readTask(){
    var tasks =<Task>[];
    jsonDecode(_storage.read(taskKey).toString()).forEach((e)=>tasks.add(Task.fromJson(e)));
    return tasks;
  }

  void  writeTask(List<Task>tasks){
  _storage.write(taskKey, jsonEncode(tasks));
  }
}