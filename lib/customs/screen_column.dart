import 'package:Ross/customs/topbar.dart';
import 'package:flutter/material.dart';

import 'logo.dart';

class ScreenColumn extends StatelessWidget {
  final Logo logo;
  final TopBar topBar;
  final List<Widget> children;

  ScreenColumn({Key key,
    this.topBar = const TopBar(),
    this.children,
    @required this.logo}) : super(key: key) {
    this.children.insert(0, logo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFD9CAB3),
      body: Center(
        child: Column(
          children: [
            topBar,
            Spacer(),
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery
                      .of(context)
                      .size
                      .height - 200),
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: FittedBox(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: children
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
