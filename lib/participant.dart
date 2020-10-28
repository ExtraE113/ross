import 'dart:math';

import 'package:Ross/main.dart';
import 'package:Ross/manage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Join extends StatefulWidget {
  Join();

  @override
  _JoinState createState() => _JoinState();
}

class _JoinState extends State<Join> {
  String id = "";

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

    return Scaffold(
      backgroundColor: Color(0xFFD9CAB3),
      body: Center(
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TopBar(),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 300,
                  height: 155,
                  child: Stack(children: [
                    Text(
                      "Join ",
                      style: TextStyle(
                        fontSize: 100,
                        fontFamily: 'Bandakala',
                        color: Color(0xffF86624),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Polling made easy",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Bandakala',
                          color: Color(0xff22AAA1),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              SizedBox(
                width: 700,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Your host should give you a code.",
                        style:
                            TextStyle(fontSize: 50, fontFamily: "Huruf Miranti"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "Type it in here, then click Let's Go",
                        style:
                            TextStyle(fontSize: 25, fontFamily: "Huruf Miranti"),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      TextField(
                        onChanged: (text) {
                          setState(() {
                            id = text.toUpperCase();
                            print(id);
                          });
                        },
                        textAlign: TextAlign.center,
                        cursorColor: Colors.grey,
                        cursorWidth: 3,
                        inputFormatters: [UpperCaseTextFormatter()],
                        cursorRadius: Radius.circular(5),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: "Bazar",
                          letterSpacing: 3,
                        ),
                      ),
                      SizedBox(height: 100),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: MainActionButton(
                          text: "LET'S GO!",
                          onTap: () async {
                            bool exists = (await rooms.doc(id).get()).exists;
                            if (exists)
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return Respond(id: id);
                              }));
                            else
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Check input and try again"),
                              ));
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100)
            ],
          ),
        ),
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text?.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class Respond extends StatefulWidget {
  final String id;
  final r = Random();

  Respond({Key key, @required this.id}) : super(key: key);

  @override
  _RespondState createState() => _RespondState();
}

class _RespondState extends State<Respond> {
  double answer = 1.0;
  String part_id;
  String question = "";

  @override
  Widget build(BuildContext context) {
    if (part_id == null) {
      setState(() {
        part_id = widget.r.nextInt(100000).toString();
      });
    }
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

    return Scaffold(
      backgroundColor: Color(0xFFD9CAB3),
      body: Center(
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TopBar(id: widget.id),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 405,
                  height: 155,
                  child: Stack(children: [
                    Text(
                      "Respond ",
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
                        "Polling made easy",
                        style: TextStyle(
                          fontSize: 32,
                          fontFamily: 'Bandakala',
                          color: Color(0xff22AAA1),
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
              StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .doc("rooms/" + widget.id)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return Text("Loading...");
                    if (question != snapshot.data["question"])
                      Future.delayed(Duration(milliseconds: 100)).then((_) {
                        setState(() {
                          question = snapshot.data["question"];
                          answer = 1;
                        });
                      });
                    return SizedBox(
                      width: 700,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              snapshot.data["question"],
                              style: TextStyle(
                                  fontSize: 50, fontFamily: "Huruf Miranti"),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Slide to your response.",
                              style: TextStyle(
                                  fontSize: 25, fontFamily: "Huruf Miranti"),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 40),
                            SliderTheme(
                              data: SliderThemeData(
                                trackShape: CustomTrackShape(),
                                activeTrackColor: Color(0xffF86624),
                                trackHeight: 10,
                                thumbColor: Color(0xff22AAA1),
                                overlayShape:
                                    RoundSliderOverlayShape(overlayRadius: 0),
                              ),
                              child: Slider(
                                min: 1,
                                max: 10,
                                value: answer,
                                onChanged: (var value) {
                                  setState(() {
                                    answer = value;
                                  });
                                },
                                onChangeEnd: (var value) async {
                                  setState(() {
                                    answer = value;
                                  });
                                  await FirebaseFirestore.instance
                                      .doc("rooms/" + widget.id)
                                      .update({"responses." + part_id: value});
                                },
                              ),
                            ),
                            Visibility(
                              maintainSize: true,
                              maintainAnimation: true,
                              maintainState: true,
                              visible: snapshot.hasData && snapshot.data["show"],
                              child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  Text(
                                    "This is what other participants said:",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontFamily: "Huruf Miranti"),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 10),
                                  OpinionBar(id: widget.id),
                                ],
                              ),
                            ),
                            SizedBox(height: 40)
                          ],
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
