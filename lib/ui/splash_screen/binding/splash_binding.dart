import 'package:get/get.dart';
import 'package:drama_chaska/ui/splash_screen/controller/splash_controller.dart';

class SplashScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashScreenController());
  }
}
