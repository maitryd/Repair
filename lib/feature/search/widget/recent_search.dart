import 'package:demandium/components/ripple_button.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/feature/search/controller/search_controller.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RecentSearch extends StatelessWidget {
  const RecentSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      builder: (searchController){
        return searchController.historyList!.length > 0 ?
         Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('recent_search'.tr,style: ubuntuMedium.copyWith(
                    fontSize: Dimensions.fontSizeLarge,
                    color: Theme.of(context).colorScheme.primary),),
                InkWell(
                  onTap: (){
                    searchController.clearSearchAddress();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                    child: Text(
                      'clear_all'.tr,
                      style: ubuntuMedium.copyWith(
                          color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),
                          fontSize: Dimensions.fontSizeSmall),
                    ),
                  ),
                ),
              ],
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount:searchController.historyList!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_RADIUS),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Stack(
                        children: [
                          Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_DEFAULT))
                              ),
                              child: Center(child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:Dimensions.PADDING_SIZE_EXTRA_SMALL,vertical: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: Text(
                                  searchController.historyList!.elementAt(index),
                                  style: ubuntuRegular.copyWith(color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5)),
                                ),
                              ))),
                          Positioned.fill(child: RippleButton(onTap: () {
                            searchController.populatedSearchController(searchController.historyList!.elementAt(index));
                            searchController.searchData(searchController.historyList!.elementAt(index));
                          }))
                        ],
                      ),


                      InkWell(
                          onTap: (){
                            searchController.removeHistory(index);
                          },
                          child: Image.asset(Images.cancel,color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(.5),)),

                    ],
                  ),
                );
              },
            ),
          ],
        ):
        SizedBox();
      }
    );
  }
}
