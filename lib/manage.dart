import 'package:Ross/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Manage extends StatelessWidget {
  final String id;

  const Manage({Key key, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9CAB3),
      body: Center(
        child: FittedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              TopBar(id: id),
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: SizedBox(
                  width: 300,
                  height: 155,
                  child: Stack(children: [
                    Text(
                      "Share ",
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
                        "Share this code with your respondents",
                        style:
                            TextStyle(fontSize: 50, fontFamily: "Huruf Miranti"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "When you're ready, click Let's go! If anyone's running late they can join any time.",
                        style:
                            TextStyle(fontSize: 25, fontFamily: "Huruf Miranti"),
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
                            fontSize: 25, fontFamily: "Bazar", letterSpacing: 3),
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
          ),
        ),
      ),
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
                  width: 322,
                  height: 155,
                  child: Stack(children: [
                    Text(
                      "Watch ",
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
                        "Watch your responses roll in",
                        style:
                            TextStyle(fontSize: 50, fontFamily: "Huruf Miranti"),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "When you're done with this question, type a new one in the box. Click \"Update\" and it'll magically change on all your respondents's screens instantly\n" +
                            (!show
                                ? "Click show to show your participants the data."
                                : "Click hide to hide the data from your participants."),
                        style:
                            TextStyle(fontSize: 25, fontFamily: "Huruf Miranti"),
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
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
    this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1220,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  id != null ? id : "",
                  style: TextStyle(
                    fontFamily: "Bazar",
                    fontSize: 30,
                    letterSpacing: 3,
                  ),
                ),
                //kept in for spacing
                Text(
                  "",
                  style: TextStyle(
                    fontFamily: "Bazar",
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  "EZRA NEWMAN",
                  style: TextStyle(
                    fontFamily: "Bazar",
                    fontSize: 30,
                  ),
                ),
                Text(
                  "PROUDLY PRESENTS",
                  style: TextStyle(
                    fontFamily: "Bazar",
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class OpinionBar extends StatelessWidget {
  final String id;

  const OpinionBar({
    Key key,
    @required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.doc("rooms/" + id).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading...");
          }
          return Stack(
            children: [
              SizedBox(height: 10),
              Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    height: 10,
                    decoration: BoxDecoration(
                      color: Color(0xffF86624),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              for (var i in snapshot.data["responses"].values)
                Positioned(
                  child: SizedBox(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xff22AAA1).withOpacity(0.75),
                      ),
                    ),
                    height: 30,
                    width: 10,
                  ),
                  left: ((i - 1) * (700 - 20) / 9) + 5,
                ),
            ],
          );
        });
  }
}
