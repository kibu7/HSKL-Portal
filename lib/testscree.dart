import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    body: new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
              'HI',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),
            ),
      ],
    ),
  );
  }
}


