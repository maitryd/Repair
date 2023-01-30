import 'package:get/get.dart';

enum BnbItem {repair, shop, cart, booking, more}
class BottomNavController extends GetxController {
  static BottomNavController get to => Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  var currentPage = BnbItem.repair.obs;
  void changePage(BnbItem bnbItem) {
    print("name:${bnbItem.name}");
    currentPage.value = bnbItem;
  }

}
