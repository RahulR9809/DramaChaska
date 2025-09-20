import 'package:get/get.dart';
import 'package:drama_chaska/ui/search_page/controller/search_screen_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchScreenController());
  }
}
