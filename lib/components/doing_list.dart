import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens/modules/home/home_controller.dart';

class DoingList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Obx(
      () => controller.doingToDos.isEmpty && controller.doneToDos.isEmpty
          ? Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset(
                  "assets/screen2.jpg",
                  fit: BoxFit.cover,
                  width: 150,
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text("Add Task"),
              ],
            )
          : ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                ...controller.doingToDos
                    .map(
                      (element) => CheckboxListTile(
                          title: Text(element['title'],),
                          value: element['done'],
                          onChanged: (value) {
                            controller.doneTodo(element['title']
                            );
                          }),
                    )
                    .toList(),
              ],
            ),
    );
  }
}
