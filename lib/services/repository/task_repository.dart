import 'package:todo/screens/modules/home/home_model.dart';
import 'package:todo/services/providers/task_provider.dart';

class TaskRepository{
  TaskProvider taskProvider;
  TaskRepository({required this.taskProvider});

  List<Task> readTask()=> taskProvider.readTask();
  void writeTask(List<Task>tasks)=>taskProvider.writeTask(tasks);
}