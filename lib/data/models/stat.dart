const String tableStats = 'stats';

class StatFields {
  static const String id = "_id";
  static const String guesses = "guesses";
  static const String failures = "failures";
  static const String day = "day";

  static final List<String> values = [id, guesses, failures, day];
}

class Stat {
  int? id;
  int guesses;
  int failures;
  DateTime day;

  Stat({
    this.id,
    required this.guesses,
    required this.failures,
    required this.day,
  });

  Map<String, dynamic> toMap() => ({
    StatFields.id: id,
    StatFields.guesses: guesses,
    StatFields.failures: failures,
    StatFields.day: day.toIso8601String(),
  });

  factory Stat.fromMap(Map<String, dynamic> map) {
    return Stat(
      id: map[StatFields.id] as int?,
      guesses: map[StatFields.guesses] as int,
      failures: map[StatFields.failures] as int,
      day: DateTime.parse(map[StatFields.day] as String),
    );
  }

  Stat copy({
    int? id,
    int? guesses,
    int? failures,
    DateTime? day,
  }) =>
      Stat(
        id: id ?? this.id,
        guesses: guesses ?? this.guesses,
        failures: failures ?? this.failures,
        day: day ?? this.day,
      );
}
