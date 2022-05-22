import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:todo/components/doing_list.dart';
import 'package:todo/components/done_list.dart';
import 'package:todo/screens/modules/home/home_controller.dart';
import 'package:todo/utilis/extensions.dart';

class Detail extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    var task = controller.task.value;
    var color = HexColor.fromHex(task!.color);
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: controller.detailForm,
          child: ListView(
            shrinkWrap: true,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                      controller.updateTodos();
                      controller.changeTask(null);
                      controller.detailCont.clear();
                    },
                    icon: const Icon(
                      CupertinoIcons.back,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  children: [
                    Icon(
                      IconData(
                        task.icon,
                        fontFamily: 'MaterialIcons',
                      ),
                      color: color,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(task.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.normal),),
                  ],
                ),
              ),
              Obx(
                () {
                  var totalTodos = controller.doingToDos.length +
                      controller.doneToDos.length;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text('$totalTodos Tasks',style: TextStyle(fontWeight: FontWeight.w400,fontSize: 19),),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: StepProgressIndicator(
                            totalSteps: totalTodos == 0 ? 1 : totalTodos,
                            currentStep: controller.doneToDos.length,
                            size: 8,
                            unselectedGradientColor: LinearGradient(
                              end: Alignment.bottomRight,
                              begin: Alignment.topLeft,
                              colors: [
                                Colors.grey.shade300,
                                Colors.grey.shade300
                              ],
                            ),
                            selectedGradientColor: LinearGradient(
                              end: Alignment.bottomRight,
                              begin: Alignment.topLeft,
                              colors: [
                                Colors.white.withOpacity(0.5),
                                color,
                                color
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextFormField(
                  controller: controller.detailCont,
                  decoration: InputDecoration(
                    hintText: "To Do item",
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    prefixIcon: Icon(
                      Icons.check_box_outline_blank_outlined,
                      color: Colors.grey.shade300,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () {
                        if(controller.detailForm.currentState!.validate()){
                          var success = controller.addTodo(controller.detailCont.text);
                          if(success){
                            Get.snackbar("Success", "ToDo item is added");
                          }
                          else{
                            Get.snackbar("Exists", "ToDo item already exists");
                          }
                          controller.detailCont.clear();
                        }
                         },
                      icon: const Icon(
                        CupertinoIcons.check_mark,
                        color: CupertinoColors.systemGreen,
                      ),
                    ),
                  ),
                  autofocus: true,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Enter your todo item";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DoingList(),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DoneList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
