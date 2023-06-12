import 'package:flutter/material.dart';
import 'package:quikke/db/words_db.dart';
import 'package:quikke/logic/reminder_logic.dart';

import '../../data/models/word.dart';

class TestScreen extends StatefulWidget {
  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Word> options = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WordsDatabase.instance.readAll().then((words) {
      setState(() {
        options = words
            .where((word) =>
        word.status == Status.right || word.status == Status.wrong)
            .toList();
      });
      print(options);
    });
  }

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
            ),
            Column(
              children: [
                Text(
                  '${options.isNotEmpty ? options.where((word) => word.status == Status.right).toList().first.word : 'No word'}',
                ),
                QuizeButtons(options)
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class QuizeButtons extends StatelessWidget {
  List<Word> options = [];

  QuizeButtons(this.options);

  @override
  Widget build(BuildContext context) {
    return options.isNotEmpty
        ? Column(
            children: [
              MaterialButton(
                onPressed: () {
                  submitTest(options[0]);
                },
                child: Text('${options[0].id} - ${options[0].meaning} - ${options[0].status.name}'),
              ),
              MaterialButton(
                onPressed: () {
                  submitTest(options[1]);
                },
                child: Text('${options[1].id} - ${options[1].meaning} - ${options[1].status.name}'),
              ),
              MaterialButton(
                onPressed: () {
                  submitTest(options[2]);
                },
                child: Text('${options[2].id} - ${options[2].meaning} - ${options[2].status.name}'),
              ),
              MaterialButton(
                onPressed: () {
                  submitTest(options[3]);
                },
                child: Text('${options[3].id} - ${options[3].meaning} - ${options[3].status.name}'),
              ),
            ],
          )
        : Text('Empty');
  }
}
