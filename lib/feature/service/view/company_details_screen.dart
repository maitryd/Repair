import 'package:demandium/components/custom_app_bar.dart';
import 'package:demandium/components/custom_image.dart';
import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/helper/decorated_tab_bar.dart';
import 'package:demandium/core/helper/price_converter.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/feature/coupon/model/coupon_model.dart';
import 'package:demandium/feature/root/view/no_data_screen.dart';
import 'package:demandium/feature/service/controller/company_details_controller.dart';
import 'package:demandium/feature/service/controller/company_details_tab_controller.dart';
import 'package:demandium/feature/service/model/company_details_model.dart';
import 'package:demandium/feature/service/model/service_model.dart';
import 'package:demandium/feature/service/widget/company_overview.dart';
import 'package:demandium/feature/service/widget/empty_review_widget.dart';
import 'package:demandium/feature/service/widget/service_details_faq_section.dart';
import 'package:demandium/feature/service/widget/service_details_review.dart';
import 'package:demandium/feature/splash/controller/splash_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class CompanyDetailsScreen extends StatelessWidget {
  final company_image;
  final company_name;
  final company_rating;
  CompanyDetailsScreen({Key? key, required this.company_image, required this.company_name, required this.company_rating}) : super(key: key);

  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  late List<CompanyDetails> itemList1 = [
    //CompanyDetails(companyIcon: Images.companyLogo, companyName: "SIYANCO", description: "Test and identify problems and repair with expert and experienced electricians", order: "4 Successful Order", rating: "0.00", ),
    CompanyDetails(Images.companyLogo, "SIYANCO", "Test and identify problems and repair with expert and experienced electricians", "4 Successful Order", "0.00", ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(centerTitle: false, title: 'Company Details'.tr,showCart: true,),
      body: GetBuilder<CompanyDetailsController>(
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
                                  SizedBox(height: 120,)
                                ],
                              ),
                              Positioned(
                                  bottom: -2,
                                  left: Dimensions.PADDING_SIZE_SMALL,
                                  right: Dimensions.PADDING_SIZE_SMALL,
                                  child: Container(
                                    height: 150,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)
                                      ),
                                      child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        child: Stack(
                                          children: <Widget>[
                                            Column(
                                              children: <Widget>[
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
                                                      child: Positioned(
                                                          child: Container(
                                                            height: Dimensions.PAGES_BOTTOM_PADDING,
                                                            width: Dimensions.PAGES_BOTTOM_PADDING,
                                                            decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(10.0), color: Colors.grey
                                                            ),
                                                            child: Image.asset(
                                                              Images.companyLogo,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )),
                                                    ),
                                                    Padding(padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL)),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                          child: Text("SIYANCO United Company",
                                                            style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.bold),
                                                            maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ),
                                                        Container(
                                                          width: 240,
                                                          padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                          child: Row(
                                                            children: [
                                                              Text("Language",
                                                                style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.bold),
                                                                maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(": Arabic, English",
                                                                style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.w500),
                                                                maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Container(
                                                          padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                          child: Row(
                                                            children: [
                                                              Text("Address  ",
                                                                style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.bold),
                                                                maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                              ),
                                                              Text(": Company full address is here",
                                                                style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.w500),
                                                                maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                              )
                                                            ],
                                                          )
                                                        ),
                                                        Container(
                                                            padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                            child: Row(
                                                              children: [
                                                                Text("Availability",
                                                                  style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.bold),
                                                                  maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                                ),
                                                                Text(": 1:31:15 PM - 1:31:15 PM",
                                                                  style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.w500),
                                                                  maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                                )
                                                              ],
                                                            )
                                                        ),
                                                        Row(
                                                          children: [
                                                            Container(
                                                              padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                              child: Icon(Icons.star, color: Colors.amber,),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                                              child: Text("0.00", style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
                                                                  color: Colors.amber, fontWeight: FontWeight.bold),),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                                              child: Text("(0)", style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,),),
                                                            )
                                                          ],
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.0,),
                                            Positioned(
                                                bottom: 1.0,
                                                right: 2.0,
                                                child: SizedBox(
                                                  height: 25,
                                                  width: 90,
                                                  child: ElevatedButton(
                                                    onPressed: (){
                                                      //setState(() => _isSelected = !_isSelected);
                                                    },
                                                    child: Text("Select"),
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Theme.of(context).colorScheme.primary, // This is what you need!
                                                    ),
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                              ),
                            ],
                          ),
                          GetBuilder<CompanyTabController>(
                            init: Get.find<CompanyTabController>(),
                            builder: (serviceTabController) {
                              return Container(
                                color:Theme.of(context).scaffoldBackgroundColor,
                                child: Center(
                                  child: Container(
                                    width: ResponsiveHelper.isMobile(context) ?null : Get.width / 3,
                                    color: Get.isDarkMode?Theme.of(context).scaffoldBackgroundColor:Theme.of(context).cardColor,
                                    padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_DEFAULT),
                                    child: DecoratedTabBar(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      tabBar: TabBar(
                                          padding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_MINI),
                                          unselectedLabelColor: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.4),
                                          controller: serviceTabController.controller!,
                                          labelColor:Get.isDarkMode? Colors.white : Theme.of(context).primaryColor,
                                          labelStyle: ubuntuBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                          indicatorColor: Theme.of(context).colorScheme.primary,
                                          indicatorPadding: EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
                                          labelPadding: EdgeInsets.only(bottom: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                          indicatorWeight: 2,
                                          onTap: (int? index) {
                                            switch (index) {
                                              case 0:
                                                serviceTabController.updateServicePageCurrentState(CompanyTabControllerState.serviceOverview);
                                                break;
                                              case 1:
                                                serviceTabController.serviceDetailsTabs().length > 2 ?
                                                serviceTabController.updateServicePageCurrentState(CompanyTabControllerState.faq):
                                                serviceTabController.updateServicePageCurrentState(CompanyTabControllerState.review);
                                                break;
                                              case 2:
                                                serviceTabController.updateServicePageCurrentState(CompanyTabControllerState.review);
                                                break;
                                            }
                                          },
                                          tabs: serviceTabController.serviceDetailsTabs()
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          //Tab Bar View
                          GetBuilder<CompanyTabController>(
                            initState: (state){
                              Get.find<CompanyTabController>().getServiceReview(serviceController.service!.id!,1);
                            },
                            builder: (controller){
                              Widget tabBarView = TabBarView(
                                controller: controller.controller,
                                children: [
                                  SingleChildScrollView(child: CompanyOverview(description:service.description!)),
                                  if(Get.find<CompanyDetailsController>().service!.faqs!.length > 0)
                                    SingleChildScrollView(child: ServiceDetailsFaqSection()),
                                  if(controller.reviewList != null)
                                    SingleChildScrollView(
                                      child: ServiceDetailsReview(
                                        serviceID: serviceController.service!.id!,
                                        reviewList: controller.reviewList!, rating : controller.rating,),
                                    )
                                  else
                                    EmptyReviewWidget()
                                ],
                              );

                              if(ResponsiveHelper.isMobile(context)){
                                return Expanded(
                                  child: tabBarView,
                                );
                              }else{
                                return Container(
                                  height: 500,
                                  child: tabBarView,);
                              }
                            },
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
