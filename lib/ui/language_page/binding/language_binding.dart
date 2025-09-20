import 'package:get/get.dart';
import 'package:drama_chaska/ui/language_page/controller/language_controller.dart';

class LanguageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageScreenController>(() => LanguageScreenController());
  }
}
