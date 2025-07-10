import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'services/hive_service.dart';
import 'services/audio_service.dart';
import 'services/sample_data_service.dart';
import 'screens/intro_screen.dart';
import 'constants/app_constants.dart';
import 'models/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveService.initialize();

  await SampleDataService.addSampleData();

  runApp(const CuteTunesApp());
}

class CuteTunesApp extends StatelessWidget {
  const CuteTunesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AudioService())],
      child: ValueListenableBuilder(
        valueListenable: HiveService.profileBox.listenable(),
        builder: (context, Box<Profile> box, _) {
          final profiles = box.values.toList();
          final profile = profiles.isNotEmpty ? profiles.first : null;
          final theme = profile?.profileTheme ?? 'soft pink 🌸';

          // Get theme colors from AppConstants
          final primaryColor = AppConstants.getThemePrimaryColor(theme);
          final secondaryColor = AppConstants.getThemeSecondaryColor(theme);
          final backgroundColor = AppConstants.getThemeBackgroundColor(theme);
          const surfaceColor = Colors.white; // fallback for now

          return MaterialApp(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: primaryColor,
                brightness: Brightness.light,
                primary: primaryColor,
                secondary: secondaryColor,
                surface: surfaceColor,
              ),
              useMaterial3: true,
              fontFamily: 'Poppins',
              scaffoldBackgroundColor: backgroundColor,
              appBarTheme: AppBarTheme(
                backgroundColor: primaryColor,
                foregroundColor: AppConstants.textColor,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: AppConstants.textColor,
                ),
              ),
              cardTheme: CardThemeData(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius,
                  ),
                ),
                color: surfaceColor,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: AppConstants.textColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.smallBorderRadius,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.padding,
                    vertical: AppConstants.smallPadding,
                  ),
                ),
              ),
            ),
            home: const IntroScreen(),
          );
        },
      ),
    );
  }
}
