import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ImageUpload extends StatefulWidget {
  late File imageFile;
  ImageUpload({Key? key, required this.imageFile}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String? gcode;
  static const String baseUrl = "http://localhost:3000";

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        widget.imageFile = File(pickedFile.path);
      });
      convertImageToGcode(widget.imageFile);
    }
  }

  Future<String?> convertImageToGcode(File? imageFile) async {
  if (imageFile == null) return null;

  List<int> imageBytes = await imageFile.readAsBytes();
  String base64Image = base64Encode(imageBytes);

  var url = Uri.parse("http://localhost:3000");
  var response = await http.post(
    url,
    body: {
      'image': base64Image,
    },
  );

  if (response.statusCode == 200) {
    print("Received");
    return response.body;
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
              if (widget.imageFile != null) Text('Selected: ${widget.imageFile.path}'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: widget.imageFile != null
                    ? () async {
                        gcode = await convertImageToGcode(widget.imageFile);
                        if (gcode != null) {
                          print('G-code received: $gcode');
                          setState(() {
                            this.gcode = gcode;
                          });
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
