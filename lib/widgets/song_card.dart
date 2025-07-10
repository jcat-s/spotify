import 'package:flutter/material.dart';
import '../models/song.dart';
import '../services/hive_service.dart';
import '../constants/app_constants.dart';
import 'lyrics_widget.dart';
import '../screens/full_player_screen.dart';

class SongCard extends StatelessWidget {
  final Song song;
  final VoidCallback? onTap;

  const SongCard({super.key, required this.song, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.padding,
        vertical: AppConstants.smallPadding,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.padding),
          child: Row(
            children: [
              // Album Art
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    AppConstants.smallBorderRadius,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppConstants.smallBorderRadius,
                  ),
                  child: song.albumArtPath.isNotEmpty
                      ? Image.asset(
                          song.albumArtPath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: primaryColor.withValues(alpha: 0.2),
                              child: Icon(
                                Icons.music_note,
                                color: primaryColor,
                                size: 30,
                              ),
                            );
                          },
                        )
                      : Container(
                          color: primaryColor.withValues(alpha: 0.2),
                          child: Icon(
                            Icons.music_note,
                            color: primaryColor,
                            size: 30,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: AppConstants.padding),

              // Song Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      song.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      song.artist,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: secondaryColor.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        song.genre,
                        style: TextStyle(
                          fontSize: 10,
                          color:
                              ThemeData.estimateBrightnessForColor(
                                    secondaryColor,
                                  ) ==
                                  Brightness.dark
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Emoji Reactions
                    if (song.emojiReactions.isNotEmpty) ...[
                      Wrap(
                        spacing: 4,
                        children: song.emojiReactions.map((emoji) {
                          return GestureDetector(
                            onTap: () => _removeEmojiReaction(context, emoji),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: secondaryColor.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                emoji,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: secondaryColor,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 4),
                    ],

                    // Mood Tags
                    if (song.moodTags.isNotEmpty) ...[
                      Wrap(
                        spacing: 4,
                        children: song.moodTags.take(3).map((tag) {
                          const color =
                              AppConstants.primaryColor; // Default color
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: color.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              tag,
                              style: const TextStyle(
                                fontSize: 10,
                                color: color,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 4),
                    ],

                    // Tiny Review
                    if (song.tinyReview != null &&
                        song.tinyReview!.isNotEmpty) ...[
                      Text(
                        '"${song.tinyReview!}"',
                        style: const TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: AppConstants.textLightColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        key: const Key('tinyReviewText'),
                      ),
                      const SizedBox(height: 4),
                    ],
                  ],
                ),
              ),

              // Duration
              Text(
                _formatDuration(song.duration),
                style: const TextStyle(
                  fontSize: 12,
                  color: AppConstants.textLightColor,
                ),
              ),

              const SizedBox(width: AppConstants.smallPadding),

              // Emoji Reaction Button
              IconButton(
                onPressed: () => _showEmojiReactions(context),
                icon: Icon(
                  Icons.emoji_emotions,
                  color: secondaryColor,
                  size: 20,
                ),
                tooltip: 'Add Reaction',
              ),

              // Lyrics Button (if lyrics available)
              if (song.lyrics != null && song.lyrics!.isNotEmpty) ...[
                IconButton(
                  onPressed: () => _showLyrics(context),
                  icon: Icon(Icons.lyrics, color: secondaryColor, size: 20),
                  tooltip: 'View Lyrics',
                ),
                const SizedBox(width: AppConstants.smallPadding),
              ],

              // Favorite Button
              IconButton(
                onPressed: () => _toggleFavorite(context),
                icon: Icon(
                  song.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: song.isFavorite
                      ? Colors.red
                      : secondaryColor.withValues(alpha: 0.5),
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _toggleFavorite(BuildContext context) async {
    await HiveService.toggleFavorite(song.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            song.isFavorite ? 'Added to favorites' : 'Removed from favorites',
          ),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _showEmojiReactions(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Reaction'),
        content: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: AppConstants.emojiReactions.map((emoji) {
            return GestureDetector(
              onTap: () {
                _addEmojiReaction(context, emoji);
                Navigator.of(context).pop();
              },
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(emoji, style: const TextStyle(fontSize: 24)),
              ),
            );
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _addEmojiReaction(BuildContext context, String emoji) async {
    await HiveService.addEmojiReaction(song.id, emoji);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added $emoji reaction'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _removeEmojiReaction(BuildContext context, String emoji) async {
    await HiveService.removeEmojiReaction(song.id, emoji);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Removed $emoji reaction'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  void _showLyrics(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        ),
        child: LyricsWidget(
          lyrics: song.lyrics!,
          songTitle: song.title,
          artist: song.artist,
          songId: song.id,
        ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
