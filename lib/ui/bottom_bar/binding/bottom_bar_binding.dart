import 'package:get/get.dart';
import 'package:drama_chaska/ui/bottom_bar/controller/bottom_bar_controller.dart';
import 'package:drama_chaska/ui/earn_reward_page/controller/earn_reward_controller.dart';
import 'package:drama_chaska/ui/home_page/controller/home_controller.dart';
import 'package:drama_chaska/ui/profile_page/controller/profile_controller.dart';
import 'package:drama_chaska/ui/reels_page/controller/reels_controller.dart';
import 'package:drama_chaska/ui/refill/controller/refill_controller.dart';

class BottomBarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BottomBarController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ReelsController(), fenix: true);
    Get.lazyPut(() => ProfileController(), fenix: true);
    Get.lazyPut(() => EarnRewardController(), fenix: true);
    Get.put(RefillController());
  }
}
