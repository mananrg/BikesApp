import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../widgets/popup.dart';
import '../MainScreens/UnlockScreen.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool flashStatus = false;
  String? qrCodeValue;
  bool isScanned = false;

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildQrView(context),
          Positioned.fill(
              top: 35,
              left: 5,
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white54,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ))),
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/logo.png",
                  scale: 2,
                ),
              ),
            ),
          ),
          Positioned.fill(
            bottom: 30,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null)
                      Text(
                        isScanned ? 'Scanned Successfully!' : 'Scan a QR Code',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      )
                    else
                      const Text(''),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: IconButton(
                            onPressed: () async {
                              await controller?.toggleFlash();
                              setState(() {
                                flashStatus = !flashStatus;
                                print("*" * 100);
                                print(flashStatus);
                                print("*" * 100);
                              });
                            },
                            icon: Icon(
                              Icons.flashlight_on_sharp,
                              color: flashStatus ? Colors.amber : Colors.white,
                              size: 40,
                            ),

                          ),
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (isScanned) return; // prevent multiple scans
      setState(() => isScanned = true);
   try {

        DocumentSnapshot document = await FirebaseFirestore.instance
          .collection('bikeqr')
          .doc(scanData.code)
          .get();
      if (document.exists) {
        setState(() => isScanned = true);
        // If the document exists, navigate to a different screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BikesScreen(),
          ),
        );
      } else {
        // If the document doesn't exist, show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('Invalid QR Code'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => isScanned = false);
                    controller.resumeCamera();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }}catch (e) {
        // If there is an error, show an error message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('An error occurred.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() => isScanned = false);
                    controller.resumeCamera();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      /*  if (kDebugMode) {
        print('Data: ${result?.code}');
      }
      setState(() {
        result = scanData;
        qrCodeValue = result!.code;
      });
      if (await checkQRCodeExists(qrCodeValue!) ) {
        print("#"*100);
        print("#"*100);
        print("#"*100);
        print("#"*100);

        controller?.dispose();

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BikesScreen()));
      } else {
        print("\$"*100);
        print("\$"*100);
        print("\$"*100);
        print("\$"*100);
        showDialog(
          context: context,
          builder: (ctx) => PopUpMessage(
            title: 'Qr not Found',
            message: 'Wrong QR',
          ),
        );
      }*/
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
