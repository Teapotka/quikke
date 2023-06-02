const String tableWords = 'words';

class WordFields {
  static const String id = "_id";
  static const String word = "word";
  static const String meaning = "meaning";
  static const String tag = "tag";
  static const String played = "played";
  static const String created = "created";

  static final List<String> values = [id, word, meaning, tag, played, created];
}

class Word {
  int? id;
  String word;
  String meaning;
  String tag;
  bool played;
  DateTime created;

  Word({
    this.id,
    required this.word,
    required this.meaning,
    required this.tag,
    required this.played,
    required this.created,
  });

  Map<String, dynamic> toMap() => ({
        WordFields.id: id,
        WordFields.word: word,
        WordFields.meaning: meaning,
        WordFields.tag: tag,
        WordFields.played: played ? 1 : 0,
        WordFields.created: created.toIso8601String(),
      });

  factory Word.fromMap(Map<String, dynamic> map) {
    return Word(
      id: map[WordFields.id] as int?,
      word: map[WordFields.word] as String,
      meaning: map[WordFields.meaning] as String,
      tag: map[WordFields.tag] as String,
      played: map[WordFields.played] == 1,
      created: DateTime.parse(map[WordFields.created] as String),
    );
  }

  Word copy({
    int? id,
    String? word,
    String? meaning,
    String? tag,
    bool? played,
    DateTime? created,
  }) =>
      Word(
        id: id ?? this.id,
        word: word ?? this.word,
        meaning: meaning ?? this.meaning,
        tag: tag ?? this.tag,
        played: played ?? this.played,
        created: created ?? this.created,
      );
}
