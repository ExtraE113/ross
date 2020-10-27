import 'dart:math';

import 'package:Ross/manage.dart';
import 'package:Ross/main.dart';
import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Create extends StatefulWidget {
  Create();

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  String question = "How much do you love me?";

  @override
  Widget build(BuildContext context) {
    // Create a CollectionReference called users that references the firestore collection
    CollectionReference rooms = FirebaseFirestore.instance.collection('rooms');

    Future<String> createRoom() async {
      // Call the user's CollectionReference to add a new user

      // I was lazy, so from https://stackoverflow.com/questions/61919395/how-to-generate-random-string-in-dart
      String generateRandomString(int len) {
        var r = Random();
        const _chars =
            'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
        return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
            .join().toUpperCase();
      }

      String roomID = generateRandomString(4);
      await rooms
          .doc(roomID)
          .set({'question': question, "responses": {}, "show": false})
          .then((value) => print("Room created"))
          .catchError((error) => print("Failed to create room: $error"));
      return roomID;
    }

    return Scaffold(
      backgroundColor: Color(0xFFD9CAB3),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TopBar(),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: SizedBox(
                width: 300,
                height: 155,
                child: Stack(children: [
                  Text(
                    "Create ",
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
                      "Start by entering your first question:",
                      style:
                          TextStyle(fontSize: 50, fontFamily: "Huruf Miranti"),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Don't worry, you can change this later.",
                      style:
                          TextStyle(fontSize: 25, fontFamily: "Huruf Miranti"),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    TextField(
                      onChanged: (text) {
                        setState(() {
                          if (text == "") {
                            text = "How much do you love me?";
                          }
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
                        fontFamily: "Bandakala",
                      ),
                    ),
                    SizedBox(height: 100),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: MainActionButton(
                        text: "LET'S GO!",
                        onTap: () async {
                          String id = await createRoom();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Manage(id: id);
                          }));
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
