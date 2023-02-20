import 'dart:io';

import 'package:demandium/components/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DetailsScreen extends StatefulWidget {
  final String imagepath;
  const DetailsScreen({Key? key, required this.imagepath}) : super(key: key);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(centerTitle: false, title: 'Selected Image'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child:  Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.file(
                File(widget.imagepath),
                  fit: BoxFit.cover,
              ),
            )
          )
        ],
      )
    );
  }
}