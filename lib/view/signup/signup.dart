import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/controllers/signup_controller.dart';
import 'package:personal_finance_managemnt/utils/app_strings.dart';
import 'package:personal_finance_managemnt/view/login/login.dart';
import 'package:personal_finance_managemnt/view/widget/custom_text_field.dart';

class Signup extends StatelessWidget {
  Signup({super.key});

  // Initialize the controller using GetX
  final SignupController _controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Form(
          key: _controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 30),
              const Text(
                'Sign Up',
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

              // Email TextField
              CustomTextField(
                labelText: 'Email',
                controller: _controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: _controller.validateEmail,
                 onChanged: (value) {
                  _controller.onFieldChanged();
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

              // Password TextField with toggle visibility
              Obx(() => CustomTextField(
                    labelText: 'Password',
                    controller: _controller.passwordController,
                    isObscure: _controller.obscurePassword.value,
                    suffixIcon: _controller.obscurePassword.value
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onSuffixTap: () {
                      _controller.togglePasswordVisibility();
                    },
                    validator: _controller.validatePassword,
                    onChanged: (value) {
                      _controller.onFieldChanged();
                    },
                  )),
              const SizedBox(height: 20),

              // Terms and Conditions checkbox
              Obx(() => Row(
                    children: [
                      Checkbox(
                        value: _controller.isAgreed.value,
                        onChanged: (bool? value) {
                          _controller.updateAgreement(value);
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        activeColor: const Color(0xFF7F56D9),
                      ),
                      const Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: 'By signing up, you agree to the ',
                            style: TextStyle(color: Colors.grey),
                            children: [
                              TextSpan(
                                text: 'Terms of Service ',
                                style: TextStyle(
                                  color: Color(0xFF7F56D9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'and ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(
                                  color: Color(0xFF7F56D9),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 20),

              // Sign up button
              Obx(() => SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: _controller.isButtonEnabled.value
                          ? () {
                              _controller.handleSignup();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _controller.isButtonEnabled.value
                            ? const Color(0xFF7F56D9)  
                            : Colors.grey, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  )),
              const SizedBox(height: 20),

              // Already have an account? Login
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "Already have an account? ",
                    style: const TextStyle(color: Colors.grey),
                    children: [
                      TextSpan(
                          text: 'Login',
                          style: const TextStyle(
                            color: Color(0xFF7F56D9),
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(const Login());
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

