import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/connection_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'lib/images/intro.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 20,
            left: 20,
            child: Image.asset(
              'lib/images/logo.png',
              width: 200,
              height: 200,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Text(
                'Welcome to Picasso: Let\'s Transform Your Space!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 1
                    ..color = Colors.black,
                  shadows: const [
                    Shadow(
                      blurRadius: 1,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 52), 
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => ConnectionPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 40, 40, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(
                      color: Colors.white, 
                      width: 1, 
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.fromLTRB(60, 12, 60, 12),
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
