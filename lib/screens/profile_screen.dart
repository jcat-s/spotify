import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import '../constants/app_constants.dart';
import '../services/hive_service.dart';
import '../services/audio_service.dart';
import '../models/profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: HiveService.profileBox.listenable(),
      builder: (context, Box<Profile> box, _) {
        final profiles = box.values.toList();
        final profile = profiles.isNotEmpty ? profiles.first : null;

        if (profile == null) {
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                '👤 Profile',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 80,
                    color: AppConstants.primaryColor,
                  ),
                  SizedBox(height: 16),
                  Text(
                    '🎵 Music Diary 🎵',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppConstants.textColor,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Write about your music journey!',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppConstants.textLightColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              '👤 Profile',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppConstants.padding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profile Header
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => _editAvatar(context, profile),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.2),
                            child: Text(
                              profile.avatar,
                              style: const TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        const SizedBox(width: AppConstants.padding),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      profile.name,
                                      style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: AppConstants.textColor,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _editName(context, profile),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'Current Mood: ${profile.currentMood}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: AppConstants.textLightColor,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _editMood(context, profile),
                                    icon: Icon(
                                      Icons.edit,
                                      color: Theme.of(context).primaryColor,
                                      size: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.padding),

                // Personal Notes
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.note,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Personal Notes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () =>
                                  _editPersonalNotes(context, profile),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).secondaryHeaderColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Theme.of(
                                context,
                              ).secondaryHeaderColor.withValues(alpha: 0.3),
                            ),
                          ),
                          child:
                              profile.personalNotes != null &&
                                  profile.personalNotes!.isNotEmpty
                              ? _buildStyledPersonalNotes(
                                  profile.personalNotes!,
                                )
                              : const Text(
                                  'Write your personal notes here...',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: AppConstants.textColor,
                                    height: 1.5,
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.padding),

                // Profile Theme
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.palette,
                              color: Theme.of(context).secondaryHeaderColor,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Profile Theme',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () => _editTheme(context, profile),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: _getThemeColor(
                              profile.profileTheme,
                            ).withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: _getThemeColor(profile.profileTheme),
                            ),
                          ),
                          child: Text(
                            profile.profileTheme,
                            style: TextStyle(
                              color: _getThemeColor(profile.profileTheme),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.padding),

                // Music Diary
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.edit_note,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              'Music Diary',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () =>
                                  _editMusicDiary(context, profile),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          profile.musicDiary ??
                              'Write about your music journey here...',
                          style: const TextStyle(
                            fontSize: 16,
                            color: AppConstants.textColor,
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.padding),

                // Favorite Genres
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppConstants.padding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              '🎵 Favorite Genres',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppConstants.textColor,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () =>
                                  _editFavoriteGenres(context, profile),
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        if (profile.favoriteGenres.isNotEmpty) ...[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: profile.favoriteGenres.map((genre) {
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: Theme.of(
                                    context,
                                  ).secondaryHeaderColor.withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  genre,
                                  style: TextStyle(
                                    color: _getReadableTextColor(
                                      Theme.of(context).secondaryHeaderColor,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ] else ...[
                          const Text(
                            'No favorite genres yet. Tap edit to add some!',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppConstants.textLightColor,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppConstants.padding),

                // Current Listening
                Consumer<AudioService>(
                  builder: (context, audioService, child) {
                    final currentSong = audioService.currentSong;
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(AppConstants.padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.music_note,
                                  color: Theme.of(context).primaryColor,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'Currently Listening',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppConstants.textColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            if (currentSong != null &&
                                audioService.isPlaying) ...[
                              Row(
                                children: [
                                  // Show song reactions instead of profile mood
                                  if (currentSong
                                      .emojiReactions
                                      .isNotEmpty) ...[
                                    ...currentSong.emojiReactions.map(
                                      (reaction) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 4,
                                        ),
                                        child: Text(
                                          reaction,
                                          style: const TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ] else ...[
                                    const Text(
                                      '🎵',
                                      style: TextStyle(fontSize: 24),
                                    ),
                                  ],
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          currentSong.title,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          'by ${currentSong.artist}',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            color: AppConstants.textLightColor,
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.only(top: 4),
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .secondaryHeaderColor
                                                .withValues(alpha: 0.2),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            currentSong.genre,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: _getReadableTextColor(
                                                Theme.of(
                                                  context,
                                                ).secondaryHeaderColor,
                                              ),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      if (audioService.isPlaying) {
                                        audioService.pause();
                                      } else {
                                        audioService.play();
                                      }
                                    },
                                    icon: Icon(
                                      audioService.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                      color: Theme.of(context).primaryColor,
                                      size: 24,
                                    ),
                                  ),
                                ],
                              ),
                            ] else ...[
                              const Text(
                                'No song currently playing',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppConstants.textLightColor,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Color _getThemeColor(String theme) {
    switch (theme) {
      case 'soft pink':
        return const Color(0xFFFFB6C1);
      case 'cloudcore':
        return const Color(0xFFE8F4FD);
      case 'rainy':
        return const Color(0xFFB8E6B8);
      case 'dreamy blue':
        return const Color(0xFF87CEEB);
      default:
        return AppConstants.primaryColor;
    }
  }

  Color _getReadableTextColor(Color background) {
    // Use luminance to determine if text should be black or white
    return background.computeLuminance() > 0.5 ? Colors.black : Colors.white;
  }

  void _editName(BuildContext context, Profile profile) {
    final controller = TextEditingController(text: profile.name);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              final newName = controller.text.trim();
              if (newName.isNotEmpty) {
                profile.name = newName;
                await HiveService.saveProfile(profile);
                if (context.mounted) Navigator.of(context).pop();
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editMood(BuildContext context, Profile profile) {
    final moods = [
      '🎵',
      '🎸',
      '🎹',
      '🎤',
      '🎧',
      '🎼',
      '🎷',
      '🎺',
      '🥁',
      '🎻',
      '😊',
      '😢',
      '😡',
      '😴',
      '🤔',
      '😍',
      '🔥',
      '💃',
      '👑',
      '✨',
    ];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Mood'),
        content: SizedBox(
          width: double.maxFinite,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: moods.map((mood) {
              return GestureDetector(
                onTap: () async {
                  profile.currentMood = mood;
                  await HiveService.saveProfile(profile);
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: profile.currentMood == mood
                        ? AppConstants.primaryColor.withValues(alpha: 0.3)
                        : AppConstants.accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(mood, style: const TextStyle(fontSize: 24)),
                ),
              );
            }).toList(),
          ),
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

  void _editAvatar(BuildContext context, Profile profile) {
    final avatars = [
      '🌸',
      '🌺',
      '🌷',
      '🌹',
      '🌻',
      '🌼',
      '💐',
      '🌿',
      '🍀',
      '🌱',
      '🌲',
      '🌳',
      '🌴',
      '🌵',
      '🌾',
      '🌿',
      '☘️',
      '🍃',
      '🌱',
      '🌲',
    ];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Avatar'),
        content: SizedBox(
          width: double.maxFinite,
          child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: avatars.map((avatar) {
              return GestureDetector(
                onTap: () async {
                  profile.avatar = avatar;
                  await HiveService.saveProfile(profile);
                  if (context.mounted) Navigator.of(context).pop();
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: profile.avatar == avatar
                        ? AppConstants.primaryColor.withValues(alpha: 0.3)
                        : AppConstants.accentColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(avatar, style: const TextStyle(fontSize: 24)),
                ),
              );
            }).toList(),
          ),
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

  void _editPersonalNotes(BuildContext context, Profile profile) {
    final controller = TextEditingController(text: profile.personalNotes ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Personal Notes'),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Personal Notes',
              border: OutlineInputBorder(),
              hintText: 'Write your personal notes...',
            ),
            maxLines: 5,
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              profile.personalNotes = controller.text.trim();
              await HiveService.saveProfile(profile);
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editTheme(BuildContext context, Profile profile) {
    const themes = AppConstants.availableThemes;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Choose Theme'),
        content: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: themes.map((theme) {
              return ListTile(
                title: Text(theme),
                leading: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppConstants.getThemePrimaryColor(theme),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onTap: () async {
                  profile.profileTheme = theme;
                  await HiveService.saveProfile(profile);
                  if (context.mounted) Navigator.of(context).pop();
                },
              );
            }).toList(),
          ),
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

  void _editMusicDiary(BuildContext context, Profile profile) {
    final controller = TextEditingController(text: profile.musicDiary ?? '');
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Music Diary'),
        content: SizedBox(
          width: double.maxFinite,
          child: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Music Diary',
              border: OutlineInputBorder(),
              hintText: 'Write about your music journey...',
            ),
            maxLines: 5,
            autofocus: true,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              profile.musicDiary = controller.text.trim();
              await HiveService.saveProfile(profile);
              if (context.mounted) Navigator.of(context).pop();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _editFavoriteGenres(BuildContext context, Profile profile) {
    final availableGenres = [
      'Rock',
      'Pop',
      'Hip Hop',
      'R&B',
      'Jazz',
      'Classical',
      'Country',
      'Electronic',
      'Folk',
      'Blues',
      'Reggae',
      'Punk',
      'Metal',
      'Indie',
      'Alternative',
      'K-Pop',
      'J-Pop',
      'Latin',
      'World',
      'Soundtrack',
    ];

    final selectedGenres = List<String>.from(profile.favoriteGenres);

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Edit Favorite Genres'),
          content: SizedBox(
            width: double.maxFinite,
            height: 300,
            child: Column(
              children: [
                const Text('Select your favorite genres:'),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: availableGenres.length,
                    itemBuilder: (context, index) {
                      final genre = availableGenres[index];
                      final isSelected = selectedGenres.contains(genre);

                      return CheckboxListTile(
                        title: Text(genre),
                        value: isSelected,
                        onChanged: (value) {
                          setState(() {
                            if (value == true) {
                              if (!selectedGenres.contains(genre)) {
                                selectedGenres.add(genre);
                              }
                            } else {
                              selectedGenres.remove(genre);
                            }
                          });
                        },
                      );
                    },
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
                profile.favoriteGenres = selectedGenres;
                await HiveService.saveProfile(profile);
                if (context.mounted) Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildStyledPersonalNotes(String notes) {
  final List<InlineSpan> spans = [];
  final RegExp exp = RegExp(r'"([^"]+)"');
  int start = 0;
  for (final match in exp.allMatches(notes)) {
    if (match.start > start) {
      spans.add(
        TextSpan(
          text: notes.substring(start, match.start),
          style: const TextStyle(
            fontSize: 16,
            color: AppConstants.textColor,
            height: 1.5,
          ),
        ),
      );
    }
    spans.add(
      TextSpan(
        text: match.group(0),
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          fontFamilyFallback: ['Dancing Script', 'Pacifico', 'Cursive'],
          fontStyle: FontStyle.italic,
          color: AppConstants.textColor,
          height: 1.5,
        ),
      ),
    );
    start = match.end;
  }
  if (start < notes.length) {
    spans.add(
      TextSpan(
        text: notes.substring(start),
        style: const TextStyle(
          fontSize: 16,
          color: AppConstants.textColor,
          height: 1.5,
        ),
      ),
    );
  }
  return RichText(text: TextSpan(children: spans));
}
