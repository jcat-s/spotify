import 'package:hive/hive.dart';

part 'song.g.dart';

@HiveType(typeId: 0)
class Song extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String artist;

  @HiveField(3)
  final String album;

  @HiveField(4)
  final String albumArtPath;

  @HiveField(5)
  final String audioPath;

  @HiveField(6)
  final Duration duration;

  @HiveField(7)
  bool isFavorite;

  @HiveField(8)
  List<String> emojiReactions;

  @HiveField(9)
  List<String> moodTags;

  @HiveField(10)
  String? tinyReview;

  @HiveField(11)
  String? lyrics;

  @HiveField(12)
  String genre;

  Song({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.albumArtPath,
    required this.audioPath,
    required this.duration,
    this.isFavorite = false,
    this.emojiReactions = const [],
    this.moodTags = const [],
    this.tinyReview,
    this.lyrics,
    this.genre = 'Pop',
  });

  Song copyWith({
    String? id,
    String? title,
    String? artist,
    String? album,
    String? albumArtPath,
    String? audioPath,
    Duration? duration,
    bool? isFavorite,
    List<String>? emojiReactions,
    List<String>? moodTags,
    String? tinyReview,
    String? lyrics,
    String? genre,
  }) {
    return Song(
      id: id ?? this.id,
      title: title ?? this.title,
      artist: artist ?? this.artist,
      album: album ?? this.album,
      albumArtPath: albumArtPath ?? this.albumArtPath,
      audioPath: audioPath ?? this.audioPath,
      duration: duration ?? this.duration,
      isFavorite: isFavorite ?? this.isFavorite,
      emojiReactions: emojiReactions ?? this.emojiReactions,
      moodTags: moodTags ?? this.moodTags,
      tinyReview: tinyReview ?? this.tinyReview,
      lyrics: lyrics ?? this.lyrics,
      genre: genre ?? this.genre,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artist': artist,
      'album': album,
      'albumArtPath': albumArtPath,
      'audioPath': audioPath,
      'duration': duration.inMilliseconds,
      'isFavorite': isFavorite,
      'emojiReactions': emojiReactions,
      'moodTags': moodTags,
      'tinyReview': tinyReview,
      'lyrics': lyrics,
      'genre': genre,
    };
  }

  factory Song.fromMap(Map<String, dynamic> map) {
    return Song(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      artist: map['artist'] ?? '',
      album: map['album'] ?? '',
      albumArtPath: map['albumArtPath'] ?? '',
      audioPath: map['audioPath'] ?? '',
      duration: Duration(milliseconds: map['duration'] ?? 0),
      isFavorite: map['isFavorite'] ?? false,
      emojiReactions: List<String>.from(map['emojiReactions'] ?? []),
      moodTags: List<String>.from(map['moodTags'] ?? []),
      tinyReview: map['tinyReview'],
      lyrics: map['lyrics'],
      genre: map['genre'] ?? 'Pop',
    );
  }
}
