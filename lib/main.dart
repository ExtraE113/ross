import 'package:Ross/customs/main_action_button.dart';
import 'package:Ross/customs/screen_column.dart';
import 'package:Ross/participant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:Ross/create.dart';
import 'package:firebase_core/firebase_core.dart';

import 'customs/logo.dart';

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
    return ScreenColumn(
          logo: Logo(
            primary: "Ross",
            width: 350,
          ),
          children: [
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
        );
  }
}
