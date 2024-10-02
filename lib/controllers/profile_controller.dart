import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:personal_finance_managemnt/view/login/login.dart';

class ProfileController extends GetxController {
  RxString email = 'Loading...'.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final prefs = await SharedPreferences.getInstance();
    email.value = prefs.getString('email') ?? 'No email found';
  }


  //============================
  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   // Remove the login status
  //   await prefs.remove('isLoggedIn');
  //   Get.offAll(const Login());
  // }

  Future<void> logout() async {
    // Show Circular Progress Indicator
    Get.dialog(
      const Center(
        child: CircularProgressIndicator(),
      ),
      barrierDismissible: false,
    );

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');

    // Close the progress dialog
    Get.back();

    // Navigate to the Login page
    Get.offAll(const Login());
  }

  
}


 

