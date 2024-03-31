import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageUpload extends StatelessWidget {
  final File imageFile;
  
  const ImageUpload({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display image"),
      ),
      body: Column(
        children: [
          SizedBox(height: 100), // Adjust the padding as needed
          Center(
            child: SvgPicture.file(
              imageFile,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
