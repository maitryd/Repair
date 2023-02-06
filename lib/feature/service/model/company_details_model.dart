import 'package:get/get.dart';

class CompanyDetails{
  var isSelected = false.obs;
  final String companyIcon;
  final String companyName;
  final String description;
  final String order;
  final String rating;

  CompanyDetails(
      {required this.isSelected,
        required this.companyIcon,
        required this.companyName,
        required this.description,
        required this.order,
        required this.rating});
}