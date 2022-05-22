import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/screens/modules/home/home_controller.dart';

class DoneList extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.doneToDos.isNotEmpty
        ? ListView(
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Text("Completed (${controller.doneToDos.length})"),
              ...controller.doneToDos
                  .map(
                    (element) => Dismissible(
                      key:  ObjectKey(element),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: CupertinoColors.destructiveRed,
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (_) => controller.deleteDoneToDo(element),
                      child: CheckboxListTile(
                          checkColor: Colors.blue,
                          activeColor: Colors.transparent,
                          title: Text(element['title'],style:TextStyle(decoration: TextDecoration.lineThrough,),),
                          value: element['done'],
                          onChanged: (value) {
                            controller.doneTodo(element['title']);
                          }),
                    ),
                  )
                  .toList(),
            ],
          )
        : const SizedBox());
  }
}
