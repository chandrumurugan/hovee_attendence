import 'package:get/get.dart';

class DashboardController extends GetxController {
  // Index of the currently selected bottom navigation tab
  var selectedIndex = 0.obs;

  // Update the selected index
  void changeTabIndex(int index) {
    selectedIndex.value = index;
  }
}