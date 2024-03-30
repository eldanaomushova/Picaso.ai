import 'package:flutter/material.dart';
import 'package:flutter_application_1/styles/colors.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io' show Platform;

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool _isScanning = false; // Initialize to false

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
              child: BackButton(color: Colors.black),
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
                child: Tooltip(
                  message: _isScanning ? 'Stop scanning' : 'Start scanning', 
                  child: ElevatedButton(
                    onPressed: () async {
                      print("scanning");
                      if (_isScanning) {
                        await FlutterBluePlus.stopScan();
                      } else {
                        await FlutterBluePlus.startScan();
                      }
                      setState(() {
                        _isScanning = !_isScanning; // Toggle the value of _isScanning
                      });
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
                    child: StreamBuilder<bool>(
                      stream: FlutterBluePlus.isScanning,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        }

                        if (snapshot.hasData) {
                          final isScanning = snapshot.data!;
                          _isScanning = isScanning;
                          return Icon(isScanning ? Icons.stop : Icons.play_arrow);
                        }

                        return CircularProgressIndicator(); 
                      },
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
