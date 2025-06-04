import 'package:flutter/material.dart';
import 'screens/guru/guru_homepage.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
=======

>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'l10n/app_localizations.dart';

<<<<<<< HEAD
// LANGKAH 1: Definisikan kedua tema
// Anda bisa mengkustomisasi tema normal ini sesuai kebutuhan
final ThemeData normalTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.teal,
  // Tambahkan kustomisasi lain jika perlu
);
=======
// ✅ Import halaman siswa
import 'screens/siswa/siswa_homepage.dart';
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a

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
        // LANGKAH 2: Perbaiki cara membuat ThemeProvider. Tidak perlu argumen.
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
<<<<<<< HEAD
      title: 'MobApps',
      // LANGKAH 3: Gunakan provider untuk memilih tema secara dinamis
      theme: themeProvider.isHighContrast ? highContrastTheme : normalTheme,
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
=======
      debugShowCheckedModeBanner: false,
      title: 'EduConnect',
      locale: localeProvider.locale ?? const Locale('id'),
      supportedLocales: const [Locale('en'), Locale('id')],
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
<<<<<<< HEAD
      home: const GuruHomepage(),
=======
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
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
    );
  }
}
