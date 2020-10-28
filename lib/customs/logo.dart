import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String primary;
  final String secondary;
  final double width;
  final double height;

  const Logo(
      {Key key,
        @required this.primary,
        this.width = 400,
        this.height = 155,
        this.secondary = "Polling made easy"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(children: [
          Text(
            primary + " ",
            style: TextStyle(
              fontSize: 100,
              fontFamily: 'Bandakala',
              color: Color(0xffF86624),
              height: 1.6
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              secondary,
              style: TextStyle(
                fontSize: 32,
                fontFamily: 'Bandakala',
                color: Color(0xff22AAA1),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}