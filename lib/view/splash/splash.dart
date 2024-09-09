import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/utils/app_color.dart';
import 'package:personal_finance_managemnt/utils/app_image.dart';
import 'package:personal_finance_managemnt/utils/app_strings.dart';
import 'package:personal_finance_managemnt/view/splash/splash_controller.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    final SplashController splashController = Get.put(SplashController());

    // Status bar icon color change
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryBG,
      statusBarIconBrightness: Brightness.light,
    ));
    
    // No status bar icon and text
   // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

    return Scaffold(
      backgroundColor: AppColor.primaryBG,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => AnimatedOpacity(
                opacity: splashController.imageOpacity.value,
                duration: const Duration(seconds: 1),
                child: Image.asset(
                  AppImages.appLogo,
                  height: 200,
                  width: 300,
                ),
              ),
            ),
            Obx(
              () => AnimatedOpacity(
                opacity: splashController.textOpacity.value,
                duration: const Duration(seconds: 1),
                child: const Text(
                  AppStrings.appIntro,
                  style: TextStyle(fontSize: 20, color: AppColor.white),
                ),
              ),
            ),
            const SizedBox(height: 80),
            Obx(
              () => AnimatedOpacity(
                opacity: splashController.indicatorOpacity.value,
                duration: const Duration(seconds: 1),
                child: const CircularProgressIndicator(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



  