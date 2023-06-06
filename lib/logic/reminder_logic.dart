import 'package:quikke/main.dart';
import 'package:quikke/services/nofication_service.dart';

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
    if(currentTime.difference(end).inHours == 0){
      print('out');
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
}
