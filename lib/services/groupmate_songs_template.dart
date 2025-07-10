// 🎵 TEMPLATE FOR ADDING GROUPMATE'S SONGS LATER
// Copy this template and add your groupmate's songs here

import '../models/song.dart';
import 'hive_service.dart';

class GroupmateSongsTemplate {
  static List<Song> getGroupmateSongs() {
    return [
      // 🎵 SONG 1 - [GROUPMATE NAME]
      Song(
        id: HiveService.generateId(),
        title: 'SONG_TITLE',
        artist: 'ARTIST_NAME',
        album: 'ALBUM_NAME',
        albumArtPath: 'assets/images/song1.jpg', // ← ADD ALBUM ART
        audioPath: 'assets/music/song1.mp3', // ← ADD MP3 FILE
        duration: const Duration(minutes: 3, seconds: 30),
        isFavorite: false,
        emojiReactions: ['❤️', '🔥'], // ← CUSTOMIZE EMOJIS
        moodTags: ['happy', 'energetic'], // ← CUSTOMIZE MOOD TAGS
        tinyReview: 'Your review here!', // ← ADD YOUR REVIEW
        lyrics: '''[Verse 1]
Add lyrics here
Line by line
With proper formatting

[Chorus]
Chorus lyrics here
More lines
''', // ← ADD LYRICS (optional)
      ),

      // 🎵 SONG 2 - [GROUPMATE NAME]
      Song(
        id: HiveService.generateId(),
        title: 'SONG_TITLE_2',
        artist: 'ARTIST_NAME_2',
        album: 'ALBUM_NAME_2',
        albumArtPath: 'assets/images/song2.jpg',
        audioPath: 'assets/music/song2.mp3',
        duration: const Duration(minutes: 4, seconds: 15),
        isFavorite: false,
        emojiReactions: ['😍', '🎵'],
        moodTags: ['chill', 'romantic'],
        tinyReview: 'Another great song!',
        lyrics: null, // ← No lyrics for this song
      ),

      // 🎵 SONG 3 - [GROUPMATE NAME]
      Song(
        id: HiveService.generateId(),
        title: 'SONG_TITLE_3',
        artist: 'ARTIST_NAME_3',
        album: 'ALBUM_NAME_3',
        albumArtPath: 'assets/images/song3.jpg',
        audioPath: 'assets/music/song3.mp3',
        duration: const Duration(minutes: 3, seconds: 45),
        isFavorite: false,
        emojiReactions: ['💃', '🔥', '👑'],
        moodTags: ['party', 'dance'],
        tinyReview: 'Perfect for dancing!',
        lyrics: '''[Verse]
Add lyrics here
''',
      ),
    ];
  }

  // 📋 HOW TO ADD GROUPMATE'S SONGS:
  // 1. Copy this template
  // 2. Replace the placeholder values with real song info
  // 3. Add MP3 files to assets/music/
  // 4. Add album art to assets/images/
  // 5. Import and call this in main.dart
}
