import 'package:flutter/material.dart';

class TestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Hello'),
            MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('pop'),
            )
          ],
        ),
      ),
    );
  }
}
