import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../services/hive_service.dart';
import '../constants/app_constants.dart';
import '../widgets/song_card.dart';
import '../widgets/audio_player_widget.dart';
import '../models/song.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'package:provider/provider.dart';
import '../services/audio_service.dart';
import 'full_player_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const SongsListScreen(),
    const FavoritesScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _screens[_currentIndex]),
          const AudioPlayerWidget(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Theme.of(context).cardColor,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: AppConstants.textLightColor,
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class SongsListScreen extends StatelessWidget {
  const SongsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          AppConstants.appSubtitle,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: HiveService.songsBox.listenable(),
        builder: (context, Box<Song> box, _) {
          final songs = box.values.toList();

          if (songs.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.music_note,
                    size: 80,
                    color: Color(0xFFB39DDB), // fallback color
                  ),
                  SizedBox(height: 16),
                  Text(
                    '🎵 Welcome to CuteTunes! 🎵',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333), // fallback color
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Add some music to get started!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF888888), // fallback color
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.smallPadding,
            ),
            itemCount: songs.length,
            itemBuilder: (context, index) {
              final song = songs[index];
              return SongCard(
                song: song,
                onTap: () async {
                  final audioService = Provider.of<AudioService>(
                    context,
                    listen: false,
                  );
                  await audioService.loadSong(song);
                  await audioService.play();
                  if (!context.mounted) return;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullPlayerScreen(song: song),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
