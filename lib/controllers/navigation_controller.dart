import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Active index of the bottom navigation bar
  var selectedIndex = 0.obs;

  // Update the selected index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}
