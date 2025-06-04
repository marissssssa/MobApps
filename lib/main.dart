import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'l10n/app_localizations.dart';

// ✅ Import halaman siswa
import 'screens/siswa/siswa_homepage.dart';

final ThemeData highContrastTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.black,
  primaryColor: Colors.white,
  colorScheme: const ColorScheme.highContrastDark(),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 18, color: Colors.white),
    bodyMedium: TextStyle(fontSize: 16, color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
  ),
  cardColor: Colors.grey,
  iconTheme: const IconThemeData(color: Colors.white),
);

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduConnect',
      locale: localeProvider.locale ?? const Locale('id'),
      supportedLocales: const [Locale('en'), Locale('id')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: highContrastTheme,
      themeMode: themeProvider.isHighContrast
          ? ThemeMode.dark
          : ThemeMode.light,

      // ✅ Langsung ke SiswaHomepage
      home: SiswaHomepage(
        onSubjectSelected: (subject) {
          // Sementara cuma print ke console
          debugPrint("Subject selected: $subject");
        },
      ),
    );
  }
}
