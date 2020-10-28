import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    Key key,
    this.id,
  }) : super(key: key);

  final String id;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}