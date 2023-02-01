import 'package:demandium/components/custom_app_bar.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/feature/service/controller/service_details_tab_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyScreen extends StatefulWidget {
  // final String serviceID;
  const CompanyScreen({Key? key}) : super(key: key);
  //const CompanyScreen({Key? key, required this.serviceID}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {

  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<ServiceTabController>().pageSize??0;
        // if (Get.find<ServiceTabController>().offset! < pageSize) {
        //   Get.find<ServiceTabController>().getServiceReview(widget.serviceID, Get.find<ServiceTabController>().offset!+1);
        // }
        }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldState,
        endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
        appBar: CustomAppBar(centerTitle: false, title: 'Select Companies'.tr,showCart: true,),
        body: Container(child: Text("hello"),)
    );
  }
}
