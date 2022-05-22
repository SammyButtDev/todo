import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/components/add_card.dart';
import 'package:todo/components/task_card.dart';
import 'package:todo/screens/add_dialog.dart';
import 'package:todo/screens/modules/home/home_model.dart';
import 'package:todo/utilis/extensions.dart';

import 'home_controller.dart';

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: FloatingActionButton.extended(onPressed: (){
                Get.bottomSheet(
                    Container(
                      height: 350,
                      decoration:  BoxDecoration(
                        color: Colors.indigo.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Form(
                        key: controller.typeform,
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: Icon(CupertinoIcons.clear),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10.0),
                                  child: Text(
                                    "Task Type",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (controller.typeform.currentState!.validate()) {
                                      int icon = controller
                                          .icons[controller.chipIndex.value]
                                          .icon!
                                          .codePoint;
                                      String color = controller
                                          .icons[controller.chipIndex.value].color!
                                          .toHex();
                                      var task = Task(
                                          title: controller.typeCont.text,
                                          color: color,
                                          icon: icon);
                                      print(color);
                                      controller.addTask(task)
                                          ? Get.snackbar("Success", "Task Type Created")
                                          : Get.snackbar(
                                          "Error", "Unable to Create the Tas");
                                      Navigator.pop(context);

                                    }
                                    controller.typeCont.clear();
                                  },
                                  icon: Icon(CupertinoIcons.check_mark),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                controller: controller.typeCont,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  border: OutlineInputBorder(),
                                  labelText: "Title",
                                ),
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Enter your Task title";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Wrap(
                              spacing: 5.0.sp,
                              children: controller.icons
                                  .map(
                                    (e) => Obx(
                                      () {
                                    final index = controller.icons.indexOf(e);

                                    return ChoiceChip(
                                      selectedColor: Colors.black,
                                      backgroundColor: Colors.grey.shade300,
                                      pressElevation: 0,
                                      label: e,
                                      selected: controller.chipIndex.value == index,
                                      onSelected: (bool selected) {
                                        controller.chipIndex.value =
                                        selected ? index : 0;
                                      },
                                    );
                                  },
                                ),
                              )
                                  .toList(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    backgroundColor: Colors.white.withOpacity(0.1),
                    isDismissible: false,
                    enableDrag: false);
                controller.typeCont.clear();
                controller.changeIndex(0);
              }, label: Text("Task Type"),backgroundColor: Colors.indigo,),
            ),
            DragTarget<Task>(builder: (a, b, c) {
              return Obx(
                () => FloatingActionButton(
                  onPressed: () {
                    if(controller.tasks.isNotEmpty){
                      Get.to(()=>AddDialog(),transition: Transition.downToUp);

                    }else{
                      Get.snackbar("Task Type", "Please Create your Task Type",);
                    }
                  },
                  child: Icon(
                    controller.deleting.value ? Icons.delete : Icons.add,
                  ),
                  backgroundColor: controller.deleting.value
                      ? CupertinoColors.destructiveRed
                      : Colors.indigo,
                ),
              );
            },onAccept: (Task task){
              controller.deleteTask(task);
              Get.snackbar("Success", "Task Deleted");
            },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0),
            child: ListView(
              children: [
                Text(
                  "TO DO",
                  style: TextStyle(fontSize: 24.0.sp, color: Colors.black),
                ),
                Obx(
                  () => GridView.count(
                    physics: const ClampingScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,mainAxisSpacing: 10,
                    shrinkWrap: true,
                    children: [
                      ...controller.tasks
                          .map(
                            (element) => LongPressDraggable(
                              data: element,
                              onDragStarted: () => controller.changeDelete(true),
                              onDragEnd: (
                                _,
                              ) =>
                                  controller.changeDelete(false),
                              onDraggableCanceled: (_, i) =>
                                  controller.changeDelete(false),
                              feedback: Opacity(
                                opacity: 0.8,
                                child: Material(child: TaskCard(task: element)),
                              ),
                              child: TaskCard(task: element),
                            ),
                          )
                          .toList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
