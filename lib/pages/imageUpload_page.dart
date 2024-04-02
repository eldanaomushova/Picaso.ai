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

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File('lib/images/logoSvg.svg');
      });
    }
  }

  Future<String?> convertImageToGcode(File? imageFile) async {
    try {
      if (imageFile == null) return null;

      final url = Uri.parse('http://localhost:5000/convert');
      final request = http.MultipartRequest('POST', url);
      request.files.add(
        await http.MultipartFile.fromPath('image', imageFile.path),
      );
      final streamedResponse = await request.send();
      if (streamedResponse.statusCode == 200) {
        final response = await streamedResponse.stream.bytesToString();
        final data = jsonDecode(response);
        return data['gcode'] as String?;
      } else {
        print('Error converting image: ${streamedResponse.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error converting image: $e');
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
