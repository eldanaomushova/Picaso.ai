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
  List<String>? gcodeCommands;

  @override
  void initState() {
    super.initState();
    loadSvgString(widget.imageFile);
  }

  void loadSvgString(File imageFile) async {
  if (imageFile != null) {
    try {
      final content = await imageFile.readAsString();
      final document = xml.XmlDocument.parse(content);
      for (var element in document.findAllElements('path')) {
        final attribute = element.getAttribute('d');
        if (attribute != null) {
          pathAttributes.add(attribute);
        } else {
          continue;
        }
      }
      print(pathAttributes);
      setState(() {
        svgString = content;
      });
    } catch (e) {
      print('Error loading SVG file: $e');
    }
  } else {
    print('Image file is null');
  }
}

  void convertSvg2Gcode(List<String> pathAttributes) {
  if (pathAttributes.isNotEmpty) {
    final gcodeCommands = <String>[];
    for (var path in pathAttributes) {
      final pathCommands = path.split(RegExp(r'[a-zA-Z]'));
      final coordinates = path.split(RegExp(r'[ ,]'));
      for (var i = 0; i < pathCommands.length; i++) {
        final command = pathCommands[i];
        final coordX = double.tryParse(coordinates[i * 2]);
        final coordY = double.tryParse(coordinates[i * 2 + 1]);

        final gcodeCommand = convertCommandToGcode(command, coordX!, coordY!);
        if (gcodeCommand != null) {
          gcodeCommands.add(gcodeCommand);
        }
      }
    }
    setState(() {
      this.gcodeCommands = gcodeCommands;
    });
    print('GCode Commands:');
    gcodeCommands.forEach((command) {
      print(command);
    });
  } else {
    setState(() {
      this.gcodeCommands = [];
    });
  }
}



  String? convertCommandToGcode(String command, double x, double y) {
    switch (command.toLowerCase()) {
      case 'm':
        return 'G00 X$x Y$y';
      case 'l':
        return 'G01 X$x Y$y';
      case 'c':
        break;
      case 'z':
        return 'G00 Z0';
      default:
        print('Unsupported SVG path command: $command');
        return null;
    }
    return null;
  }
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Display image"),
    ),
    body: Column(
      children: [
        const SizedBox(height: 100),
        Expanded(
          child: gcodeCommands != null ? ListView.builder(
            itemCount: gcodeCommands!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(gcodeCommands![index]),
              );
            },
          ) : Center(
            child: CircularProgressIndicator(), // Display a loading indicator if gcodeCommands is null
          ),
        ),
      ],
    ),
  );
}
}