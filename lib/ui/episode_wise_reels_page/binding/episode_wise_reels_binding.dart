import 'package:get/get.dart';
import 'package:drama_chaska/ui/episode_wise_reels_page/controller/episode_wise_reels_controller.dart';

class EpisodeWiseReelsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EpisodeWiseReelsController>(() => EpisodeWiseReelsController());
  }
}
