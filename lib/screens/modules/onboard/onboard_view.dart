import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboard_controller.dart';
import 'onboard_model.dart';

class OnBoard extends GetView<OnboardController> {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SizedBox(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                  children: [
                    OnBoardCust(
                        image: 'assets/screen1.jpg',
                        detail: "Plan your day with ease",
                        title: "Easy to Create segments"),
                    OnBoardCust(
                        image: 'assets/screen2.jpg',
                        detail: "Always have a check on all your activity",
                        title: "Improve your day with style"),
                    OnBoardCust(
                        image: '',
                        detail:
                            "Increase your productivity by managing your personal and team task and do them based on the highest priority",
                        title: "Manage everything with one hand"),
                  ],
                  controller: controller.pageController,
                  onPageChanged: (int index) {
                    controller.currentIndex.value = index;
                  }),
            ),
            SizedBox(
              height: 100,
              child: Center(
                child: Obx(
                  ()=> IndicatorBar(
                    currentIndex: controller.currentIndex.value,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
