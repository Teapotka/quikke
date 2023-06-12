import 'dart:math';

import 'package:quikke/data/models/stat.dart';
import 'package:quikke/db/stats_db.dart';
import 'package:quikke/db/words_db.dart';
import 'package:quikke/main.dart';
import 'package:quikke/services/nofication_service.dart';

import '../data/models/word.dart';
import '../services/preferences_service.dart';

class ReminderLogic {
  void createNextReminder() async {
    await PreferencesService.init();
    final range = PreferencesService.getRange();
    final frequency = PreferencesService.getFrequency();
    final startHour = range["start"]!;
    final endHour = range["end"]!;
    print('VARS: $startHour, $endHour, $frequency');
    final currentTime = DateTime(2023, 6, 6, 10, 03);
    // final currentTime = DateTime.now();
    final start = currentTime.copyWith(hour: startHour, minute: 0);
    final end = currentTime.copyWith(hour: endHour, minute: 0);

    if(!currentTime.difference(end).isNegative){
        print('too late');
        return null;
    }
    if(!start.difference(currentTime).isNegative){
      print('too early');
      return null;
    }

    PreferencesService.setGameTime(currentTime.add(Duration(minutes: 1)).toIso8601String());

    final interval = 60 * frequency;
    NotificationService.showNotification(
        title: "Scheduled",
        body: "at $currentTime for ${currentTime.add(Duration(minutes: 1))} with frequency $frequency",
        scheduled: true,
        interval: 5,
    );
  }
}

class TestLogic{
  void createNewTest() async {
    await PreferencesService.init();
    final testTimeString = PreferencesService.getGameTime();
    if(testTimeString.isEmpty){
      print("is EMPTY");
      return null;
    }
    final testTime = DateTime.parse(testTimeString);
    print(testTime);
    if(DateTime(2023, 6, 6, 11, 00).isBefore(testTime)){
      print("is BEFORE");
      return null;
    }
    navigatorKey.currentState?.pushNamed('/test');
  }
  Future<bool?> shouldRedirect() async{
    await PreferencesService.init();
    final testTimeString = PreferencesService.getGameTime();
    final range = PreferencesService.getRange();
    final endHour = range["end"]!;
    if(testTimeString.isEmpty){
      print("is EMPTY");
      return null;
    }
    final testTime = DateTime.parse(testTimeString);
    final end = testTime.copyWith(hour: endHour, minute: 59);
    return testTime.isBefore(end);
  }
  Future<List<bool>?> checkMissed() async {
    await PreferencesService.init();
    final testTimeString = PreferencesService.getGameTime();
    final range = PreferencesService.getRange();
    final endHour = range["end"]!;
    final startHour = range["start"]!;
    if(testTimeString.isEmpty){
      print("is EMPTY");
      return null;
    }
    final testTime = DateTime.parse(testTimeString);
    final intervals = [for(var i = startHour; i<= endHour; i++) i];
    print(intervals);
    final timeIntervals = intervals.map((i) => testTime.copyWith(hour: i, minute: 0));
    //TODO: take TODAY test records from db
    final stats = await StatsDatabase.instance.readAll();
    print("STATS: ${stats[0]}");
    final doneIntervals = timeIntervals.map((i) {
      // print('I $i');
      // stats
      if(testTime.difference(i).inHours == 0){
        return false;
      }
      return testTime.isAfter(i);
    }).toList();
    return doneIntervals;
  }
}
Future<void> clearSP() async{
  await PreferencesService.init();
  await PreferencesService.resetAll();
}

Future<void> startTest() async{
  await PreferencesService.init();
  final start = PreferencesService.getRange()['start']!;
  final end = PreferencesService.getRange()['end']!;
  final frequency = PreferencesService.getFrequency();
  final gameTime = PreferencesService.getGameTime();
  final words = await WordsDatabase.instance.readAll();
  var indicies = [];
  final length = words.length;
  while (indicies.length < 4) {
    int randomNumber = Random().nextInt(length);
    if (!indicies.contains(randomNumber)) {
      indicies.add(randomNumber);
    }
  }

  print(indicies);
  indicies.asMap().forEach((i, id) async {
    final word = await WordsDatabase.instance.read(id+1);
    //TODO: filter played
    print(word.toMap());

    WordsDatabase.instance.edit(word.copy(
      status: i == 0 ? Status.right : Status.wrong,
      created: DateTime.now()
    ));
  });

  final currentTime = DateTime(2023, 6, 6, 10, 03);
  // final currentTime = DateTime.now();
  final startHour = currentTime.copyWith(hour: start, minute: 0);
  final endHour = currentTime.copyWith(hour: end, minute: 0);

  if(!currentTime.difference(endHour).isNegative){
    print('too late');
    return null;
  }
  if(!startHour.difference(currentTime).isNegative){
    print('too early');
    return null;
  }

  PreferencesService.setGameTime(currentTime.add(Duration(minutes: 1)).toIso8601String());

  final interval = 60 * frequency;

  NotificationService.showNotification(
    title: "Scheduled",
    body: "at $currentTime for ${currentTime.add(Duration(minutes: 1))} with frequency $frequency",
    scheduled: true,
    interval: 5,
  );
}

Future<void> submitTest(Word word) async{
  await PreferencesService.init();
  PreferencesService.setGameTime(PreferencesDefaultState.gameTime);

  // WordsDatabase.instance.read(word.id);
  await StatsDatabase.instance.create(Stat(
      result: word.status == Status.right ? Result.guessed : Result.failed
  ));
}