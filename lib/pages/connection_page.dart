import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'dart:io' show Platform;

class ConnectionPage extends StatefulWidget {
  const ConnectionPage({Key? key}) : super(key: key);

  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  bool _isScanning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth Device Scanner'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _toggleScan,
              child: Text(_isScanning ? 'Stop Scanning' : 'Start Scanning'),
            ),


            //move it, after checking connection page
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('Home Page'),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: _buildDeviceList(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _toggleScan() async {
    setState(() {
      _isScanning = !_isScanning;
    });

    if (_isScanning) {
      await _startScan();
    } else {
      await _stopScan();
    }
  }

  Future<void> _startScan() async {
    if (Platform.isAndroid) {
      await FlutterBluePlus.turnOn();
    }

    await FlutterBluePlus.adapterState
        .firstWhere((state) => state == BluetoothAdapterState.on);

    await FlutterBluePlus.startScan();
  }

  Future<void> _stopScan() async {
    await FlutterBluePlus.stopScan();
  }

  Widget _buildDeviceList() {
    return StreamBuilder<List<ScanResult>>(
      stream: FlutterBluePlus.scanResults,
      initialData: [],
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        final devices = snapshot.data!;
        if (devices.isEmpty) {
          return Center(child: Text('No devices found'));
        }

        return ListView.builder(
          itemCount: devices.length,
          itemBuilder: (context, index) {
            final device = devices[index].device;
            return ListTile(
              title: Text(device.name.isEmpty ? 'Unknown Device' : device.name),
              subtitle: Text(device.id.toString()),
              onTap: (){
                
                _connectToDevice(device);
              },
            );
          },
        );
      },
    );
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      await device.connect();
      print('Connected to device: ${device.name}');
    } catch (e) {
      print('Error connecting to device: $e');
    }
  }
}
