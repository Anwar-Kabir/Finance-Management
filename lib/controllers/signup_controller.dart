import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/view/login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
  // Variables
  var obscurePassword = true.obs;
  var isAgreed = false.obs;
  var isButtonEnabled = false.obs;

  // Form validation key
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Text controllers for email and password fields
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Email validation
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

  // Password validation
  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  // Update agreement status
  void updateAgreement(bool? value) {
    isAgreed.value = value ?? false;
    updateButtonState();
  }

  // Update button state based on form and agreement
  void updateButtonState() {
    isButtonEnabled.value =
        isAgreed.value && formKey.currentState?.validate() == true;
  }

  //===>
  void onFieldChanged() {
    formKey.currentState?.validate();
    
    updateButtonState();
  }

  // Handle the sign-up logic
  Future<void> handleSignup() async {
    if (formKey.currentState!.validate() && isAgreed.value) {
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);

     
      Get.snackbar("Success", "Sign up successful!", backgroundColor: Colors.green, colorText: Colors.white);

      
      Get.offAll(const Login());
    } else {
       
      Get.snackbar("Error", "Please complete the form", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  
}
