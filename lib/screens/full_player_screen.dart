import 'package:flutter/material.dart';
import '../models/song.dart';
import '../widgets/audio_player_widget.dart';

class FullPlayerScreen extends StatelessWidget {
  final Song song;
  const FullPlayerScreen({Key? key, required this.song}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(title: Text(song.title), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: song.albumArtPath.isNotEmpty
                  ? Image.asset(
                      song.albumArtPath,
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.music_note,
                      size: 200,
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withValues(alpha: 0.2),
                    ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  song.artist,
                  style: const TextStyle(fontSize: 18, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const AudioPlayerWidget(),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
