import 'package:get/get.dart';
import 'package:drama_chaska/ui/earn_reward_page/controller/earn_reward_controller.dart';

class EranRewardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EarnRewardController());
  }
}
