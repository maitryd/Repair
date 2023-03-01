import 'dart:io';

import 'package:demandium/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  final String videoPath;
  const VideoScreen({Key? key, required this.videoPath}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {

  late VideoPlayerController _videoPlayerController;
  late Future<void> _video;

  @override
  void initState(){
    super.initState();
    _videoPlayerController = VideoPlayerController.file(File(widget.videoPath));
    _video = _videoPlayerController.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(centerTitle: false, title: 'Selected Image'),
        body: FutureBuilder(
          future: _video,
          builder: (context, snsapshot){
            if(snsapshot.connectionState == ConnectionState.done){
              return Container(
                child: AspectRatio(
                  aspectRatio: _videoPlayerController.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController),
                ),
              );
            }
            else{
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            setState(() {
              if(_videoPlayerController.value.isPlaying){
                _videoPlayerController.pause();
              }
              else{
                _videoPlayerController.play();
              }
            });
          },
        child: Icon(_videoPlayerController.value.isPlaying ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
