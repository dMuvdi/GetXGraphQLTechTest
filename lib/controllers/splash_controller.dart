import 'package:get/get.dart';

import '../screens/navigation_screen.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    startApp();
  }

  Future<void> startApp() async {
    await Future.delayed(const Duration(seconds: 2));
    Get.off(() => const NavigationScreen(), transition: Transition.fade);
  }
}