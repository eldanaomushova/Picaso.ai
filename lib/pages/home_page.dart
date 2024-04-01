import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/aigeneration_page.dart';
import 'package:flutter_application_1/pages/imageUpload_page.dart';
import 'package:flutter_application_1/styles/colors.dart';
import 'package:image_picker/image_picker.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AIPage()));
              },
              child: Image.asset(
                'lib/images/generate_pic.png',
                width: 54,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              'lib/images/logo.png',
              width: 140,
              height: 140,
            ),
          ),
          const SizedBox(height: 200),
          SizedBox(
            width: 350, 
            child: ElevatedButton(
              onPressed: () async {
                final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                if (pickedImage != null) { 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ImageUpload(imageFile: File(pickedImage.path))),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
                backgroundColor: AppStyles.buttonUpload,
              ),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Upload file',
                  style: AppStyles.buttonUpld,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 350, 
            child: ElevatedButton(
              onPressed: () {
                // Add your button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
                backgroundColor: AppStyles.buttonUpload,
              ),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Create file',
                  style: AppStyles.buttonUpld,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          SizedBox(
            width: 350, 
            child: ElevatedButton(
              onPressed: () {
                // Add your button onPressed logic here
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(1.0),
                ),
                backgroundColor: AppStyles.buttonUpload,
              ),
              child: const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'Use AI',
                  style: AppStyles.buttonUpld,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
