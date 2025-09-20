


// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:drama_chaska/ui/splash_screen/controller/splash_controller.dart';
// import 'package:drama_chaska/utils/asset.dart';
// import 'package:drama_chaska/utils/color.dart';


// class SplashScreenView extends StatefulWidget {
//   const SplashScreenView({super.key});

//   @override
//   State<SplashScreenView> createState() => _SplashScreenViewState();
// }

// class _SplashScreenViewState extends State<SplashScreenView>
//     with SingleTickerProviderStateMixin {
//   late final AnimationController _controller;
//   late final Animation<double> _animation;

//   SplashScreenController splashScreenController =
//   Get.find<SplashScreenController>();

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..repeat(reverse: true);

//     _animation = Tween<double>(begin: 1.4, end: 1.08).animate(
//       CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.colorBlack,
//       body: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           Container(
//             height: Get.height,
//             width: Get.width,
//             decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage(AppAsset.splashPlainBg),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//           Center(
//             child: ScaleTransition(
//               scale: _animation,
//               child: Image.asset(
//                 AppAsset.splashCenterIcon,
//                 width: 200,
//                 height: 200,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }





import 'package:drama_chaska/routes/app_routes.dart';
import 'package:drama_chaska/utils/preference.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:drama_chaska/ui/splash_screen/controller/splash_controller.dart';
import 'package:drama_chaska/utils/color.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});
  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

// class _SplashScreenViewState extends State<SplashScreenView> {
//   late final VideoPlayerController _videoController;
//   final SplashScreenController splashScreenController = Get.find<SplashScreenController>();
//   bool _initialized = false;

//   @override
//   void initState() {
//     super.initState();

//     _videoController = VideoPlayerController.asset('assets/video/splash.mp4')
//       ..setLooping(false)
//       ..initialize().then((_) {
//         // once initialized, update UI and start playing
//         setState(() {
//           _initialized = true;
//         });
//         _videoController.play();

//         // navigate exactly after 4 seconds
//         Future.delayed(const Duration(seconds: 4), () {
//           // Option B: direct navigation (replace route name with your route)
//           Get.offAllNamed('/home');

//           // If you'd rather keep navigation logic in the controller, implement goNext()
//           // inside your SplashScreenController and uncomment the next line:
//           // splashScreenController.goNext();
//         });
//       }).catchError((err) {
//         // handle initialization error
//         debugPrint('Video init error: $err');
//         // fallback navigation to avoid stuck splash
//         Future.delayed(const Duration(seconds: 2), () => Get.offAllNamed('/home'));
//       });
//   }

//   @override
//   void dispose() {
//     _videoController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColor.colorBlack,
//       body: _initialized
//           ? SizedBox.expand(
//               // cover the whole screen while preserving aspect ratio
//               child: FittedBox(
//                 fit: BoxFit.cover,
//                 child: SizedBox(
//                   width: _videoController.value.size.width,
//                   height: _videoController.value.size.height,
//                   child: VideoPlayer(_videoController),
//                 ),
//               ),
//             )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
// }
class _SplashScreenViewState extends State<SplashScreenView> {
  late final VideoPlayerController _videoController;
  final SplashScreenController splashScreenController = Get.find<SplashScreenController>();
  bool _initialized = false;
  bool _hasNavigated = false; // ✅ track if navigation already happened

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset('assets/video/splash.mp4')
      ..setLooping(false)
      ..initialize().then((_) {
        setState(() {
          _initialized = true;
        });
        _videoController.play();

        // Listen for video completion instead of arbitrary delay
        _videoController.addListener(() {
          if (!_hasNavigated && !_videoController.value.isPlaying && _videoController.value.position >= _videoController.value.duration) {
            _hasNavigated = true;
            // Navigate once
            Get.offAllNamed(Preference.isLogin ? AppRoutes.bottomBarPage : AppRoutes.login);
          }
        });
      }).catchError((err) {
        debugPrint('Video init error: $err');
        // fallback navigation
        if (!_hasNavigated) {
          _hasNavigated = true;
          Future.delayed(const Duration(seconds: 4), () {
            Get.offAllNamed(Preference.isLogin ? AppRoutes.bottomBarPage : AppRoutes.login);
          });
        }
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorBlack,
      body: _initialized
          ? SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _videoController.value.size.width,
                  height: _videoController.value.size.height,
                  child: VideoPlayer(_videoController),
                ),
              ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
