import 'package:get/get.dart';

enum BnbItem {Repair, Shop, Cart, Booking, More}
class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  var currentPage = BnbItem.Repair.obs;
  void changePage(BnbItem bnbItem) {
    print("name:${bnbItem.name}");
    currentPage.value = bnbItem;
  }

}
