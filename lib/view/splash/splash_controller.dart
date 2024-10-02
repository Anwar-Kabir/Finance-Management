import 'package:get/get.dart';
import 'package:personal_finance_managemnt/view/home/app_bottom_navigation.dart';
import 'package:personal_finance_managemnt/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  var textOpacity = 0.0.obs;
  var imageOpacity = 0.0.obs;
  var indicatorOpacity = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _startSplashScreenSequence();
  }

  Future<void> _startSplashScreenSequence() async {
    // Perform the animations sequentially
    await _performSplashAnimations();

    // Check if the user is logged in
    await _checkLoginStatus();
  }
  

   // Animate the image opacity
  Future<void> _performSplashAnimations() async {
   
    await Future.delayed(const Duration(milliseconds: 500));
    imageOpacity.value = 1.0;

     
    await Future.delayed(const Duration(milliseconds: 500));
    textOpacity.value = 1.0;

    
    await Future.delayed(const Duration(milliseconds: 500));
    indicatorOpacity.value = 1.0;
  }


  //login check SharedPreferences
  Future<void> _checkLoginStatus() async {
    
    await Future.delayed(const Duration(seconds: 2));

   
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAll(() => const AppBottomNavigationBar());
    } else {
      Get.offAll(() => const Login());
    }
  }

 
}



  
