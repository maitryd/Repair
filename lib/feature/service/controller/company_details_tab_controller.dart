
import 'package:demandium/feature/service/controller/company_details_controller.dart';
import 'package:demandium/feature/service/repository/company_details_repo.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';

enum CompanyTabControllerState {serviceOverview,faq,review}

class CompanyTabController extends GetxController with GetSingleTickerProviderStateMixin{
  final CompanyDetailsRepo companyDetailsRepo;
  CompanyTabController({required this.companyDetailsRepo});

  List<Faqs>? faqs = Get.find<CompanyDetailsController>().service!.faqs;



  List<Widget> serviceDetailsTabs(){
    if(faqs!.length > 0){
      return  [
        Tab(child: Text("Company Overview".tr,maxLines: 2,),),
        Tab(child: Text("faqs".tr,maxLines: 2,),),
        Tab(child: Text("reviews".tr,maxLines: 2,),),
      ];
    }
    return  [
      Tab(child: Text("Company Overview".tr,maxLines: 2,),),
      Tab(child: Text("reviews".tr,maxLines: 2,),),
    ];
  }

  TabController? controller;
  var servicePageCurrentState = CompanyTabControllerState.serviceOverview;
  void updateServicePageCurrentState(CompanyTabControllerState serviceDetailsTabControllerState){
    servicePageCurrentState = serviceDetailsTabControllerState;
    update();
  }

  bool? _isLoading;
  int? _pageSize = 0;
  ReviewContent? reviewContent;
  List<ReviewData>? _reviewList;
  List<ReviewData>? get reviewList => _reviewList;
  bool get isLoading => _isLoading!;
  int? get pageSize => _pageSize!;
  Rating? _rating;
  String? _serviceID;
  int? _offset = 1;
  Rating get rating => _rating!;
  int? get offset => _offset;
  String? get serviceID => _serviceID;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: faqs!.length > 0 ? 3 :2);
  }

  Future<void> getServiceReview(String serviceID,int offset, {bool reload = true,}) async {
    _offset = offset;
    Response response = await companyDetailsRepo.getServiceReviewList(serviceID,offset);
    if (response.statusCode == 200 && response.body['response_code'] ==  'default_200') {
      if(reload){
        _reviewList = [];
      }
      reviewContent = ReviewContent.fromJson(response.body['content']);
      if(_reviewList != null && offset != 1){
        _reviewList!.addAll(reviewContent!.reviews!.reviewList!);
      }else{
        _reviewList = [];
        _reviewList!.addAll(reviewContent!.reviews!.reviewList!);
      }
      _rating = reviewContent!.rating;
      _pageSize = response.body['content']['reviews']['last_page']?? 0;
    }
    update();
  }

  @override
  void onClose() {
    controller!.dispose();
    super.onClose();
  }
}