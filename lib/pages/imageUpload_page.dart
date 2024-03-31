import 'dart:io';

import 'package:flutter/material.dart';

class ImageUpload extends StatelessWidget {
  final File imageFile;
  const ImageUpload({Key? key, required this.imageFile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Display image"),
      ),
      body: Center(child: Image.file(imageFile),),
    );
  }
}