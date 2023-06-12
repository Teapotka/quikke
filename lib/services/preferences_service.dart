import 'package:shared_preferences/shared_preferences.dart';

class PreferencesFields {
  static const String start = "start_pref";
  static const String end = "end_pref";
  static const String frequency = "frequency_pref";
  static const String gameTime = "gametime_pref";

  static final List<String> values = [start, end, frequency, gameTime];
}

class PreferencesDefaultState{
  static const frequency = 1;
  static const start = 9;
  static const end = 12;
  static const gameTime = "";
}

class PreferencesService {
  static SharedPreferences? preferences;

  static Future init() async {
    return await SharedPreferences.getInstance().then((pref) {
      if(preferences == null){
        preferences = pref;
        print('init state');
        // print(preferences!.getInt(PreferencesFields.start));
        // _initState();
      }
      print("if no message before - no init");
      return preferences;
    });
  }

  // static Future<void> _initState() async {
  //   if(preferences!.getInt(PreferencesFields.start) != 0){
  //
  //   }
  //   Future.wait([
  //     setFrequency(PreferencesDefaultState.frequency),
  //     setRange(
  //         start: PreferencesDefaultState.start,
  //         end: PreferencesDefaultState.end
  //     ),
  //     setGameTime(PreferencesDefaultState.gameTime),
  //   ]);
  // }

  static Future<void> setFrequency(int frequency) async {
    await preferences!.setInt(PreferencesFields.frequency, frequency);
  }

  static Future<void> setRange({required int start, required int end}) async {
    Future.wait([
      preferences!.setInt(PreferencesFields.start, start),
      preferences!.setInt(PreferencesFields.end, end),
    ]);
  }

  static Future<void> setGameTime(String gameTime) async {
    await preferences!.setString(PreferencesFields.gameTime, gameTime);
  }

  static int getFrequency() {
    return preferences!.getInt(PreferencesFields.frequency) ?? PreferencesDefaultState.frequency;
  }

  static Map<String, int> getRange() {
    final start = preferences!.getInt(PreferencesFields.start) ?? PreferencesDefaultState.start;
    final end = preferences!.getInt(PreferencesFields.end) ?? PreferencesDefaultState.end;
    return {"start": start, "end": end};
  }

  static String getGameTime() {
    return preferences!.getString(PreferencesFields.gameTime) ?? PreferencesDefaultState.gameTime;
  }
  static Future<void> resetAll() async {
    Future.wait([
      preferences!.setInt(PreferencesFields.start, PreferencesDefaultState.start),
      preferences!.setInt(PreferencesFields.end, PreferencesDefaultState.end),
      preferences!.setInt(PreferencesFields.frequency, PreferencesDefaultState.frequency),
      preferences!.setString(PreferencesFields.gameTime, PreferencesDefaultState.gameTime),
    ]);
  }
}
