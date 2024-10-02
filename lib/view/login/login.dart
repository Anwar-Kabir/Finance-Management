import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/controllers/login_controller.dart';
import 'package:personal_finance_managemnt/utils/app_strings.dart';
import 'package:personal_finance_managemnt/view/home/app_bottom_navigation.dart';
import 'package:personal_finance_managemnt/view/signup/signup.dart';
import 'package:personal_finance_managemnt/view/widget/custom_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
  // Initialize the controller
  final LoginController _loginController = LoginController();

  @override
  void dispose() {

    _loginController.dispose();
    super.dispose();
  }

  // Handle login logic
  Future<void> _handleLogin() async {
    if (_loginController.validateForm()) {
      bool isValid = await _loginController.checkCredentials();
      if (isValid) {

        final prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);

        Get.off(() => const AppBottomNavigationBar());
        Get.snackbar("Success", "Login Successful", backgroundColor: Colors.green, colorText: Colors.white);
      } else {

        Get.snackbar("Error", "Invalid email or password", backgroundColor: Colors.red, colorText: Colors.white);
      }
    } else {

      Get.snackbar("Error", "Please complete the form", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _loginController.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 100),
              const Text(
                'Login',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 40),

              const Row(
                children: [
                  Text(
                    AppStrings.email,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              // Custom Text Field for Email
              CustomTextField(
                labelText: 'Email',
                controller: _loginController.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _loginController.validateEmail,
                onChanged: (_) {
                  //_loginController.formKey.currentState?.validate();
                },
              ),
              const SizedBox(height: 20),

              const Row(
                children: [
                  Text(
                    AppStrings.password,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    "*",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),

              // Custom Text Field for Password
              CustomTextField(
                labelText: 'Password',
                controller: _loginController.passwordController,
                isObscure: _loginController.obscurePassword,
                onChanged: (_) {
                  //_loginController.formKey.currentState?.validate();
                },
                suffixIcon: _loginController.obscurePassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                onSuffixTap: () {
                  setState(() {
                    _loginController.togglePasswordVisibility();
                  });
                },
                validator: _loginController.validatePassword,
              ),
              const SizedBox(height: 30),

              // Login button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color(0xFF7F56D9), // Purple button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Don't have an account
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Don’t have an account yet? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: 'Sign Up',
                          style: const TextStyle(
                            color: Color(0xFF7F56D9),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(Signup());
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

 