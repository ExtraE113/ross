import 'package:Ross/manage.dart';
import 'package:Ross/participant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Ross/create.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ross | Home',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage()
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(color: Color(0xFFD9CAB3)),
        Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Column(
              children: [
                TopBar(),
                SizedBox(height: 100),
                SizedBox(
                  width: 400,
                  height: 155,
                  child: Stack(children: [
                    Text(
                      "Ross ",
                      style: TextStyle(
                        fontSize: 100,
                        height: 1.6,
                        fontFamily: 'Bandakala',
                        color: Color(0xffF86624),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Polling Made Easy",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Bandakala',
                          color: Color(0xff22AAA1),
                        ),
                      ),
                    ),
                  ]),
                ),
                SizedBox(height: 250),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    MainActionButton(
                      text: "JOIN A SESSION",
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Join();
                        }));
                      },
                    ),
                    MainActionButton(
                      text: "CREATE A SESSION",
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return Create();
                        }));
                      },
                    ),
                  ],
                ),
                SizedBox(height: 100)
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

class MainActionButton extends StatefulWidget {
  final String text;
  Function onTap;

  MainActionButton({Key key, @required this.text, this.onTap})
      : super(key: key);

  // const MainActionButton({
  //   Key key,
  // }) : super(key: key);

  @override
  _MainActionButtonState createState() => _MainActionButtonState();
}

class _MainActionButtonState extends State<MainActionButton> {
  static const double _largeSize = 36;
  static const double _smallSize = 24;
  double _size = _smallSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Visibility(
          maintainSize: true,
          maintainAnimation: true,
          maintainState: true,
          visible: false,
          child: Text(
            widget.text,
            style: TextStyle(
              fontFamily: 'Bazar',
              fontSize: _largeSize,
            ),
          ),
        ),
        GestureDetector(
          onTap: widget.onTap,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onHover: (_) {
              setState(() {
                _size = _largeSize;
              });
            },
            onExit: (_) {
              setState(() {
                _size = _smallSize;
              });
            },
            child: AnimatedDefaultTextStyle(
              duration: Duration(milliseconds: 20),
              style: TextStyle(
                fontSize: _size,
              ),
              child: Text(
                widget.text,
                style: TextStyle(
                  fontFamily: 'Bazar',
                  color: Color(0xff22AAA1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
