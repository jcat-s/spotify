import 'package:hive/hive.dart';

part 'profile.g.dart';

@HiveType(typeId: 1)
class Profile extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String? musicDiary;

  @HiveField(3)
  String currentMood;

  @HiveField(4)
  DateTime lastUpdated;

  @HiveField(5)
  List<String> favoriteGenres;

  @HiveField(6)
  int totalSongsPlayed;

  @HiveField(7)
  Duration totalListeningTime;

  @HiveField(8)
  String profileTheme;

  @HiveField(9)
  String? personalNotes;

  @HiveField(10)
  String avatar;

  @HiveField(11)
  Map<String, dynamic> listeningCalendar;

  Profile({
    required this.id,
    this.name = 'Music Lover',
    this.musicDiary,
    this.currentMood = '🎵',
    DateTime? lastUpdated,
    this.favoriteGenres = const [],
    this.totalSongsPlayed = 0,
    this.totalListeningTime = Duration.zero,
    this.profileTheme = 'soft pink',
    this.personalNotes,
    this.avatar = '🌸',
    Map<String, dynamic>? listeningCalendar,
  }) : lastUpdated = lastUpdated ?? DateTime.now(),
       listeningCalendar = listeningCalendar ?? {};

  Profile copyWith({
    String? id,
    String? name,
    String? musicDiary,
    String? currentMood,
    DateTime? lastUpdated,
    List<String>? favoriteGenres,
    int? totalSongsPlayed,
    Duration? totalListeningTime,
    String? profileTheme,
    String? personalNotes,
    String? avatar,
    Map<String, dynamic>? listeningCalendar,
  }) {
    return Profile(
      id: id ?? this.id,
      name: name ?? this.name,
      musicDiary: musicDiary ?? this.musicDiary,
      currentMood: currentMood ?? this.currentMood,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      favoriteGenres: favoriteGenres ?? this.favoriteGenres,
      totalSongsPlayed: totalSongsPlayed ?? this.totalSongsPlayed,
      totalListeningTime: totalListeningTime ?? this.totalListeningTime,
      profileTheme: profileTheme ?? this.profileTheme,
      personalNotes: personalNotes ?? this.personalNotes,
      avatar: avatar ?? this.avatar,
      listeningCalendar: listeningCalendar ?? this.listeningCalendar,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'musicDiary': musicDiary,
      'currentMood': currentMood,
      'lastUpdated': lastUpdated.toIso8601String(),
      'favoriteGenres': favoriteGenres,
      'totalSongsPlayed': totalSongsPlayed,
      'totalListeningTime': totalListeningTime.inMilliseconds,
      'profileTheme': profileTheme,
      'personalNotes': personalNotes,
      'avatar': avatar,
      'listeningCalendar': listeningCalendar,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      id: map['id'] ?? '',
      name: map['name'] ?? 'Music Lover',
      musicDiary: map['musicDiary'],
      currentMood: map['currentMood'] ?? '🎵',
      lastUpdated:
          DateTime.tryParse(map['lastUpdated'] ?? '') ?? DateTime.now(),
      favoriteGenres: List<String>.from(map['favoriteGenres'] ?? []),
      totalSongsPlayed: map['totalSongsPlayed'] ?? 0,
      totalListeningTime: Duration(
        milliseconds: map['totalListeningTime'] ?? 0,
      ),
      profileTheme: map['profileTheme'] ?? 'soft pink',
      personalNotes: map['personalNotes'],
      avatar: map['avatar'] ?? '🌸',
      listeningCalendar: Map<String, dynamic>.from(
        map['listeningCalendar'] ?? {},
      ),
    );
  }
}
