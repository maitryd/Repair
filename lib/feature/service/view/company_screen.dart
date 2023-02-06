import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/service/controller/company_details_controller.dart';
import 'package:demandium/feature/service/controller/company_details_tab_controller.dart';
import 'package:demandium/feature/service/controller/companydetails.dart';
import 'package:demandium/feature/service/view/Selected_Company.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CompanyScreen extends StatefulWidget {
  final String serviceID;
  const CompanyScreen({Key? key, required this.serviceID}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();
  final selectedCompanyController = Get.put(SelectedCompany());

  // late List<CompanyDetails> itemList = [
  //   CompanyDetails(Images.companyLogo, "SIYANCO", "Test and identify problems and repair with expert and experienced electricians", "4 Successful Order", "0.00"),
  //   CompanyDetails(Images.companyLogo, "SIYANCO", "Test and identify problems and repair with expert and experienced electricians", "3 Successful Order", "0.00"),
  //   CompanyDetails(Images.companyLogo, "SIYANCO", "Test and identify problems and repair with expert and experienced electricians", "6 Successful Order", "0.00"),
  //   CompanyDetails(Images.companyLogo, "SIYANCO", "Test and identify problems and repair with expert and experienced electricians", "4 Successful Order", "0.00"),
  // ];


  // List<CompanyDetails> initComDetails = [];

  // void showMultiSelect(BuildContext context) async{
  //   await showDialog(
  //       context: context,
  //       builder: (ctx) {
  //         return MultiSelectDialog(
  //             items: itemList.map((e) => MultiSelectItem<CompanyDetails>(e, e.companyName)).toList(),
  //             initialValue: initComDetails);
  //       });
  // }

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        int pageSize = Get.find<CompanyTabController>().pageSize??0;
        if (Get.find<CompanyTabController>().offset! < pageSize) {
          Get.find<CompanyTabController>().getServiceReview(widget.serviceID, Get.find<CompanyTabController>().offset!+1);
        }}
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(centerTitle: false, title: 'Select Companies'.tr,showCart: true,),
      body: GetBuilder<CompanyDetailsController>(
          initState: (state) {
            Get.find<CompanyDetailsController>().getServiceDetails(widget.serviceID);},
          builder: (serviceController) {
            if(serviceController.service != null){
              if(serviceController.service!.id != null){
                Service? service = serviceController.service;
                Discount _discount = PriceConverter.discountCalculation(service!);
                double _lowestPrice = 0.0;
                if(service.variationsAppFormat!.zoneWiseVariations != null){
                  _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!.toDouble();
                  for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
                    if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
                      _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!.toDouble();
                    }
                  }
                }
                return  FooterBaseView(
                  isScrollView:ResponsiveHelper.isMobile(context) ? false: true,
                  child: SizedBox(
                    width: Dimensions.WEB_MAX_WIDTH,
                    child: DefaultTabController(
                      length: Get.find<CompanyDetailsController>().service!.faqs!.length > 0 ? 3 :2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if(!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context))
                            SizedBox(height: Dimensions.PADDING_SIZE_DEFAULT,),
                          Stack(
                            children: [
                              Column(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.all((!ResponsiveHelper.isMobile(context) && !ResponsiveHelper.isTab(context)) ?  Radius.circular(8): Radius.circular(0.0)),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                            child: CustomImage(
                                              image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.coverImage}',
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Container(
                                            width: Dimensions.WEB_MAX_WIDTH,
                                            height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                            decoration: BoxDecoration(
                                                color: Colors.black.withOpacity(0.6)
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: Dimensions.WEB_MAX_WIDTH,
                                          height: ResponsiveHelper.isDesktop(context) ? 280:150,
                                          child: Center(child: Text(service.name ?? '',
                                              style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.white))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Expanded(
                            child: Center(
                              child: Container(
                                height: MediaQuery.of(context).size.height,
                                width: Get.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                            child: selectedCompanyController.build(context))
                                      ]),
                                )
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return NoDataScreen(text: 'no_service_available'.tr,type: NoDataType.SERVICE,);
              }
            }else{
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
