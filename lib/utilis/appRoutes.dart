import 'package:get/get.dart';
import 'package:todo/screens/modules/detail/detail_view.dart';
import 'package:todo/screens/modules/home/home_bind.dart';
import '../screens/modules/home/home_view.dart';
import '../screens/modules/onboard/onboard_bind.dart';
import '../screens/modules/onboard/onboard_view.dart';
import '../screens/splash_screen.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String signIn = '/signIn';
  static const String onboard = '/onboard';
  static const String home = '/home';
  static const String detail = '/detail';
}

class AppScreens {
  static const initial = Routes.splash;

  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const Splash(),
    ),
    GetPage(
      name: Routes.onboard,
      page: () => OnBoard(),
      binding: OnBoardBind(),
    ),
    GetPage(
      name: Routes.home,
      page: () => Home(),
      binding: HomeBind(),
    ),
    GetPage(
      name: Routes.detail,
      page: () => Detail(),
      binding: HomeBind(),
    ),
  ];
}
