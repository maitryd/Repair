import 'package:demandium/feature/service/model/company_details_model.dart';
import 'package:demandium/utils/images.dart';
import 'package:get/get.dart';

class CompanyDetailController extends GetxController{
  List<CompanyDetails> list = [];

  @override
  void onInit() {
    super.onInit();
    List.generate(20,
            (index) => list.add(
              CompanyDetails(isSelected: false.obs, companyIcon: '$index', companyName: '$index', description: '$index', order: '$index', rating: '$index')));
  }
}