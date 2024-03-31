import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/intro_page.dart';
import 'package:flutter_application_1/model/cart_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: IntroPage(),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;
// import 'package:xml/xml.dart' as xml;

// void printSvgPaths() async {
//   // Load the SVG file as a string
//   String svgString = await rootBundle.loadString('assets/your_svg_file.svg'); // Adjust this to your file path

//   // Parse the SVG string
//   final document = xml.XmlDocument.parse(svgString);

//   // Extract only the 'd' attribute from the 'path' elements
//   List<String> pathAttributes = [];
//   for (var element in document.findAllElements('path')) {
//     final attribute = element.getAttribute('d');
//     if (attribute != null) {
//       pathAttributes.add(attribute);
//     }
//   }

//   // Print the 'd' attributes
//   print('Only the "d" attribute from <path> elements:');
//   pathAttributes.forEach(print);
// }

// void main() {
//   // Ensure that Flutter bindings are initialized
//   WidgetsFlutterBinding.ensureInitialized();

//   // Call the function to print the 'd' attributes from the SVG
//   printSvgPaths();
// }
