import 'package:flutter/material.dart';

class CompanyDetails{
  final String companyIcon;
  final String companyName;
  final String description;
  final String order;
  final String rating;

  CompanyDetails(
    this.companyIcon,
    this.companyName,
    this.description,
    this.order,
    this.rating
  );
}

class CompanyDetailsModelProvider with ChangeNotifier {
  List<CompanyDetails> get itemList{
    return _companyList;
  }

  final List<CompanyDetails> _companyList = [];

  void createList(CompanyDetails lineitems){
    // final newtask = CompanyDetails(
    //   lineitems.companyIcon,
    //   lineitems.companyName,
    //   lineitems.description,
    //   lineitems.order,
    //   lineitems.rating,);
    // _companyList.add(newtask);
    notifyListeners();
  }

  void clear(){
    _companyList.clear();
    notifyListeners();
  }

  void delete(int index){
    _companyList.removeAt(index);
    notifyListeners();
  }
}