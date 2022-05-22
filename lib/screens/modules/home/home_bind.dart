import 'package:get/get.dart';
import 'package:todo/services/providers/task_provider.dart';
import 'package:todo/services/repository/task_repository.dart';
import 'home_controller.dart';

class HomeBind extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(
        taskRepository: TaskRepository(
          taskProvider: TaskProvider(),
        ),
      ),
    );
  }
}
