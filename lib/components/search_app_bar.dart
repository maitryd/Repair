import 'package:demandium/core/core_export.dart';
import 'package:get/get.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool? backButton;
  SearchAppBar({this.backButton = true});

  @override
  Widget build(BuildContext context) {
    return ResponsiveHelper.isDesktop(context) ? WebMenuBar() : Container(
      decoration: BoxDecoration(
        color: Get.isDarkMode ? Theme.of(context).cardColor.withOpacity(.2):Theme.of(context).primaryColor,
        border: Border(
            bottom: BorderSide(
                width: .4,
                color: Theme.of(context).primaryColorLight.withOpacity(.2))),
      ),
      height: 80,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height:  ResponsiveHelper.isWeb() ?
            Dimensions.PADDING_SIZE_SMALL : Dimensions.PADDING_SIZE_EXTRA_LARGE,),
          Row(
            children: [
              backButton! ? Padding(
                padding: const EdgeInsets.only(left: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,),
                  color: Theme.of(context).primaryColorLight,
                  onPressed: () => Navigator.pop(context),
                ),
              ):
              SizedBox(),
              Expanded(child: SearchWidget()),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(Dimensions.WEB_MAX_WIDTH, Dimensions.PREFERRED_SIZE_WHEN_DESKTOP );

}