import 'package:get/get.dart';
import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/core/core_export.dart';

class ServiceWidgetVertical extends StatelessWidget {
  final Service service;
  final bool isAvailable;
  final String fromType;

  ServiceWidgetVertical(
      {Key? key,
      required this.service,
      required this.isAvailable,
      required this.fromType,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    num _lowestPrice = 0.0;

    if(fromType == 'fromCampaign'){
      if(service.variations != null){
        _lowestPrice = service.variations![0].price!;
        for (var i = 0; i < service.variations!.length; i++) {
          if (service.variations![i].price! < _lowestPrice) {
            _lowestPrice = service.variations![i].price!;
          }
        }
      }
    }else{
      if(service.variationsAppFormat != null){
        if(service.variationsAppFormat!.zoneWiseVariations != null){
          _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![0].price!;
          for (var i = 0; i < service.variationsAppFormat!.zoneWiseVariations!.length; i++) {
            if (service.variationsAppFormat!.zoneWiseVariations![i].price! < _lowestPrice) {
              _lowestPrice = service.variationsAppFormat!.zoneWiseVariations![i].price!;
            }
          }
        }
      }
    }


    Discount _discountModel =  PriceConverter.discountCalculation(service);
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(Dimensions.RADIUS_SMALL),
                boxShadow:Get.isDarkMode ? null: cardShadow,
              ),
              child: Padding(
                padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //cover image and service name
                    Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_SMALL)),
                              child: CustomImage(
                                image: '${Get.find<SplashController>().configModel.content!.imageBaseUrl!}/service/${service.thumbnail}',
                                fit: BoxFit.cover,width: double.maxFinite,
                                height: Dimensions.HOME_IMAGE_SIZE,
                              ),
                            ),
                            _discountModel.discountAmount! > 0 ?
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                padding: EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).errorColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(Dimensions.RADIUS_DEFAULT),
                                    topRight: Radius.circular(Dimensions.RADIUS_SMALL),
                                  ),
                                ),
                                child: Text(
                                  PriceConverter.percentageOrAmount('${_discountModel.discountAmount}', '${_discountModel.discountAmountType}'),
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).primaryColorLight),
                                ),
                              ),
                            ) :
                            SizedBox(),
                          ],
                        ),
                        SizedBox(height: Dimensions.PADDING_SIZE_RADIUS,),
                        Padding(
                          padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_EXTRA_SMALL),
                          child: Text(
                            service.name!,
                            style: ubuntuMedium.copyWith(fontSize: Dimensions.fontSizeSmall),
                            maxLines: 2, overflow: TextOverflow.ellipsis, textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ],),
              ),
            ),
            Positioned.fill(child: RippleButton(onTap: () {
              Get.toNamed(RouteHelper.getServiceRoute(service.id!),);
            }))
          ],
        ),
        //add to cart button
        if(fromType != 'fromCampaign')
          Positioned(
            bottom: 10.0,
            right: 10.0,
            child: Stack(
              children: [
                Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: SizedBox(
                      height: 30.0,
                      width: 100.0,
                      child: CustomButton(
                        buttonText: 'Book Now'.tr,
                      ),
                    )
                ),
                Positioned.fill(
                  child: CustomButton(
                    buttonText: 'Book Now'.tr,
                    onPressed: () {
                        showModalBottomSheet(
                            useRootNavigator: true,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            context: context, builder: (context) => ServiceCenterDialog(service: service));
                    }
                    ),)
              ],
            ),
          ),
      ],

    );
  }
}
