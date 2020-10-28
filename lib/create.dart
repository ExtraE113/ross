import 'dart:math';

import 'package:Ross/customs/main_action_button.dart';
import 'package:Ross/manage.dart';
import 'package:Ross/main.dart';
import 'package:Ross/utils.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'customs/logo.dart';
import 'customs/screen_column.dart';

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

      String roomID = Utils.generateRandomString(6);
      await rooms
          .doc(roomID)
          .set({'question': question, "responses": {}, "show": false})
          .then((value) => print("Room created"))
          .catchError((error) => print("Failed to create room: $error"));
      return roomID;
    }

    return ScreenColumn(
        logo: Logo(
          primary: "Create",
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
                      height: 1.6,
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
          SizedBox(height: 70)
        ],
      );
  }
}
