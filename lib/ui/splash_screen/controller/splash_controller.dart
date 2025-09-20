import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:drama_chaska/routes/app_routes.dart';
import 'package:drama_chaska/ui/login_page/model/login_user_model.dart';
import 'package:drama_chaska/ui/profile_page/api/profile_api.dart';
import 'package:drama_chaska/utils/branch_io_services.dart';
import 'package:drama_chaska/utils/preference.dart';
import '../../../notification/notification_service.dart';
import '../../../utils/utils.dart';

class SplashScreenController extends GetxController {
  bool isLoading = false;
  LoginUserModel? loginUserModel;

  @override
  Future<void> onInit() async {
    NotificationServices.initFirebase();
    Future.delayed(const Duration(seconds: 4), () async {
      if (Preference.isLogin) {
        BranchIoServices.onListenBranchIoLinks();
        Get.offAllNamed(AppRoutes.bottomBarPage);
      } else {
        Get.offAllNamed(AppRoutes.login);
      }
    });

    log("Preference.isLogin${Preference.isLogin}");
    loginUserModel = await ProfileApi.callApi();

    if (loginUserModel?.message == "User does not found!") {
      Utils.showToast(Get.context!, "User does not found!");
      Preference.clear();
      Preference.clearWatchedVideos();
      GoogleSignIn().signOut();
      log("not found");
      Get.offAllNamed(AppRoutes.login);

      return;
    }
    super.onInit();
  }
}


// class SplashScreenController extends GetxController {
//   bool isLoading = false;
//   LoginUserModel? loginUserModel;

//   @override
//   Future<void> onInit() async {
//     NotificationServices.initFirebase();
//     super.onInit();
//   }

//   /// Call this from SplashScreenView after 4s of video
//   Future<void> goNext() async {
//     if (Preference.isLogin) {
//       BranchIoServices.onListenBranchIoLinks();
//       Get.offAllNamed(AppRoutes.bottomBarPage);
//     } else {
//       Get.offAllNamed(AppRoutes.login);
//     }

//     log("Preference.isLogin ${Preference.isLogin}");
//     loginUserModel = await ProfileApi.callApi();

//     if (loginUserModel?.message == "User does not found!") {
//       Utils.showToast(Get.context!, "User does not found!");
//       Preference.clear();
//       Preference.clearWatchedVideos();
//       GoogleSignIn().signOut();
//       log("not found");
//       Get.offAllNamed(AppRoutes.login);
//     }
//   }
// }
