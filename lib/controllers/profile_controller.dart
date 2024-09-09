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

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // Remove the login status
    await prefs.remove('isLoggedIn');
    Get.offAll(const Login());
  }
}


 

