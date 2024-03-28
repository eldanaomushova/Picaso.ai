import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/colors.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppStyles.mainCcolor,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Image.asset(
                  'lib/images/logo_light.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0.0, 50, 40, 30),
              child: BackButton( 
                color: Colors.black, 
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Text(
                  "Please turn on the Bluetooth and do connection",
                  textAlign: TextAlign.center, 
                  style: AppStyles.mainText.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.bold, 
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
                    'Connect to HC-05',
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
      ),
    );
  }
}
