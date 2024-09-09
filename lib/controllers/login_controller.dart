import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/view/home/app_bottom_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  bool obscurePassword = true;
  final formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
  }

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  Future<bool> checkCredentials() async {
    // For simplicity, stored credentials are being checked
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email') ?? '';
    final savedPassword = prefs.getString('password') ?? '';

    return emailController.text == savedEmail &&
        passwordController.text == savedPassword;
  }

  Future<void> login() async {
    if (validateForm()) {
      bool isValid = await checkCredentials();
      if (isValid) {
        // Set 'isLoggedIn' to true in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('email', emailController.text);
        await prefs.setString('password', passwordController.text);

        // Navigate to Home screen
        Get.offAll(const AppBottomNavigationBar());
      } else {
        Get.snackbar("Error", "Invalid email or password");
      }
    }
  }
}




 
