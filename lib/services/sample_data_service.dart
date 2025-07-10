import '../models/song.dart';
import '../models/profile.dart';
import 'hive_service.dart';

class SampleDataService {
  static List<Song> getSampleSongs() {
    return [
      Song(
        id: HiveService.generateId(),
        title: 'SOLO',
        artist: 'Jennie Kim',
        album: 'SOLO',
        albumArtPath: 'assets/images/jennie_solo.png',
        audioPath: 'assets/music/jennie_solo.mp3',
        duration: const Duration(minutes: 2, seconds: 56),
        isFavorite: false,
        emojiReactions: [],
        moodTags: [],
        tinyReview: null,

        genre: 'K-Pop',
        lyrics: '''[Verse 1]
빛나는 별처럼
Shining like a star
나의 마음을 뺏어가
You stole my heart away
네가 없인 난
Without you, I'm
아무것도 아냐
Nothing at all

[Pre-Chorus]
이제는 나도 알아
Now I know too
내가 왜 이렇게
Why I'm like this
괜찮은 척을 하는지
Pretending I'm okay

[Chorus]
I'm going solo
I'm going solo
I'm going solo
I'm going solo

[Verse 2]
이제는 나도 알아
Now I know too
내가 왜 이렇게
Why I'm like this
괜찮은 척을 하는지
Pretending I'm okay

[Bridge]
I'm going solo
I'm going solo
I'm going solo
I'm going solo

[Outro]
I'm going solo
I'm going solo
I'm going solo
I'm going solo''',
      ),
    ];
  }

  static Profile getSampleProfile() {
    return Profile(
      id: 'default_profile',
      name: 'Music Lover',
      musicDiary: null,
      currentMood: '🎵',
      favoriteGenres: [],
      totalSongsPlayed: 0,
      totalListeningTime: Duration.zero,
    );
  }

  static Future<void> addSampleData() async {
    // Check if data already exists
    final existingSongs = HiveService.getAllSongs();
    if (existingSongs.isNotEmpty) {
      return; // Data already exists, don't add again
    }

    // Add sample songs
    final songs = getSampleSongs();
    for (final song in songs) {
      await HiveService.addSong(song);
    }

    // Add sample profile
    final profile = getSampleProfile();
    await HiveService.saveProfile(profile);
  }

  static Future<void> clearSampleData() async {
    await HiveService.clearAllData();
  }
}
