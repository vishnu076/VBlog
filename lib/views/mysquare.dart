import 'package:flutter/material.dart';
class MySquare extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: Colors.grey,
        child: Text(
            "oj}"
        ),
      ),
    );

  }
}