import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:xml/xml.dart' as xml;

class ImageUpload extends StatefulWidget {
  const ImageUpload({Key? key}) : super(key: key);

  @override
  _ImageUploadState createState() => _ImageUploadState();
}

class _ImageUploadState extends State<ImageUpload> {
  late String svgString;
  List<String> pathAttributes = [];

  @override
  void initState() {
    super.initState();
    loadSvgString();
  }

  Future<void> loadSvgString() async {
    WidgetsFlutterBinding.ensureInitialized(); 
    const String svgPath = 'lib/images/logoSvg.svg';
    svgString = await rootBundle.loadString(svgPath);

    final document = xml.XmlDocument.parse(svgString);
    for (var element in document.findAllElements('path')) {
      final attribute = element.getAttribute('d');
      if (attribute != null) {
        pathAttributes.add(attribute);
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (svgString == null || svgString.isEmpty) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Display image"),
          ),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Display image"),
          ),
          body: Column(
            children: [
              SizedBox(height: 100),
              Center(
                child: SvgPicture.string(
                  svgString,
                  width: 100,
                  height: 100,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Only the "d" attribute from <path> elements:',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 10),
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
        ),
      );
    }
  }
}
