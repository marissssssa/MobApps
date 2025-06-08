// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/screens/guru/guru_homepage.dart';
import 'package:educonnect/screens/guru/my_classes_page.dart';
import 'package:educonnect/screens/shared/discussion_page.dart';
import 'package:educonnect/screens/siswa/siswa_homepage.dart'; 
import 'package:educonnect/providers/locale_provider.dart';
import 'package:educonnect/providerss/theme_provider.dart';
import 'package:educonnect/l10n/app_localizations.dart';

// Tema Terang (Normal)
final ThemeData normalTheme = ThemeData.light().copyWith(
  primaryColor: Colors.teal, 
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.teal[400],
    foregroundColor: Colors.white,
  ),
);

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
  cardColor: Colors.grey[800], 
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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduConnect', 

      locale: localeProvider.locale ?? const Locale('id'), // Default ke 'id' jika null
      supportedLocales: const [
        Locale('en', ''), 
        Locale('id', ''), 
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Pengaturan Tema menggunakan ThemeProvider
      theme: normalTheme, // Tema terang default
      darkTheme: highContrastTheme, // Tema gelap untuk kontras tinggi
      themeMode: themeProvider.isHighContrast
          ? ThemeMode.dark
          : ThemeMode.light,

      // Pengaturan Rute (Navigasi)
      initialRoute: GuruHomepage.routeName, // Halaman awal adalah GuruHomepage
      routes: {
        GuruHomepage.routeName: (context) => const GuruHomepage(),
        MyClassesPage.routeName: (context) => const MyClassesPage(),
        DiscussionPage.routeName: (context) => const DiscussionPage(),
        SiswaHomepage.routeName: (context) => SiswaHomepage(
          onSubjectSelected: (subject) { 
            debugPrint("Dari main.dart - Subject selected: $subject");
          },
        ),
      },
    );
  }
}