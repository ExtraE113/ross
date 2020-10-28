import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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