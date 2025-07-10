import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/audio_service.dart';
import '../constants/app_constants.dart';

class AudioPlayerWidget extends StatefulWidget {
  const AudioPlayerWidget({super.key});

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  bool _isDragging = false;
  double _sliderValue = 0.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioService>(
      builder: (context, audioService, child) {
        final currentSong = audioService.currentSong;

        if (currentSong == null) {
          return const SizedBox.shrink();
        }

        // Update slider value when not dragging
        if (!_isDragging) {
          final duration = audioService.duration.inMilliseconds;
          if (duration > 0) {
            _sliderValue = audioService.position.inMilliseconds / duration;
          }
        }

        return Container(
          height: 100,
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.padding,
                vertical: AppConstants.smallPadding,
              ),
              child: Column(
                children: [
                  // Progress Bar
                  Row(
                    children: [
                      Text(
                        _formatDuration(audioService.position),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppConstants.textLightColor,
                        ),
                      ),
                      Expanded(
                        child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 2,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6,
                            ),
                            overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 12,
                            ),
                            activeTrackColor: Theme.of(
                              context,
                            ).colorScheme.primary,
                            inactiveTrackColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.3),
                            thumbColor: Theme.of(context).colorScheme.primary,
                            overlayColor: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.2),
                          ),
                          child: Slider(
                            value: _sliderValue.clamp(0.0, 1.0),
                            onChanged: (value) {
                              setState(() {
                                _sliderValue = value;
                                _isDragging = true;
                              });
                            },
                            onChangeEnd: (value) {
                              final duration =
                                  audioService.duration.inMilliseconds;
                              final newPosition = (value * duration).round();
                              if (duration > 0) {
                                audioService.seekTo(
                                  Duration(milliseconds: newPosition),
                                );
                              }
                              setState(() {
                                _isDragging = false;
                              });
                            },
                          ),
                        ),
                      ),
                      Text(
                        _formatDuration(audioService.duration),
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppConstants.textLightColor,
                        ),
                      ),
                    ],
                  ),

                  // Main Player Row
                  Expanded(
                    child: Row(
                      children: [
                        // Album Art
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              AppConstants.smallBorderRadius,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              AppConstants.smallBorderRadius,
                            ),
                            child: currentSong.albumArtPath.isNotEmpty
                                ? Image.asset(
                                    currentSong.albumArtPath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary
                                            .withValues(alpha: 0.2),
                                        child: Icon(
                                          Icons.music_note,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          size: 25,
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    color: Theme.of(context).colorScheme.primary
                                        .withValues(alpha: 0.2),
                                    child: Icon(
                                      Icons.music_note,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      size: 25,
                                    ),
                                  ),
                          ),
                        ),

                        const SizedBox(width: AppConstants.smallPadding),

                        // Song Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                currentSong.title,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: AppConstants.textColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                currentSong.artist,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppConstants.textLightColor,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),

                        // Controls
                        Row(
                          children: [
                            // Shuffle Button
                            IconButton(
                              onPressed: () => audioService.toggleShuffle(),
                              icon: Icon(
                                Icons.shuffle,
                                color: audioService.isShuffle
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.5),
                                size: 24,
                              ),
                              tooltip: 'Shuffle',
                            ),
                            IconButton(
                              onPressed: () => audioService.previous(),
                              icon: Icon(
                                Icons.skip_previous,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
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
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: Theme.of(context).colorScheme.primary,
                                size: 36,
                              ),
                              tooltip: audioService.isPlaying
                                  ? 'Pause'
                                  : 'Play',
                            ),
                            IconButton(
                              onPressed: () => audioService.next(),
                              icon: Icon(
                                Icons.skip_next,
                                color: Theme.of(context).colorScheme.primary,
                                size: 24,
                              ),
                            ),
                            // Repeat Button
                            IconButton(
                              onPressed: () => audioService.toggleRepeat(),
                              icon: Icon(
                                audioService.isRepeat
                                    ? Icons.repeat_on
                                    : Icons.repeat,
                                color: audioService.isRepeat
                                    ? Theme.of(context).colorScheme.secondary
                                    : Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.5),
                                size: 24,
                              ),
                              tooltip: 'Repeat',
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
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}
