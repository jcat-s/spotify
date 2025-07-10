import 'package:flutter/material.dart';

class AppConstants {
  // App Colors - Cute Pastel Theme
  static const Color primaryColor = Color(0xFFFFB6C1); // Light pink
  static const Color secondaryColor = Color(0xFF87CEEB); // Sky blue
  static const Color accentColor = Color(0xFFFFD700); // Gold
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF2C3E50);
  static const Color textLightColor = Color(0xFF7F8C8D);

  // Theme Colors
  static Color getThemePrimaryColor(String theme) {
    switch (theme) {
      case 'soft pink 🌸':
        return const Color.fromARGB(255, 255, 182, 193); // soft pink
      case 'matcha latte 🍵':
        return const Color.fromARGB(255, 199, 223, 185); // pastel green
      case 'sun-drenched yellow 🌼':
        return const Color.fromARGB(255, 255, 245, 180); // warm pastel yellow
      case 'lilac lullaby 💜':
        return const Color.fromARGB(255, 215, 191, 255); // light purple
      case 'puddle grey 🌫️':
        return const Color.fromARGB(255, 189, 194, 204); // cloudy grey
      case 'mocha cream 🍫':
        return const Color.fromARGB(255, 222, 190, 155); // soft brown
      case 'dreamy coral 🍊':
        return const Color.fromARGB(255, 255, 198, 174); // pastel orange
      case 'midnight haze 🌙':
        return const Color.fromARGB(255, 160, 175, 230); // soft indigo
      default:
        return const Color.fromARGB(255, 255, 182, 193); // default: soft pink
    }
  }

  static Color getThemeSecondaryColor(String theme) {
    switch (theme) {
      case 'soft pink 🌸':
        return const Color.fromARGB(255, 255, 160, 180); // deeper pink
      case 'matcha latte 🍵':
        return const Color.fromARGB(255, 170, 200, 150); // soft green accent
      case 'sun-drenched yellow 🌼':
        return const Color.fromARGB(255, 255, 230, 120); // pastel yellow accent
      case 'lilac lullaby 💜':
        return const Color.fromARGB(255, 190, 150, 255); // purple accent
      case 'puddle grey 🌫️':
        return const Color.fromARGB(255, 150, 155, 170); // soft grey accent
      case 'mocha cream 🍫':
        return const Color.fromARGB(255, 180, 150, 110); // mocha accent
      case 'dreamy coral 🍊':
        return const Color.fromARGB(255, 255, 170, 120); // coral accent
      case 'midnight haze 🌙':
        return const Color.fromARGB(255, 120, 130, 200); // indigo accent
      default:
        return const Color.fromARGB(255, 255, 160, 180); // default: deeper pink
    }
  }

  static Color getThemeBackgroundColor(String theme) {
    switch (theme) {
      case 'soft pink 🌸':
        return const Color.fromARGB(255, 255, 245, 250); // very light pink
      case 'matcha latte 🍵':
        return const Color.fromARGB(255, 240, 250, 240); // matcha foam
      case 'sun-drenched yellow 🌼':
        return const Color.fromARGB(255, 255, 252, 230); // light yellow
      case 'lilac lullaby 💜':
        return const Color.fromARGB(255, 250, 245, 255); // lilac mist
      case 'puddle grey 🌫️':
        return const Color.fromARGB(255, 245, 246, 250); // foggy white
      case 'mocha cream 🍫':
        return const Color.fromARGB(255, 250, 245, 235); // creamy beige
      case 'dreamy coral 🍊':
        return const Color.fromARGB(255, 255, 250, 245); // coral mist
      case 'midnight haze 🌙':
        return const Color.fromARGB(255, 245, 247, 255); // night mist
      default:
        return const Color.fromARGB(
          255,
          255,
          245,
          250,
        ); // default: very light pink
    }
  }

  // Emoji Reactions
  static const List<String> emojiReactions = [
    '❤️',
    '😂',
    '😭',
    '🔥',
    '😍',
    '🤔',
    '😴',
    '🎵',
    '💃',
    '🤘',
  ];

  // App Text
  static const String appName = '💗 Softify 💗';
  static const String appDescription =
      'A soft corner of music, mood, and meaning.';
  static const String appSubtitle = 'Music';

  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 400);
  static const Duration longAnimation = Duration(milliseconds: 600);

  // Border Radius
  static const double borderRadius = 16.0;
  static const double smallBorderRadius = 8.0;

  // Padding
  static const double padding = 16.0;
  static const double smallPadding = 8.0;

  // Intro Text
  static const String introTitle = '💗 Softify 💗';
  static const String introSubtitle =
      'A soft corner of music, mood, and meaning.';
  static const String introDescription =
      'Welcome to your personal music sanctuary. Here you can discover, organize, and cherish your favorite songs with your own reactions, mood tags, and music diary.';
  static const String introButtonText = 'Start Your Journey';

  static const List<String> availableThemes = [
    'soft pink 🌸',
    'matcha latte 🍵',
    'sun-drenched yellow 🌼',
    'lilac lullaby 💜',
    'puddle grey 🌫️',
    'mocha cream 🍫',
    'dreamy coral 🍊',
    'midnight haze 🌙',
  ];
}
