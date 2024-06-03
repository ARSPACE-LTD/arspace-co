import 'dart:developer';
import 'dart:io';

import 'package:arspace_co/util/all_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../util/app_assets.dart';
import '../../util/dimens.dart';
import '../../util/string.dart';
import '../../util/theme.dart';
import '../../widgets/commontext.dart';
import '../history/history_logic.dart';

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  bool isFlashOn = false;
  bool isCodeScanned = false;

  late HistoryLogic ticketHistoryController;


  @override
  void initState() {
    super.initState();
    ticketHistoryController = Get.put(HistoryLogic(state: Get.find()));
    ticketHistoryController.initialized;
    isCodeScanned = false;
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.050),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Image(
                      width: 30.0,
                      height: 30.0,
                      image: AssetImage(AssetPath.ar_icon),
                    ),

                    SizedBox(width: 10,),
                    CommonTextWidget(
                      heading: AppString.app_name,
                      fontSize: Dimens.thirtySix,
                      color: ThemeProvider.whiteColor,
                      fontFamily: 'Lexend',
                      fontWeight: FontWeight.w800,
                    ),

                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: _buildQrView(context),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () async {
                  await controller?.toggleFlash();
                  setState(() {
                    isFlashOn = !isFlashOn;
                  });
                },
                child: Icon(
                  isFlashOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    final scanArea = (MediaQuery.of(context).size.width < 300 || MediaQuery.of(context).size.height < 400) ? 150.0 : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.purple,
        borderRadius: 30,
        borderLength: 80,
        borderWidth: 20,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {

      if (!isCodeScanned) { // Check if the code has not been scanned yet
        setState(() {
          result = scanData;
          print("scanData reslut ===== $scanData");

          ticketHistoryController.CheckTicket(scanData.code.toString() ,context);
          isCodeScanned = true;
          Get.back();// Set the flag to true after scanning the code
        });
      }

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

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }


}