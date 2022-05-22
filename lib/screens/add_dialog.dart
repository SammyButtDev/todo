import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/modules/home/home_controller.dart';
import 'package:todo/utilis/extensions.dart';

class AddDialog extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: controller.taskForm,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                        controller.taskCont.clear();
                        controller.changeTask(null);
                      },
                      icon: const Icon(
                        CupertinoIcons.clear,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.taskForm.currentState!.validate()) {
                          if (controller.task.value == null) {
                            Get.snackbar("Error", "Please select task type");
                          } else {
                            var success = controller.updateTask(
                                controller.task.value!, controller.taskCont.text);

                            if (success) {
                              Get.snackbar("Sucess", "ToDo item is added");
                             Navigator.pop(context);
                              controller.changeTask(null);
                              controller.taskCont.clear();

                            } else {
                              Get.snackbar("Error", "Item already added");
                              controller.taskCont.clear();
                            }
                          }
                        }
                      },
                      child: const Text("Done",style: TextStyle(color: Colors.indigo),),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "New Task",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: TextFormField(
                    controller: controller.taskCont,
                    decoration: InputDecoration(
                      hintText: "To Do item",
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400),
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
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  thickness: 2,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Add To",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 10,
                ),
                ...controller.tasks
                    .map((element) => Obx(
                          () => InkWell(
                            onTap: () => controller.changeTask(element),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        IconData(
                                          element.icon,
                                          fontFamily: 'MaterialIcons',
                                        ),size: 30,
                                        color: HexColor.fromHex(element.color),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(element.title,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                                    ],
                                  ),
                                  if (controller.task.value == element)
                                    const Icon(
                                      Icons.check,
                                      color: CupertinoColors.systemGreen,
                                    )
                                ],
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
