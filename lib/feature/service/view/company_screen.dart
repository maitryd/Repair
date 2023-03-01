import 'package:demandium/components/footer_base_view.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/feature/service/controller/company_details_controller.dart';
import 'package:demandium/feature/service/controller/company_details_tab_controller.dart';
import 'package:demandium/feature/service/model/company_details_model.dart';
import 'package:demandium/feature/service/view/additional_issue_screen.dart';
import 'package:demandium/feature/service/view/company_details_screen.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

class CompanyScreen extends StatefulWidget {
  final String serviceID;
  const CompanyScreen({Key? key, required this.serviceID}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {

  var _isSelected = false;

  final ScrollController scrollController = ScrollController();
  final scaffoldState = GlobalKey<ScaffoldState>();

  late List<CompanyDetails> itemList1 = [
    CompanyDetails(Images.companyLogo, "SIYANCO", "Test and identify problems and repair with expert and experienced electricians", "4 Successful Order", "0.00"),
  ];
  late List<CompanyDetails> itemList2 = [
    CompanyDetails(Images.companyLogo, "VOLTAS", "Test and identify problems and repair with expert and experienced electricians", "6 Successful Order", "0.00"),
  ];
  late List<CompanyDetails> itemList3 = [
    CompanyDetails(Images.companyLogo, "TATA", "Test and identify problems and repair with expert and experienced electricians", "8 Successful Order", "0.00"),
  ];
  late List<CompanyDetails> itemList4 = [
    CompanyDetails(Images.companyLogo, "SAMSUNG", "Test and identify problems and repair with expert and experienced electricians", "3 Successful Order", "0.00"),
  ];

  // List<CompanyDetails> itemList1 = <CompanyDetails>[
  //   CompanyDetails(Images.companyLogo, "VOLTAS", "Test and identify problems and repair with expert and experienced electricians", "6 Successful Order", "0.00"),
  // ];
  // late List<CompanyDetails> itemList3 = [
  //   CompanyDetails(Images.companyLogo, "TATA", "Test and identify problems and repair with expert and experienced electricians", "8 Successful Order", "0.00"),
  // ];
  // late List<CompanyDetails> itemList4 = [
  //   CompanyDetails(Images.companyLogo, "SAMSUNG", "Test and identify problems and repair with expert and experienced electricians", "3 Successful Order", "0.00"),
  // ];

  bool isDescending = false;
  bool isAlphabetsSorting = false;
  bool isRatingDescending = false;
  late String item1;
  late String item2;
  String? _result;

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
      appBar: AppBar(
        title: Text("Select Companies",
          style: TextStyle(fontSize: Dimensions.fontSizeLarge),),
          actions: [
            IconButton(
              icon: Icon(Icons.sort, size: Dimensions.CART_WIDGET_SIZE,),
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                            title: Center(child: Text('A TO Z')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = true;
                                isDescending = false;
                              });
                              print('Rating a To z');
                              print("isDescending");
                              print(isDescending);
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Center(child: Text('Z TO A')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = true;
                                isDescending = true;
                              });
                              print('Rating z To a');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Center(child: Text('Rating High To Low')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = false;
                                isRatingDescending = true;
                              });
                              print('Rating High To Low');
                              Navigator.pop(context);
                            },
                          ),
                          ListTile(
                            title: Center(child: Text('Rating Low To High')),
                            onTap: () {
                              setState(() {
                                isAlphabetsSorting = false;
                                isRatingDescending = false;
                              });
                              print('Rating low To high');
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },),
            IconButton(
              icon: Image.asset(Images.search_White, height:  Dimensions.CART_WIDGET_SIZE, width:  Dimensions.CART_WIDGET_SIZE,),
              onPressed: () async{
                searchlabel(details);
              },)
          ]
      ),
      // CustomAppBar(centerTitle: false, title: 'Select Companies'.tr,showCart: true,),
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
                return Column(
                  children: [
                    Expanded(child: FooterBaseView(
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
                                    child: Column(
                                      children: [
                                        FilterchipWidget(chipName: itemList1, serviceID: '',),
                                        FilterchipWidget(chipName: itemList2, serviceID: '',),
                                        FilterchipWidget(chipName: itemList3, serviceID: '',),
                                        FilterchipWidget(chipName: itemList4, serviceID: '',),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
                    Padding(
                      padding: EdgeInsets.only(
                        left: Dimensions.PADDING_SIZE_DEFAULT,
                        right: Dimensions.PADDING_SIZE_DEFAULT,
                        bottom: Dimensions.PADDING_SIZE_SMALL,
                      ),
                      child: CustomButton(
                        width: Get.width,
                        radius: Dimensions.RADIUS_DEFAULT,
                        buttonText: 'Proceed to Add Details',
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
                            return AdditionalIssueScreen();
                          }));
                        },
                      ),
                    ),
                  ],
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
  var details;
  void searchlabel(String query){
    final suggestion = itemList1.where((item) {
      final companytitle = item.companyName.toLowerCase();
      final input = query.toLowerCase();
      return companytitle.contains(input);
    }).toList();
    setState(() {
       details= suggestion;
    });
    print(details);
  }

  bool checkedValue = false;

  Widget selectIcon(int index){
    return Checkbox(
        value: checkedValue,
        activeColor: Colors.green,
        onChanged:(value){
          setState(() {
            checkedValue = value!;
          });
        });
  }

}

class FilterchipWidget extends StatefulWidget{
  final String serviceID;
  final List<CompanyDetails> chipName;
  const FilterchipWidget({Key? key, required this.chipName, required this.serviceID}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FilterchipWidgetState();
}

class _FilterchipWidgetState extends State<FilterchipWidget>{

  var _isSelected = false;
  late int indexes;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
          padding: EdgeInsets.all(0.0),
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: widget.chipName.length,
                            itemBuilder: (context, index) {
                              return Container(
                                 padding: EdgeInsets.only(top: 5.0),
                                  //padding: EdgeInsets.all(10),
                                  child: Stack(
                                    children: <Widget>[
                                      Positioned(
                                        bottom: 80.0,
                                        right: 5.0,
                                        child: TextButton(
                                            child: Text("View Profile",
                                                style: TextStyle(
                                                fontSize: 12.0,
                                                color: Colors.blueAccent,
                                                fontWeight: FontWeight.bold)),
                                            onPressed: () {
                                              Get.toNamed(RouteHelper.getSelectedCompanyRoute(
                                                  company_image: widget.chipName[index].companyIcon,
                                              ));
                                              },
                                        ),
                                      ),
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
                                                    child: Text(widget.chipName[index].companyName,
                                                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.bold),
                                                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    width: 240,
                                                    padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                    child: Text(widget.chipName[index].description,
                                                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.w500),
                                                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                    child: Text(widget.chipName[index].order,
                                                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
                                                          color: Colors.green, fontWeight: FontWeight.bold),
                                                      maxLines: MediaQuery.of(context).size.width<300?1:2,textAlign: TextAlign.center, overflow: TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                        padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                                        child: Icon(Icons.star, color: Colors.amber,),
                                                      ),
                                                      Container(
                                                        padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_MINI),
                                                        child: Text(widget.chipName[index].rating, style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
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
                                          right: 5.0,
                                          child: SizedBox(
                                            height: 25,
                                            width: 90,
                                            child: ElevatedButton(
                                              onPressed: (){
                                                setState(() => _isSelected = !_isSelected);
                                              },
                                              child: _isSelected ? Text("Selected") : Text("Select"),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: _isSelected ? Colors.green : Theme.of(context).colorScheme.primary, // This is what you need!
                                              ),
                                            ),
                                          )
                                      )
                                    ],
                                  ));
                            }))
                  ]),
            ),
          ),
        )
    );
  }
}
