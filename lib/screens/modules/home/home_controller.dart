import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:todo/services/repository/task_repository.dart';
import 'package:todo/utilis/values/getIcons.dart';
import 'home_model.dart';

class HomeController extends GetxController {
  TaskRepository taskRepository;
  HomeController({required this.taskRepository});
  final icons = getIcons();

  final task = Rx<Task?>(null);

  final tasks = <Task>[].obs;
  final doingToDos = <dynamic>[].obs;
  final doneToDos = <dynamic>[].obs;

  final chipIndex = 0.obs;
  final deleting = false.obs;

  final typeform = GlobalKey<FormState>();
  final taskForm = GlobalKey<FormState>();
  final detailForm = GlobalKey<FormState>();

  final TextEditingController typeCont = TextEditingController();
  final TextEditingController taskCont = TextEditingController();
  final TextEditingController detailCont = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tasks.assignAll(taskRepository.readTask());
    ever(tasks, (_) => taskRepository.writeTask(tasks));
  }

  @override
  void onClose() {
    // TODO: implement onClose
    typeCont.dispose();
    super.onClose();
  }

  void changeIndex(int value) {
    chipIndex.value = value;
  }

  void changeDelete(bool value) {
    deleting.value = value;
  }

  void changeTask(Task? select) {
    task.value = select;
  }

  void changeTodos(List<dynamic> select) {
    doingToDos.clear();
    doneToDos.clear();
    for (int i = 0; i < select.length; i++) {
      var todo = select[i];
      var status = todo['done'];
      if (status == true) {
        doneToDos.add(todo);
      } else {
        doingToDos.add(todo);
      }
    }
  }

  void deleteTask(Task selTask) {
    tasks.remove(selTask);
  }

  bool addTask(Task task) {
    if (tasks.contains(task)) {
      return false;
    }
    tasks.add(task);
    return true;
  }

  updateTask(Task task, String title) {
    var todos = task.todos ?? [];
    if (containedTodo(todos, title)) {
      return false;
    }
    var todo = {'title': title, 'done': false};
    todos.add(todo);
    var newTask = task.copyWith(todos: todos);
    int oldIdx = tasks.indexOf(task);
    tasks[oldIdx] = newTask;
    tasks.refresh();
    return true;
  }

  bool containedTodo(List<dynamic> todos, String title) {
    return todos.any((element) => element['title'] == title);
  }

  bool addTodo(String title) {
    var todo = {'title': title, 'done': false};
    if (doneToDos.any(
      (element) => mapEquals<String, dynamic>(todo, element),
    )) {
      return false;
    }
    var doneTodo = {'title': title, 'done': true};

    if (doneToDos
        .any((element) => mapEquals<String, dynamic>(doneTodo, element))) {
      return false;
    }
    doingToDos.add(todo);
    return true;
  }

  void updateTodos() {
    var newTodos = <Map<String, dynamic>>[];
    newTodos.addAll([
      ...doingToDos,
      ...doneToDos,
    ]);
    var newTask = task.value!.copyWith(todos: newTodos);
    int oldIdx=tasks.indexOf(task.value!);
    tasks[oldIdx]= newTask;
    tasks.refresh();
  }

  void doneTodo(String title){
    var doingTodo = {'title':title,'done':false};
    int index = doingToDos.indexWhere((element) => mapEquals<String,dynamic>(doingTodo, element));
    doingToDos.removeAt(index);
    var doneTodo={'title':title,'done':true};
    doneToDos.add(doneTodo);
    doingToDos.refresh();
    doingToDos.refresh();
  }

  deleteDoneToDo(dynamic doneTodo) {
    int index = doneToDos.indexWhere((element) => mapEquals<String,dynamic>(doneTodo,element ));
    doneToDos.removeAt(index);
    doneToDos.refresh();
  }

  bool isToDosEmpty(Task task){
    return task.todos == null || task.todos!.isEmpty;
  }
  int getDoneTodo(Task task){
    var res = 0;
    for(int i =0;i<task.todos!.length;i++){
      if(task.todos![i]['done']==true){
        res +=i;
      }
    }
    return res;
  }

}
