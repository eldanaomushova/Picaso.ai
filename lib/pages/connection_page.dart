import 'package:flutter/material.dart';

class ConnectionPage extends StatelessWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF6C7768),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Image.asset(
                  'lib/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const BackButton(),
          ],
        ),
      ),
    );
  }
}
