import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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