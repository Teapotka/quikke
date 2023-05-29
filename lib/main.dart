import 'package:flutter/material.dart';
import 'package:quikke/data/models/word.dart';
import 'package:quikke/db/stats_db.dart';
import 'package:quikke/db/words_db.dart';

import 'data/models/stat.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body: TestDB()),
    );
  }
}

class TestDB extends StatefulWidget {
  @override
  State<TestDB> createState() => _TestDBState();
}

class _TestDBState extends State<TestDB> {
  String text = "Null";
  String text2 = "Null";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: Text('add value'),
                  onPressed: () {
                    WordsDatabase.instance.create(
                      Word(
                        word: "besotted",
                        meaning: "to be intoxicated by love",
                        tag: "#C1",
                        played: false,
                      ),
                    );
                  },
                ),
                MaterialButton(
                  child: Text('delete all values'),
                  color: Colors.red,
                  onPressed: () {
                    WordsDatabase.instance.clearAll();
                  },
                ),
                MaterialButton(
                  child: Text('read all values'),
                  onPressed: () async {
                    try {
                      final words = await WordsDatabase.instance.readAll();
                      setState(() {
                        text = "";
                        words.forEach((word) {
                          text +=
                              "ID: ${word.id},\nWORD: ${word.word},\nMEANING: ${word.meaning},\nTAG: ${word.tag},\nPLAYED: ${word.played}\n\n";
                        });
                      });
                    } catch (e) {
                      if ((e as dynamic).message == "not found")
                        setState(() {
                          text = "Empty";
                        });
                    }
                  },
                ),
              ],
            ),
            Text(text, style: TextStyle(fontSize: 15)),
            Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MaterialButton(
                  child: Text('add value'),
                  onPressed: () {
                    StatsDatabase.instance.create(
                      Stat(
                        guesses: 1,
                        failures: 5,
                        day: DateTime.now(),
                      ),
                    );
                  },
                ),
                MaterialButton(
                  child: Text('delete all values'),
                  color: Colors.red,
                  onPressed: () {
                    StatsDatabase.instance.clearAll();
                  },
                ),
                MaterialButton(
                  child: Text('read all values'),
                  onPressed: () async {
                    try {
                      final stats = await StatsDatabase.instance.readAll();
                      setState(() {
                        text2 = "";
                        stats.forEach((stat) {
                          text2 +=
                              "ID: ${stat.id},\nGUESSES: ${stat.guesses},\nFAILURES: ${stat.failures},\nDAY: ${stat.day}\n\n";
                        });
                      });
                    } catch (e) {
                      if ((e as dynamic).message == "not found")
                        setState(() {
                          text2 = "Empty";
                        });
                    }
                  },
                ),
              ],
            ),
            Text(text2, style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
    );
  }
}
