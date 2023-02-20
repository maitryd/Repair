import 'dart:io';
import 'package:pdf/pdf.dart';
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
import 'package:video_player/video_player.dart';

class AdditionalIssueScreen extends StatefulWidget {
  const AdditionalIssueScreen({Key? key}) : super(key: key);

  @override
  State<AdditionalIssueScreen> createState() => _AdditionalIssueScreenState();
}

class _AdditionalIssueScreenState extends State<AdditionalIssueScreen> {

  final scaffoldState = GlobalKey<ScaffoldState>();

  final ImagePicker imgpicker = ImagePicker();
  final ImagePicker videoPicker = ImagePicker();
  List<XFile>? imageList = [];
  List<XFile>? dummyImageList = [];
  XFile? videoList;
  XFile? pdf;

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
                                                      onPressed: () {selectVideos(); },
                                                      icon: Image.asset(
                                                        Images.addVideo,
                                                        width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                                                      ),
                                                  ),
                                                ),
                                              ),
                                              showVideo()
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
                                                    onPressed: () {selectPdf(pdf); },
                                                    icon: Image.asset(
                                                      Images.addImage,
                                                      width: Dimensions.PADDING_FOR_CHATTING_BUTTON,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              if(pdf != null)...[
                                                Container(
                                                  height: 110,
                                                  width: 280,
                                                  padding: EdgeInsets.only(top: 10.0, left: 10.0,bottom: 10.0, right: 10.0),
                                                  child: Card(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(10.0)),
                                                    child: baseimage(imageList),
                                                  ),
                                                )
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

  File? selectedVideo;
  VideoPlayerController? _videoPlayerController;
  ImagePicker? picker = ImagePicker();

  void selectVideos() async {
    PickedFile? video = await picker!.getVideo(source: ImageSource.gallery);
    selectedVideo = File(video!.path);
    _videoPlayerController = VideoPlayerController.file(selectedVideo!)..initialize().then((_) {
      setState(() {
      });
      _videoPlayerController?.play();
    });
    if (selectedVideo != null) {
      print("Video list Length:");
      print(selectedVideo);
    }
  }

  void selectPdf(XFile? list) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result != null) {
      print(result.names);
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

  Widget showVideo() {
    return Center(
      child: selectedVideo != null ?
        AspectRatio(aspectRatio: _videoPlayerController!.value.aspectRatio,
          child: VideoPlayer(_videoPlayerController!),)
          : Container(child: Text("No video"),)
    );
  }
}
