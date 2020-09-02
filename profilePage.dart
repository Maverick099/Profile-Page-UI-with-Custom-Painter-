import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutterProfilePage/GlobalVariables.dart' as global;

class ProfilePage extends StatefulWidget {
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double profileRadius = 149.0;

  @override
  Widget build(BuildContext context) {
    final double centerX = MediaQuery.of(context).size.width / 2;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Positioned(
                top: 0.0,
                left: centerX - 700 / 2,
                child: SizedBox(
                  width: 700,
                  height: 700,
                  child: CustomPaint(
                    painter: OvalPainter(xOff: centerX - 700 / 2),
                    child: Container(),
                  ),
                )),
            Positioned(
              top: MediaQuery.of(context).padding.top,
              left: 0.0,
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.topCenter,
                child: AppBar(
                  title: Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  leading: Container(),
                  elevation: 0.0,
                  centerTitle: true,
                  primary: true,
                ),
              ),
            ),
            Positioned(
              top: 150.0,
              left: centerX - profileRadius / 2,
              child: Container(
                height: profileRadius,
                width: profileRadius,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('lib/assets/testProfileImage.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              top: 400.0,
              child: ProfileFields(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          semanticLabel: 'back',
          size: 30.0,
        ),
      ),
    );
  }
}

class OvalPainter extends CustomPainter {
  double xOff;
  OvalPainter({this.xOff});
  @override
  void paint(Canvas canvas, Size size) {
    Color blue1 = Colors.blue;
    Color blue2 = Colors.blue.withOpacity(0.50);
    Color blue3 = Colors.blue.withOpacity(0.20);
    double angle = (pi / 180) * 45;

    Rect oval1Rect = Rect.fromCenter(
      center: Offset(5.0, 0.0),
      height: 500.47,
      width: 700.29,
    );
    Rect oval2Rect = Rect.fromCenter(
      center: Offset(10.0, -10.0),
      height: 540.47,
      width: 750.29,
    );
    Rect oval3Rect = Rect.fromCenter(
      center: Offset(20.0, -20.0),
      height: 580.47,
      width: 790.29,
    );
    canvas.translate(xOff + 310, 50);
    canvas.rotate(angle);
    canvas.drawOval(oval1Rect, Paint()..color = blue1);
    canvas.drawOval(oval2Rect, Paint()..color = blue2);
    canvas.drawOval(oval3Rect, Paint()..color = blue3);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ProfileFields extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300.0,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProfileFieldItems(
            height: 50.0,
            width: 300.0,
            initText: global.firstName,
            fontSize: 24.0,
            labelText: 'First Name',
            onSubmitted: (String value) {
              global.firstName = value;
            },
          ),
          ProfileFieldItems(
            height: 50.0,
            width: 300.0,
            initText: global.lastName,
            fontSize: 24.0,
            labelText: 'Last Name',
            onSubmitted: (String value) {
              global.lastName = value;
            },
          ),
          ProfileFieldItems(
            height: 50.0,
            width: 300.0,
            initText: global.emailId,
            labelText: 'Email Id',
            fontSize: 12.0,
            onSubmitted: (String value) {
              global.emailId = value;
            },
          )
        ],
      ),
    );
  }
}

class ProfileFieldItems extends StatefulWidget {
  final double height;
  final double width;
  final String initText;
  final double fontSize;
  final Function onSubmitted;
  final String labelText;
  ProfileFieldItems({
    @required this.height,
    @required this.width,
    @required this.fontSize,
    this.initText = '',
    this.onSubmitted,
    this.labelText,
  });

  _ProfilePageItemsState createState() => _ProfilePageItemsState();
}

class _ProfilePageItemsState extends State<ProfileFieldItems> {
  TextEditingController textController;
  TextEditingController alertTextController;
  String text;
  bool isEditing = false;
  @override
  void initState() {
    super.initState();
    textController = TextEditingController(text: widget.initText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: TextField(
        readOnly: true,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
        controller: textController,
        decoration: InputDecoration(
          focusColor: Colors.blueAccent[50],
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          suffixIcon: Icon(Icons.edit),
          labelStyle: TextStyle(
            fontSize: 16.0,
          ),
        ),
        onTap: () {
          openAlertDialougue(widget.labelText);
        },
      ),
    );
  }

  Future<void> openAlertDialougue(
    String textValue,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return Container(
          width: 400.0,
          height: 100.0,
          child: Platform.isAndroid
              ? AlertDialog(
                  title: Text('Change $textValue'),
                  content: TextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    controller: alertTextController,
                    decoration: InputDecoration(
                      focusColor: Colors.blueAccent[50],
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      suffixIcon: Icon(Icons.edit),
                      labelStyle: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Submit'),
                      onPressed: () {
                        widget.onSubmitted(alertTextController.text);
                        textController.text = alertTextController.text;
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                    ),
                    FlatButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                )
              : CupertinoAlertDialog(
                  title: Title(
                      color: Colors.black, child: Text('Change $textValue')),
                  content: CupertinoTextField(
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                    controller: alertTextController,
                    decoration: BoxDecoration(border: Border.all(width: 1.0)),
                  ),
                  actions: <Widget>[
                    CupertinoButton(
                      child: Text('Submit'),
                      onPressed: () {
                        widget.onSubmitted(alertTextController.text);
                        textController.text = alertTextController.text;
                        setState(() {});
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: Text('Cancel'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
        );
      },
    );
  }
}
