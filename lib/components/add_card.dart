import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/modules/home/home_model.dart';
import 'package:todo/utilis/extensions.dart';
import '../screens/modules/home/home_controller.dart';

class AddCard extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      splashColor: Colors.indigo,
      onTap: () {
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
      },
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
            color: CupertinoColors.systemIndigo.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Colors.white.withOpacity(0.8),),),
        child: const Center(
          child: Icon(Icons.add,size: 80,color: Colors.white,),
        ),
      ),
    );
  }
}
