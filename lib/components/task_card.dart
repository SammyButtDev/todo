import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/screens/modules/home/home_controller.dart';
import 'package:todo/utilis/extensions.dart';
import '../screens/modules/home/home_model.dart';

class TaskCard extends GetView<HomeController> {
  final Task task;

  const TaskCard({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = HexColor.fromHex(task.color);

    return InkWell(
      onTap: () {
        controller.changeTask(task);
        controller.changeTodos(task.todos ?? []);
        Get.toNamed('/detail');
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(15),),color: color.withOpacity(0.3),),

        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            StepProgressIndicator(
              totalSteps:
                  controller.isToDosEmpty(task) ? 1 : task.todos!.length,
              currentStep: controller.isToDosEmpty(task)
                  ? 0
                  : controller.getDoneTodo(task),
              size: 5,
              padding: 0,
              unselectedGradientColor: const LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [Colors.white, Colors.white],
              ),
              selectedGradientColor: LinearGradient(
                end: Alignment.bottomRight,
                begin: Alignment.topLeft,
                colors: [Colors.white.withOpacity(0.5), color, color],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                IconData(
                  task.icon,
                  fontFamily: 'MaterialIcons',
                ),
                color: color,
                size: 30,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(task.title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24,),),
                  SizedBox(height: 20,),
                  Text('${task.todos?.length ?? 0} Task',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,),),
                ],
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
