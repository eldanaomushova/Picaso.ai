import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/intro_page.dart';

class BackButton extends StatelessWidget {
  const BackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: 50,
            left: 32,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => IntroPage()));
              },
              child: const Icon(
                Icons.arrow_back_ios,
                size: 34,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
