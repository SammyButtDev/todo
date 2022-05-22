import 'package:get/get.dart';
import 'onboard_controller.dart';

class OnBoardBind extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<OnboardController>(
          () => OnboardController(),
    );
  }
}