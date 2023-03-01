import 'dart:io';
import 'package:demandium/feature/service/view/VideoScreen.dart';
import 'package:demandium/components/custom_app_bar.dart';
import 'package:demandium/components/custom_button.dart';
import 'package:demandium/components/menu_drawer.dart';
import 'package:demandium/core/core_export.dart';
import 'package:demandium/core/helper/responsive_helper.dart';
import 'package:demandium/feature/service/view/detail_screen.dart';
import 'package:demandium/utils/dimensions.dart';
import 'package:demandium/utils/images.dart';
import 'package:demandium/utils/styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class AdditionalIssueScreen extends StatefulWidget {
  const AdditionalIssueScreen({Key? key}) : super(key: key);

  @override
  State<AdditionalIssueScreen> createState() => _AdditionalIssueScreenState();
}

class _AdditionalIssueScreenState extends State<AdditionalIssueScreen> {

  final scaffoldState = GlobalKey<ScaffoldState>();

  FilePickerResult? result;
  PlatformFile? selectedfiles;
  List<File>? pfiles;

  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker videoPicker = ImagePicker();
  List<XFile>? imageList = [];
  List<XFile>? dummyImageList = [];
  File? videoList;
  XFile? pdf;

  @override
  void initState(){
    super.initState();
    pfiles = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldState,
      endDrawer:ResponsiveHelper.isDesktop(context) ? MenuDrawer():null,
      appBar: CustomAppBar(centerTitle: false, title: 'Service Details'.tr),
      body: SafeArea(
        top: true,
        bottom: true,
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 1.3,
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 20.0, left: 30.0),
                                            child: Text("Add Photos (optional)",
                                              style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeDefault),
                                              maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0)),
                                                  child: IconButton(
                                                    onPressed: () {selectImages(imgpicker, imageList); },
                                                    icon: Image.asset(
                                                      Images.addImage,
                                                      width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if(imageList!.length > 0)...[
                                                Container(
                                                  height: 110,
                                                  width: 280,
                                                  padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0)),
                                                    child: baseimage(imageList),
                                                  ),
                                                ),
                                              ]
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 20.0, left: 30.0),
                                            child: Text("Add Videos (optional)",
                                              style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeDefault),
                                              maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0)),
                                                  child: IconButton(
                                                      onPressed: () {getVideo(ImageSource.gallery); },
                                                      icon: Image.asset(
                                                        Images.addVideo,
                                                        width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                                                      ),
                                                  ),
                                                ),
                                              ),
                                              if(videofile != null)...[
                                                showvideo(thumbnailFile)
                                              ]
                                            ],
                                          )
                                        ],
                                      ),
                                  ),
                                ]),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 20.0, left: 30.0),
                                            child: Text("Add PDF (optional)",
                                              style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeDefault),
                                              maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Row(
                                            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                height: 110,
                                                width: 110,
                                                padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
                                                child: Card(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(10.0)),
                                                  child: IconButton(
                                                    onPressed: () {selectPdf();},
                                                    icon: Image.asset(
                                                      Images.addImage,
                                                      width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              (selectedfiles == null) ?
                                              Container()
                                                  :   Center(
                                                child: GestureDetector(
                                                  child: Container(
                                                    height: 110,
                                                    width: 280,
                                                    padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
                                                    child: Card(
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(10.0)),
                                                      child: Padding(
                                                        padding: EdgeInsets.all(10.0),
                                                        child: TextButton(
                                                          onPressed: () {
                                                            OpenFile.open(selectedfiles!.path);
                                                            },
                                                          child: Text(_fileText.toString()),),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(top: 20.0, left: 30.0),
                                            child: Text("Add Additional Details",
                                              style: ubuntuRegular.copyWith(fontSize: MediaQuery.of(context).size.width<300?Dimensions.fontSizeExtraSmall:Dimensions.fontSizeDefault),
                                              maxLines: MediaQuery.of(context).size.width<300?1:3, overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(top: 10.0, left: 20.0,bottom: 10.0, right: 20.0),
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  borderSide: BorderSide(color: Color(0xFEEDEDED))
                                                ),
                                              ),
                                              maxLines: 2,
                                            ),
                                          ),
                                        ],
                                      )
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50,),
                Padding(
                  padding: EdgeInsets.only(
                    left: Dimensions.PADDING_SIZE_DEFAULT,
                    right: Dimensions.PADDING_SIZE_DEFAULT,
                    bottom: Dimensions.PADDING_SIZE_SMALL,
                  ),
                  child: CustomButton(
                    width: MediaQuery.of(context).size.width,
                    radius: Dimensions.RADIUS_DEFAULT,
                    buttonText: 'proceed_to_checkout'.tr,
                    onPressed: () {
                      Get.toNamed(RouteHelper.getCartRoute());
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  void selectImages(ImagePicker? imgpicker, List<XFile>? list) async {
    final List<XFile>? selectedImages = await imgpicker!.pickMultiImage();
    if (selectedImages!.isNotEmpty) {
      setState(() {
        list!.addAll(selectedImages);
      });
    }
    print("Image list Length:" + list!.length.toString());
  }

  XFile? selectedVideo;
  bool isVideo = false;
  ImagePicker _picker = ImagePicker();
  VideoPlayerController? _videoPlayerController;
  var videofile;
  var thumbnailFile;

  Future<void> getVideo(ImageSource imageSource) async {
    XFile? _vido = await _picker.pickVideo(source: ImageSource.gallery);
    videofile = File(_vido!.path);
    if(videofile != null){
      thumbnailFile = await VideoCompress.getFileThumbnail(videofile.path, quality: 50);
      setState(() {
      });
      _videoPlayerController = VideoPlayerController.file(videofile);
      print("Video file path : ${File(_vido.path)}");
      print("Thumbnail : $thumbnailFile");
    }
  }
  String _fileText = "";
  void selectPdf() async {
     result = await FilePicker.platform.pickFiles();
     selectedfiles = result!.files.first;

     if(result != null){
       pfiles = result!.paths.map((path) => File(path!)).toList();
       setState(() {
           _fileText = pfiles.toString();
       });
     }
  }

  int _indexs = 0;

  // show images
  Widget baseimage(List<XFile>? list) {
    return Center(
      child: Container(//to set the height of screen
          padding: const EdgeInsets.only(top:2.5,left: 10.0, right: 10.0),
          child: CarouselSlider.builder(
          options: CarouselOptions(
            height: 100,
           // autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            autoPlayInterval: Duration(seconds: 2),
            onPageChanged: (index, reason) {
              setState(() {
                _indexs = index;
              });
            }
          ),
            itemCount: list!.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              return Transform.scale(
                scale: index == _indexs ? 1 : 0.9,
                child: GestureDetector(
                  onDoubleTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(imagepath: imageList!.elementAt(index).path)));
                    print("Image path : ${imageList!.elementAt(index).path}");
                  },
                  onTap: () {
                    print("image delete");
                    // WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        imageList!.removeAt(index);
                      });
                    // });
                  },
                  child: Container(
                    child:  Column(
                      children: [
                        Stack(children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 4.0),
                            child: Image.file(
                              File(list[index].path),
                              fit: BoxFit.cover,
                            ),
                            height: MediaQuery.of(context).size.height / 11,
                            width: MediaQuery.of(context).size.width * 1.5,
                          ),
                        ]),
                      ],
                    ),),
                ),
              );
            },
          )),
    );
  }

  Widget showvideo(File paths){
    return Container(
        height: 110,
        width: 280,
        padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            child: GestureDetector(
                child: Image.file(File(thumbnailFile.path)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoScreen(videoPath: videofile!.path)));
                print("Image path : ${videofile.path}");}
            ),
        ),
    );
  }

}
