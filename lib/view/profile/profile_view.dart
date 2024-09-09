
 


  import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:personal_finance_managemnt/controllers/profile_controller.dart';
import 'package:personal_finance_managemnt/view/widget/confirm_dialog.dart';
 

class ProfileView extends StatelessWidget {
   ProfileView({super.key});
  
  final ProfileController controller = Get.put(ProfileController());
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Information
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey[600],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Email Display
            Obx(() => Text(controller.email.value)),

            const SizedBox(height: 32),

            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () => _showLogoutDialog(context),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showLogoutDialog(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return ConfirmDialog(
          title: 'Confirm Logout',
          content: 'Are you sure you want to log out?',
          confirmText: 'Logout',
          cancelText: 'Cancel',
          onConfirmed: () => controller.logout(),
        );
      },
    );

    if (shouldLogout == true) {
      controller.logout(); // Log out if the user confirmed
    }
  }
}
