import 'package:Ross/customs/main_action_button.dart';
import 'package:Ross/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'customs/logo.dart';
import 'customs/opinionbar.dart';
import 'customs/screen_column.dart';
import 'customs/topbar.dart';

class Manage extends StatelessWidget {
  final String id;

  const Manage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenColumn(
        topBar: TopBar(id: id),
        logo: Logo(
          primary: "Share",
          width: 300,
          height: 155,
        ),
        children: [
          SizedBox(
            width: 700,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Share this code with your respondents",
                    style: TextStyle(
                        fontSize: 50, fontFamily: "Huruf Miranti"),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "When you're ready, click Let's go! If anyone's running late they can join any time.",
                    style: TextStyle(
                        fontSize: 25, fontFamily: "Huruf Miranti"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 40),
                  TextField(
                    textAlign: TextAlign.center,
                    showCursor: false,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    style: TextStyle(
                        fontSize: 25,
                        fontFamily: "Bazar",
                        letterSpacing: 3),
                    enabled: false,
                    controller: TextEditingController()
                      ..text = id.toUpperCase(),
                  ),
                  SizedBox(height: 100),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: MainActionButton(
                      text: "LET'S GO!",
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) {
                          return Responses(id: id);
                        }));
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: 70)
        ],
      );
  }
}

class Responses extends StatefulWidget {
  final String id;

  const Responses({Key key, @required this.id}) : super(key: key);

  @override
  _ResponsesState createState() => _ResponsesState();
}

class _ResponsesState extends State<Responses> {
  String question;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

    return ScreenColumn(
        topBar: TopBar(id: widget.id),
        logo: Logo(
          primary: "Watch",
          width: 322,
          height: 155,
        ),
        children: [
          SizedBox(
            width: 700,
            child: Center(
              child: Column(
                children: [
                  Text(
                    "Watch your responses roll in",
                    style: TextStyle(
                        fontSize: 50, fontFamily: "Huruf Miranti"),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "When you're done with this question, type a new one in the box. Click \"Update\" and it'll magically change on all your respondents's screens instantly\n" +
                        (!show
                            ? "Click show to show your participants the data."
                            : "Click hide to hide the data from your participants."),
                    style: TextStyle(
                        fontSize: 25, fontFamily: "Huruf Miranti"),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  OpinionBar(id: widget.id),
                  SizedBox(height: 40),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        question = text;
                      });
                    },
                    textAlign: TextAlign.center,
                    cursorColor: Colors.grey,
                    cursorWidth: 3,
                    cursorRadius: Radius.circular(5),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      hintText: 'How much do you love me?',
                      hintStyle: TextStyle(
                        fontSize: 25,
                        fontFamily: "Bandakala",
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.black, width: 1),
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 25,
                      height: 1.6,
                      fontFamily: "Bandakala",
                    ),
                  ),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MainActionButton(
                        text: !show ? "SHOW" : "HIDE",
                        onTap: () async {
                          setState(() {
                            show = !show;
                          });
                          await rooms
                              .doc(widget.id)
                              .update({"show": show})
                              .then((value) => print("show updated"))
                              .catchError((error) =>
                                  print("Failed to update show: $error"));
                        },
                      ),
                      MainActionButton(
                        text: "UPDATE!",
                        onTap: () async {
                          setState(() {
                            show = false;
                          });
                          await rooms
                              .doc(widget.id)
                              .set({
                                'question': question,
                                "responses": {},
                                "show": false
                              })
                              .then((value) => print("question set"))
                              .catchError((error) =>
                                  print("Failed to set question: $error"));
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 70)
                ],
              ),
            ),
          ),
        ],
      );
  }
}
