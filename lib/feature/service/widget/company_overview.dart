import 'package:demandium/components/web_shadow_wrap.dart';
import 'package:get/get.dart';
import 'package:demandium/core/core_export.dart';


class CompanyOverview extends StatelessWidget {
  final String description;
  const CompanyOverview({Key? key, required this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: WebShadowWrap(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_SMALL,vertical: Dimensions.PADDING_SIZE_RADIUS),
          width: Dimensions.WEB_MAX_WIDTH,
          constraints:  ResponsiveHelper.isDesktop(context) ? BoxConstraints(
            minHeight: !ResponsiveHelper.isDesktop(context) && Get.size.height < 600 ? Get.size.height : Get.size.height - 550,
          ) : null,
          child: Card(
              elevation: ResponsiveHelper.isMobile(context) ? 1:0,
              color: ResponsiveHelper.isMobile(context) ?  Theme.of(context).cardColor:Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("About Company:",
                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeLarge:Dimensions.fontSizeLarge, fontWeight: FontWeight.bold),
                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Hawally,",
                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeLarge:Dimensions.fontSizeLarge, fontWeight: FontWeight.w400),
                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Tel: 25865314 / 25879612",
                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeLarge:Dimensions.fontSizeLarge, fontWeight: FontWeight.w400),
                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Mob: 66895236 / 66789632",
                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeLarge:Dimensions.fontSizeLarge, fontWeight: FontWeight.w400),
                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(height: 50,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Work We Done:",
                      style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeLarge:Dimensions.fontSizeLarge, fontWeight: FontWeight.bold),
                      maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Image.asset(
                            Images.r1,
                            width: 170,
                          ),
                        ),
                      ),

                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)
                          ),
                          child: Image.asset(
                            Images.r1,
                            width: 170,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              )
          ),
        ),
      ),
    );
  }
}