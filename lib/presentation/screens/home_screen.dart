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
      print('INIT');
      print(PreferencesService.getGameTime());
      if (PreferencesService.getGameTime().isNotEmpty) {
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
    PreferencesService.setFrequency(1);
    PreferencesService.setRange(start: 9, end: 12);
    loadPrefs();
  }
  final someKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: ListView(children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        // await clearSP();
                        await startTest();
                      },
                      child: Text(
                        'start test algoritm',
                        style: TextStyle(backgroundColor: Colors.blue),
                      ),
                    ),
                    MaterialButton(
                      onPressed: () async {
                        // await clearSP();
                        await WordsDatabase.instance.resetAllStatuses();
                      },
                      child: Text(
                        'reset statuses',
                        style: TextStyle(backgroundColor: Colors.red),
                      ),
                    ),
                  ],
                ),
                // SizedBox(height: 500),
                WordsWidget(),
                Divider(height: 30),
                StatsWidget(),
                Divider(height: 30),
                PreferencesWidget(),
                // MaterialButton(
                //     child: Text("Scheduled"),
                //     onPressed: () {
                //       NotificationService.showNotification(
                //         title: "New word is ready !",
                //         body: "Improve your knowledge",
                //         // scheduled: true,
                //         // interval: 5
                //       );
                //     }),
                // Divider(height: 30),
                // Text(
                //     "RANGE: ${sp_range["start"]}:00 - ${sp_range["end"]}:00\nFREQ: ${sp_freq}"),
                // MaterialButton(
                //     child: Text("Set"),
                //     onPressed: () {
                //       setPrefs();
                //     }),
                // MaterialButton(
                //   onPressed: () {
                //     ReminderLogic().createNextReminder();
                //   },
                //   child: Text('Logic'),
                // ),
                // Divider(
                //   height: 30,
                // ),
                // WordController(),
                // MaterialButton(
                //   onPressed: () async {
                //     await PreferencesService.init();
                //     print(PreferencesService.getGameTime());
                //   },
                //   child: Text("get testTIME"),
                // ),
                // MaterialButton(
                //   onPressed: () async {
                //     print(await TestLogic().shouldRedirect());
                //   },
                //   child: Text("check"),
                // ),
                // MaterialButton(
                //   onPressed: () async {
                //     print(await TestLogic().checkMissed());
                //   },
                //   child: Text("missed"),
                // ),
                // MaterialButton(
                //   onPressed: () async {
                //     StatsDatabase.instance.create(
                //       Stat(
                //         result: Result.failed,
                //         time: DateTime.now().copyWith(
                //           day: 6,
                //           hour: 9,
                //           minute: 15,
                //         ),
                //       ),
                //     );
                //   },
                //   child: Text("add mock result"),
                // ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}


class PreferencesWidget extends StatefulWidget {
  const PreferencesWidget({Key? key}) : super(key: key);

  @override
  State<PreferencesWidget> createState() => _PreferencesWidgetState();
}

class _PreferencesWidgetState extends State<PreferencesWidget> {
  String text = "Null";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Shared Prefs"),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // MaterialButton(
            //   child: Text('add value'),
            //   onPressed: () {
            //     WordsDatabase.instance.create(
            //       Word(
            //         word: "besotted",
            //         meaning: "to be intoxicated by love",
            //         tag: "#C1",
            //       ),
            //     );
            //   },
            // ),
            MaterialButton(
              child: Text('reset all values'),
              color: Colors.red,
              onPressed: () async {
                await clearSP();
              },
            ),
            MaterialButton(
              child: Text('read all values'),
              onPressed: () async {
                final range = PreferencesService.getRange();
                final frequency = PreferencesService.getFrequency();
                final gameTime = PreferencesService.getGameTime();
                setState(() {
                  text =
                      'RANGE: ${range["start"]} - ${range["end"]}\nFREQUENCY: $frequency\nGAMETIME: $gameTime';
                });
              },
            ),
          ],
        ),
        Text(text, style: TextStyle(fontSize: 15)),
      ],
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
        Text("Words DB"),
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
                    // status: Status.played,
                    // id: 6,
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
                          "ID: ${word.id},\nWORD: ${word.word},\nMEANING: ${word.meaning},\nTAG: ${word.tag},\nCREATED: ${word.created}\nSTATUS: ${word.status.name}\n\n";
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
        Text("Stats DB"),
        Container(
          child: Column(
            children: [
              MaterialButton(
                child: Text('add value'),
                onPressed: () {
                  StatsDatabase.instance.create(
                    Stat(result: Result.guessed,
                      time: DateTime(2023, 6, 6, 9, 0),
                      // guesses: 1,
                      // failures: 5,
                      // day: DateTime.now(),
                    ),
                  );
                },
              ),
              MaterialButton(
                child: Text('create for today'),
                onPressed: () async {
                  await StatsDatabase.instance.createStatsForDay( DateTime(2023, 6, 6, 10, 03));
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
                      if(stats.isNotEmpty)
                        stats.forEach((stat) {
                          text2 +=
                          "ID: ${stat.id},\nRESULT: ${stat.result}\nTIME: ${stat.time}\n\n";
                        });
                      else
                        text2 = 'Empty';
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
        ),
        Text(text2, style: TextStyle(fontSize: 15)),
      ],
    );
  }
}

class WordController extends StatefulWidget {
  const WordController({Key? key}) : super(key: key);

  @override
  State<WordController> createState() => _WordControllerState();
}

class _WordControllerState extends State<WordController> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController wordController = TextEditingController();
  final TextEditingController meaningController = TextEditingController();
  final TextEditingController tagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(label: Text('word')),
                  controller: wordController,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(label: Text('meaning')),
                  controller: meaningController,
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 100,
                child: TextFormField(
                  decoration: InputDecoration(
                    label: Text('tag'),
                    prefixText: "#",
                  ),
                  controller: tagController,
                ),
              ),
            ],
          ),
          MaterialButton(
            child: Text('add word'),
            onPressed: () {
              print(
                'WORD: ${wordController.text} '
                '| MEANING: ${meaningController.text} '
                '| TAG: ${tagController.text}',
              );
              final word = wordController.text.trim();
              final meaning = meaningController.text.trim();
              final tag = '#${tagController.text}'.trim();
              WordsDatabase.instance.create(Word(
                word: word,
                meaning: meaning,
                tag: tag,
              ));
            },
          ),
        ],
      ),
    );
  }
}
