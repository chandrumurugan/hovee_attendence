// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';

// class QRViewExample extends StatefulWidget {
//   @override
//   _QRViewExampleState createState() => _QRViewExampleState();
// }

// class _QRViewExampleState extends State<QRViewExample> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   QRViewController? controller;
//   String? scannedData;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           flex: 5,
//           child: QRView(
//             key: qrKey,
//             onQRViewCreated: _onQRViewCreated,
//              overlay: QrScannerOverlayShape(
//                     borderRadius: 10,
//                     borderColor: Colors.red,
//                     borderLength: 30,
//                     borderWidth: 10,
//                     cutOutSize: 300,
//                   ) ,
//           ),
//         ),
//         Expanded(
//           flex: 1,
//           child: Center(
//             child: (scannedData != null)
//                 ? Text('Scanned Code: $scannedData')
//                 : Text('Scan a code'),
//           ),
//         ),
//       ],
//     );
//   }

//   void _onQRViewCreated(QRViewController controller) {
//     this.controller = controller;
//     controller.scannedDataStream.listen((scanData) {
//       setState(() {
//         scannedData = scanData.code;
//       });

//       // Close scanner after scanning
//       if (scannedData != null) {
//         Navigator.pop(context, scannedData);
//       }
//     });
//   }

//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
