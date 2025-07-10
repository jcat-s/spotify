import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import '../services/hive_service.dart';

class LyricsWidget extends StatelessWidget {
  final String lyrics;
  final String songTitle;
  final String artist;
  final String songId;

  const LyricsWidget({
    super.key,
    required this.lyrics,
    required this.songTitle,
    required this.artist,
    required this.songId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(AppConstants.padding),
            decoration: BoxDecoration(
              color: AppConstants.primaryColor.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppConstants.borderRadius),
                topRight: Radius.circular(AppConstants.borderRadius),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.lyrics,
                  color: AppConstants.primaryColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🎵 Lyrics',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppConstants.textColor,
                        ),
                      ),
                      Text(
                        '$songTitle by $artist',
                        style: const TextStyle(
                          fontSize: 14,
                          color: AppConstants.textLightColor,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => _showLyricsSelection(context),
                  icon: const Icon(
                    Icons.add,
                    color: AppConstants.primaryColor,
                    size: 20,
                  ),
                  tooltip: 'Add to Personal Notes',
                ),
              ],
            ),
          ),

          // Lyrics Content
          Container(
            constraints: const BoxConstraints(maxHeight: 300, minHeight: 100),
            padding: const EdgeInsets.all(AppConstants.padding),
            child: SingleChildScrollView(
              child: SelectableText(
                lyrics,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: AppConstants.textColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showLyricsSelection(BuildContext context) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Lyrics to Personal Notes'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select lyrics from "$songTitle" by $artist',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppConstants.textLightColor,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: controller,
                decoration: const InputDecoration(
                  labelText: 'Selected Lyrics',
                  border: OutlineInputBorder(),
                  hintText: 'Paste or type the lyrics you want to save...',
                ),
                maxLines: 3,
                autofocus: true,
              ),
              const SizedBox(height: 16),
              const Text(
                '💡 Tip: You can select text from the lyrics above and paste it here',
                style: TextStyle(
                  fontSize: 12,
                  color: AppConstants.textLightColor,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final selectedLyrics = controller.text.trim();
              if (selectedLyrics.isNotEmpty) {
                // Format: "lyrics" Song Title by Artist
                final note = '"$selectedLyrics" $songTitle by $artist';

                // Get current profile and update personal notes
                final profile = HiveService.getOrCreateDefaultProfile();
                final currentNotes = profile.personalNotes ?? '';
                final updatedNotes = currentNotes.isEmpty
                    ? note
                    : '$currentNotes\n\n$note';

                profile.personalNotes = updatedNotes;
                await HiveService.saveProfile(profile);

                if (context.mounted) {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Added "$selectedLyrics" to personal notes!',
                      ),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                }
              }
            },
            child: const Text('Add to Notes'),
          ),
        ],
      ),
    );
  }
}
