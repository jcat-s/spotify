import 'package:just_audio/just_audio.dart';
import 'package:flutter/foundation.dart';
import '../models/song.dart';
import 'hive_service.dart';

class AudioService extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();

  Song? _currentSong;
  List<Song> _playlist = [];
  int _currentIndex = 0;
  bool _isPlaying = false;
  bool _isShuffled = false;
  bool _isLooped = false;

  // Getters
  Song? get currentSong => _currentSong;
  List<Song> get playlist => _playlist;
  int get currentIndex => _currentIndex;
  bool get isPlaying => _isPlaying;
  bool get isShuffled => _isShuffled;
  bool get isLooped => _isLooped;
  bool get isShuffle => _isShuffled;
  bool get isRepeat => _isLooped;
  Duration get position => _audioPlayer.position;
  Duration get duration => _audioPlayer.duration ?? Duration.zero;
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<bool> get playingStream => _audioPlayer.playingStream;

  AudioService() {
    _initializeAudioPlayer();
  }

  void _initializeAudioPlayer() {
    // Listen to player state changes
    _audioPlayer.playerStateStream.listen((state) {
      _isPlaying = state.playing;
      notifyListeners();
    });

    // Listen to position changes
    _audioPlayer.positionStream.listen((_) {
      notifyListeners();
    });

    // Handle song completion
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        _onSongCompleted();
      }
    });
  }

  // Load playlist
  Future<void> loadPlaylist(List<Song> songs, {int startIndex = 0}) async {
    _playlist = songs;
    _currentIndex = startIndex.clamp(0, songs.length - 1);

    if (_playlist.isNotEmpty) {
      await _loadCurrentSong();
    }
  }

  // Load a single song
  Future<void> loadSong(Song song) async {
    _currentSong = song;
    _playlist = [song];
    _currentIndex = 0;
    await _loadCurrentSong();
  }

  Future<void> _loadCurrentSong() async {
    if (_playlist.isEmpty || _currentIndex >= _playlist.length) return;

    _currentSong = _playlist[_currentIndex];

    try {
      await _audioPlayer.setFilePath(_currentSong!.audioPath);
      notifyListeners();
    } catch (e) {
      debugPrint('Error loading song: $e');
    }
  }

  // Playback controls
  Future<void> play() async {
    if (_currentSong != null) {
      await _audioPlayer.play();
      _isPlaying = true;
      notifyListeners();
    }
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _audioPlayer.seek(Duration.zero); // Seek to start
    _isPlaying = false;
    notifyListeners();
  }

  Future<void> seekTo(Duration position) async {
    await _audioPlayer.seek(position);
  }

  // Navigation
  Future<void> next() async {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex + 1) % _playlist.length;
    await _loadCurrentSong();

    if (_isPlaying) {
      await play();
    }
  }

  Future<void> previous() async {
    if (_playlist.isEmpty) return;

    _currentIndex = (_currentIndex - 1) % _playlist.length;
    await _loadCurrentSong();

    if (_isPlaying) {
      await play();
    }
  }

  Future<void> jumpToIndex(int index) async {
    if (index >= 0 && index < _playlist.length) {
      _currentIndex = index;
      await _loadCurrentSong();

      if (_isPlaying) {
        await play();
      }
    }
  }

  // Playlist controls
  void toggleShuffle() {
    _isShuffled = !_isShuffled;
    if (_isShuffled) {
      _playlist.shuffle();
    } else {
      // Restore original order (you might want to keep track of original order)
      _playlist.sort((a, b) => a.title.compareTo(b.title));
    }
    notifyListeners();
  }

  void toggleRepeat() {
    _isLooped = !_isLooped;
    if (_isLooped) {
      _audioPlayer.setLoopMode(LoopMode.one);
    } else {
      _audioPlayer.setLoopMode(LoopMode.off);
    }
    notifyListeners();
  }

  // Handle song completion
  void _onSongCompleted() {
    if (_isLooped) {
      // Song will loop automatically due to LoopMode.one
      return;
    }

    if (_currentIndex < _playlist.length - 1) {
      next();
    } else {
      // End of playlist
      _isPlaying = false;
      notifyListeners();
    }
  }

  // Load songs from storage
  Future<void> loadSongsFromStorage() async {
    final songs = HiveService.getAllSongs();
    if (songs.isNotEmpty) {
      await loadPlaylist(songs);
    }
  }

  // Load favorite songs
  Future<void> loadFavoriteSongs() async {
    final favoriteSongs = HiveService.getFavoriteSongs();
    if (favoriteSongs.isNotEmpty) {
      await loadPlaylist(favoriteSongs);
    }
  }

  // Format duration for display
  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  // Dispose
  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
