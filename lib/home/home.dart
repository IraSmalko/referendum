import 'dart:async';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pigment/pigment.dart';

class HomeScreen extends StatefulWidget {
  static final String path = "/";

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  String qr;

  Animation<double> anim;
  AnimationController animController;

  @override
  void initState() {
    super.initState();

    final int delay = 100;
    animController = AnimationController(duration: Duration(milliseconds: 1000 + delay), vsync: this);
    anim = Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(parent: animController, curve: Curves.elasticInOut))
      ..addListener(() {
        setState(() {});
      });

    animController.forward();
  }

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
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Pigment.fromString("#ff6a00"), Pigment.fromString("#ee0979")])),
          ),
          Container(
            decoration:
                BoxDecoration(gradient: RadialGradient(radius: 0.45, colors: [Colors.black, Colors.transparent])),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(width * 0.2),
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: FadeTransition(
                    opacity: anim,
                    child: ScaleTransition(
                      scale: anim,
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
