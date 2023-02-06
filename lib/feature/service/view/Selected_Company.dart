import 'package:demandium/core/core_export.dart';
import 'package:demandium/feature/service/controller/companydetails.dart';
import 'package:get/get.dart';

class SelectedCompany extends GetView<CompanyDetailController>{
  const SelectedCompany({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text("multi selection"),),
      body: ListView.builder(
        itemCount: controller.list.length,
        itemBuilder: ((context, index) {
          return Obx(() => GestureDetector(
            onTap: () {
              controller.list[index].isSelected.value = !controller.list[index].isSelected.value;
            },
            child: Container(
              margin:
              EdgeInsets.only(left: 16, right: 16, top: 4, bottom: 8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: controller.list[index].isSelected.value
                    ? Colors.green[200]
                    : Colors.white,
              ),
              child: Text(controller.list[index].companyName),
            ),
          ));
        }),
      ),
    );
  }
}

