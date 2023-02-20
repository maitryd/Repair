import 'package:demandium/components/service_center_dialog.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/service/model/company_details_model.dart';
import 'package:get/get.dart';

class CompanyInformationCard extends StatefulWidget {
  final List<CompanyDetails> companydetails;

  const CompanyInformationCard({Key? key, required this.companydetails,})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _CompanyInformationCardState();

}

class _CompanyInformationCardState extends State<CompanyInformationCard>{

  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: widget.companydetails.length,
                      itemBuilder: (context, index) {
                        return Container(
                            padding: EdgeInsets.only(top: 5.0),
                            //padding: EdgeInsets.all(10),
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  right: 2.0,
                                  child: Text("View Profile",
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.blueAccent,
                                          fontWeight: FontWeight.bold)),),
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
                                              child: Text(widget.companydetails[index].companyName,
                                                style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.bold),
                                                maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              width: 240,
                                              padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                              child: Text(widget.companydetails[index].description,
                                                style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall, fontWeight: FontWeight.w500),
                                                maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all( Dimensions.PADDING_SIZE_MINI),
                                              child: Text(widget.companydetails[index].order,
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
                                                  child: Text(widget.companydetails[index].rating, style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeSmall,
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
    );
  }
}
