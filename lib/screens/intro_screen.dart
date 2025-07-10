import 'package:flutter/material.dart';
import '../constants/app_constants.dart';
import 'home_screen.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final backgroundColor = theme.scaffoldBackgroundColor;
    final primaryColor = theme.colorScheme.primary;
    const textColor = AppConstants.textColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor.withValues(alpha: 0.1), backgroundColor],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.padding * 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                // App Icon/Logo
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: primaryColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(Icons.music_note, size: 60, color: primaryColor),
                ),
                const SizedBox(height: AppConstants.padding * 2),
                // App Title
                const Text(
                  AppConstants.introTitle,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppConstants.textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.smallPadding),
                // App Subtitle
                const Text(
                  AppConstants.introSubtitle,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppConstants.textLightColor,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.padding * 2),
                // Description
                const Text(
                  AppConstants.introDescription,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstants.textColor,
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppConstants.padding * 3),
                // Features
                _buildFeature(
                  '🎵',
                  'Add your own reactions and mood tags',
                  textColor,
                ),
                _buildFeature(
                  '💗',
                  'Create your personal music diary',
                  textColor,
                ),
                _buildFeature(
                  '🎧',
                  'See what you\'re currently listening to',
                  textColor,
                ),
                const Spacer(),
                // Start Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: textColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius,
                        ),
                      ),
                      elevation: 4,
                    ),
                    child: const Text(
                      AppConstants.introButtonText,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: AppConstants.padding),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(String emoji, String text, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.smallPadding),
      child: Row(
        children: [
          Text(emoji, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: AppConstants.padding),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppConstants.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
