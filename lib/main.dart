import 'package:flutter/material.dart';
import 'package:quikke/data/models/word.dart';
import 'package:quikke/db/stats_db.dart';
import 'package:quikke/db/words_db.dart';
import 'package:quikke/logic/reminder_logic.dart';
import 'package:quikke/presentation/screens/home_screen.dart';
import 'package:quikke/presentation/screens/test_screen.dart';
import 'package:quikke/services/nofication_service.dart';
import 'package:quikke/services/preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/models/stat.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService.initialize();
  runApp(MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      navigatorKey: navigatorKey,
      routes: {
        "/home": (ctx)=> HomeScreen(),
        "/test": (ctx)=> TestScreen(),
      },
    );
  }
}

