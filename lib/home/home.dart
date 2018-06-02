import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  static final String path = "/";

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String qr;

  Future _scanQR() async {
    try {
      String qr = await BarcodeScanner.scan();
      setState(() => this.qr = qr);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text('You must grant the camera permission to scan QR codes')));
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Unknown error: $e')));
      }
    } on FormatException {} catch (e) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Unknown error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      body: new Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(gradient: RadialGradient(radius: 0.45, colors: [Colors.black, Colors.red])),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(width * 0.2),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: FlatButton(
                    color: Colors.white,
                    child: Text(
                      "Scan QR",
                      style: TextStyle(color: Colors.black),
                      textScaleFactor: 2.0,
                    ),
                    shape: CircleBorder(),
                    onPressed: _scanQR,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("QR: $qr"),
          ),
        ],
      ),
    );
  }
}
