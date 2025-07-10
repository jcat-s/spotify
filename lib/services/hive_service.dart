import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';
import '../models/song.dart';
import '../models/profile.dart';
import '../models/duration_adapter.dart';

class HiveService {
  static const String songsBoxName = 'songs';
  static const String profileBoxName = 'profile';
  static const String settingsBoxName = 'settings';

  static const Uuid _uuid = Uuid();

  // Initialize Hive
  static Future<void> initialize() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(SongAdapter());
    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(DurationAdapter());

    // Open boxes
    await Hive.openBox<Song>(songsBoxName);
    await Hive.openBox<Profile>(profileBoxName);
    await Hive.openBox(settingsBoxName);
  }

  // Song operations
  static Box<Song> get songsBox => Hive.box<Song>(songsBoxName);

  static Future<void> addSong(Song song) async {
    await songsBox.put(song.id, song);
  }

  static Future<void> updateSong(Song song) async {
    await songsBox.put(song.id, song);
  }

  static Future<void> deleteSong(String songId) async {
    await songsBox.delete(songId);
  }

  static Song? getSong(String songId) {
    return songsBox.get(songId);
  }

  static List<Song> getAllSongs() {
    return songsBox.values.toList();
  }

  static List<Song> getFavoriteSongs() {
    return songsBox.values.where((song) => song.isFavorite).toList();
  }

  static Future<void> toggleFavorite(String songId) async {
    final song = songsBox.get(songId);
    if (song != null) {
      song.isFavorite = !song.isFavorite;
      await songsBox.put(songId, song);

      // Auto-add genre to profile favorites when song is favorited
      if (song.isFavorite) {
        final profile = getOrCreateDefaultProfile();
        if (!profile.favoriteGenres.contains(song.genre)) {
          profile.favoriteGenres.add(song.genre);
          await saveProfile(profile);
        }
      }
    }
  }

  static Future<void> addEmojiReaction(String songId, String emoji) async {
    final song = songsBox.get(songId);
    if (song != null) {
      // Only allow one reaction per song
      song.emojiReactions
        ..clear()
        ..add(emoji);
      await songsBox.put(songId, song);
    }
  }

  static Future<void> removeEmojiReaction(String songId, String emoji) async {
    final song = songsBox.get(songId);
    if (song != null) {
      song.emojiReactions.remove(emoji);
      await songsBox.put(songId, song);
    }
  }

  static Future<void> addMoodTag(String songId, String moodTag) async {
    final song = songsBox.get(songId);
    if (song != null) {
      if (!song.moodTags.contains(moodTag)) {
        song.moodTags.add(moodTag);
        await songsBox.put(songId, song);
      }
    }
  }

  static Future<void> removeMoodTag(String songId, String moodTag) async {
    final song = songsBox.get(songId);
    if (song != null) {
      song.moodTags.remove(moodTag);
      await songsBox.put(songId, song);
    }
  }

  static Future<void> updateTinyReview(String songId, String? review) async {
    final song = songsBox.get(songId);
    if (song != null) {
      song.tinyReview = review;
      await songsBox.put(songId, song);
    }
  }

  static Future<void> updateLyrics(String songId, String? lyrics) async {
    final song = songsBox.get(songId);
    if (song != null) {
      song.lyrics = lyrics;
      await songsBox.put(songId, song);
    }
  }

  // Profile operations
  static Box<Profile> get profileBox => Hive.box<Profile>(profileBoxName);

  static Future<void> saveProfile(Profile profile) async {
    await profileBox.put(profile.id, profile);
  }

  static Profile? getProfile(String profileId) {
    return profileBox.get(profileId);
  }

  static Profile getOrCreateDefaultProfile() {
    const defaultId = 'default_profile';
    final profile = profileBox.get(defaultId);
    if (profile != null) {
      return profile;
    }

    final newProfile = Profile(id: defaultId);
    profileBox.put(defaultId, newProfile);
    return newProfile;
  }

  static Future<void> updateMusicDiary(String profileId, String diary) async {
    final profile = profileBox.get(profileId);
    if (profile != null) {
      profile.musicDiary = diary;
      profile.lastUpdated = DateTime.now();
      await profileBox.put(profileId, profile);
    }
  }

  static Future<void> updateCurrentMood(String profileId, String mood) async {
    final profile = profileBox.get(profileId);
    if (profile != null) {
      profile.currentMood = mood;
      profile.lastUpdated = DateTime.now();
      await profileBox.put(profileId, profile);
    }
  }

  static Future<void> updateProfileTheme(String profileId, String theme) async {
    final profile = profileBox.get(profileId);
    if (profile != null) {
      profile.profileTheme = theme;
      profile.lastUpdated = DateTime.now();
      await profileBox.put(profileId, profile);
    }
  }

  static Future<void> updateAvatar(String profileId, String avatar) async {
    final profile = profileBox.get(profileId);
    if (profile != null) {
      profile.avatar = avatar;
      profile.lastUpdated = DateTime.now();
      await profileBox.put(profileId, profile);
    }
  }

  static Future<void> addListeningEntry(
    String profileId,
    String date,
    String mood,
    String topSong,
  ) async {
    final profile = profileBox.get(profileId);
    if (profile != null) {
      profile.listeningCalendar[date] = {
        'mood': mood,
        'topSong': topSong,
        'timestamp': DateTime.now().toIso8601String(),
      };
      profile.lastUpdated = DateTime.now();
      await profileBox.put(profileId, profile);
    }
  }

  // Settings operations
  static Box get settingsBox => Hive.box(settingsBoxName);

  static Future<void> saveSetting(String key, dynamic value) async {
    await settingsBox.put(key, value);
  }

  static T? getSetting<T>(String key, {T? defaultValue}) {
    return settingsBox.get(key, defaultValue: defaultValue) as T?;
  }

  static Future<void> removeSetting(String key) async {
    await settingsBox.delete(key);
  }

  // Utility methods
  static String generateId() {
    return _uuid.v4();
  }

  static Future<void> clearAllData() async {
    await songsBox.clear();
    await profileBox.clear();
    await settingsBox.clear();
  }

  static Future<void> closeBoxes() async {
    await songsBox.close();
    await profileBox.close();
    await settingsBox.close();
  }
}
