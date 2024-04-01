import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xml/xml.dart' as xml;

class ImageUpload extends StatefulWidget {
  final File imageFile;
  const ImageUpload({Key? key, required this.imageFile}) : super(key: key);
  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  String? svgString;
  List<String> pathAttributes = [];

  @override
  void initState() {
    super.initState();
    loadSvgString(widget.imageFile);
  }

    Future<void> loadSvgString(File imageFile) async {
    WidgetsFlutterBinding.ensureInitialized(); 
    try {
      final content = await imageFile.readAsString();
      final document = xml.XmlDocument.parse(content);
      for (var element in document.findAllElements('path')) {
        final attribute = element.getAttribute('d');
        if (attribute != null) {
          pathAttributes.add(attribute);
        }
        else{
          continue;
        }
      }
      setState(() {
        svgString = content; 
      });
    } catch (e) {
      print('Error loading SVG file: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    if (svgString == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Display image"),
        ),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Display image"),
        ),
        body: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: SvgPicture.string(
                svgString!,
                width: 100,
                height: 100,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Only the "d" attribute from <path> elements:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: pathAttributes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(pathAttributes[index]),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
