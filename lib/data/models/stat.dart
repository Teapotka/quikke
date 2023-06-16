const String tableStats = 'stats';

class StatFields {
  static const String id = "_id";
  // static const String guesses = "guesses";
  // static const String failures = "failures";
  static const String result = "result";
  static const String time = "time";

  static final List<String> values = [id, result, time];
}

enum Result {guessed, failed, waiting}

class Stat {
  int? id;
  // int guesses;
  // int failures;
  Result result;
  DateTime? time;

  Stat({
    this.id,
    required this.result,
    // required this.failures,
    DateTime? time,
  }) : time = time ?? DateTime.now();

  Map<String, dynamic> toMap() => ({
    StatFields.id: id,
    // StatFields.guesses: guesses,
    // StatFields.failures: failures,
    StatFields.result: result.name,
    StatFields.time: time?.toIso8601String(),
  });

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      id: map[StatFields.id] as int?,
      // guesses: map[StatFields.guesses] as int,
      // failures: map[StatFields.failures] as int,
      result: Result.values.byName(map["result"] as String),
      time: DateTime.parse(map[StatFields.time] as String),
    );
  }

  Stat copy({
    int? id,
    // int? guesses,
    // int? failures,
    Result? result,
    DateTime? time,
  }) =>
      Stat(
        id: id ?? this.id,
        // guesses: guesses ?? this.guesses,
        // failures: failures ?? this.failures,
        result:  result ?? this.result,
        time: time ?? this.time,
      );
}
