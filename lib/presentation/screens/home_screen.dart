import 'package:flutter/material.dart';
import '../../data/models/stat.dart';
import '../../data/models/word.dart';
import '../../db/stats_db.dart';
import '../../db/words_db.dart';
import '../../logic/reminder_logic.dart';
import '../../services/nofication_service.dart';
import '../../services/preferences_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, int> sp_range = {"start": 0, "end": 0};
  int sp_freq = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PreferencesService.init().then((_) {
      loadPrefs();
      print(PreferencesService.getGameTime());
      if(PreferencesService.getGameTime().isNotEmpty){
        Navigator.pushNamed(context, '/test');
      }
    });
    // loadPrefs();
  }

  void loadPrefs() {
    setState(() {
      sp_freq = PreferencesService.getFrequency();
      sp_range = PreferencesService.getRange();
      print(sp_range);
    });
  }

  void setPrefs() {
    PreferencesService.setFrequency(10);
    PreferencesService.setRange(start: 0, end: 1);
    loadPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WordsWidget(),
              Divider(height: 30),
              StatsWidget(),
              Divider(height: 30),
              MaterialButton(
                  child: Text("Scheduled"),
                  onPressed: () {
                    NotificationService.showNotification(
                      title: "New word is ready !",
                      body: "Improve your knowledge",
                      // scheduled: true,
                      // interval: 5
                    );
                  }),
              Divider(height: 30),
              Text(
                  "RANGE: ${sp_range["start"]}:00 - ${sp_range["end"]}:00\nFREQ: ${sp_freq}"),
              MaterialButton(
                  child: Text("Set"),
                  onPressed: () {
                    setPrefs();
                  }),
              MaterialButton(
                onPressed: () {
                  ReminderLogic().createNextReminder();
                },
                child: Text('Logic'),
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/test');
                },
                child: Text('Test screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WordsWidget extends StatefulWidget {
  @override
  State<WordsWidget> createState() => _WordsWidgetState();
}

class _WordsWidgetState extends State<WordsWidget> {
  String text = "Null";

  @override
  Widget build(BuildContext context) {
    return Column(
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
                      created: DateTime.now()),
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
                          "ID: ${word.id},\nWORD: ${word.word},\nMEANING: ${word.meaning},\nTAG: ${word.tag},\nPLAYED: ${word.played}\nCREATED: ${word.created}\n\n";
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
      ],
    );
  }
}

class StatsWidget extends StatefulWidget {
  @override
  State<StatsWidget> createState() => _StatsWidgetState();
}

class _StatsWidgetState extends State<StatsWidget> {
  String text2 = "Null";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
    );
  }
}
