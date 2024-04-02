import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key, required File imageFile}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  File? imageFile;
  String? gcode;
  static const String baseUrl = "http://your-server-address:port/convert";

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> convertImageToGcode(File? imageFile) async {
    if (imageFile == null) return null;
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));
    request.files.add(http.MultipartFile.fromPath('image', imageFile.path) as http.MultipartFile);
    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.bytesToString();
      return responseData;
    } else {
      print('Error converting image: ${response.reasonPhrase}');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Upload'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: pickImage,
                child: Text('Select Image'),
              ),
              SizedBox(height: 20),
              if (imageFile != null) Text('Selected: ${imageFile!.path}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: imageFile != null
                    ? () async {
                        gcode = await convertImageToGcode(imageFile);
                        if (gcode != null) {
                          print('G-code received: $gcode');
                        } else {
                          print('Error converting image');
                        }
                      }
                    : null,
                child: Text('Convert Image to G-code'),
              ),
              if (gcode != null) Text('G-code: $gcode'),
            ],
          ),
        ),
      ),
    );
  }
}
