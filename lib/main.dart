<<<<<<< HEAD
// lib/main.dart
=======
import 'package:educonnect/screens/auth/settings_screen.dart';
import 'package:flutter/foundation.dart'; 
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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

<<<<<<< HEAD
// Tema Terang (Normal)
final ThemeData normalTheme = ThemeData.light().copyWith(
  primaryColor: Colors.teal, 
  scaffoldBackgroundColor: Colors.grey[100],
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.teal[400],
    foregroundColor: Colors.white,
  ),
);
=======
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'l10n/app_localizations.dart';

import 'screens/orang_tua/orang_tua_homepage.dart';
import 'screens/guru/profile_guru.dart';
import 'package:educonnect/screens/main_dashboard_page.dart';
import 'package:educonnect/l10n/l10n.dart';
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48

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
<<<<<<< HEAD
      title: 'EduConnect', 

      locale: localeProvider.locale ?? const Locale('id'), // Default ke 'id' jika null
      supportedLocales: const [
        Locale('en', ''), 
        Locale('id', ''), 
      ],
=======
      title: 'EduConnect',
      locale: localeProvider.locale,
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      supportedLocales: supportedLocales,
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
<<<<<<< HEAD
      
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
=======
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
      ),

      // kalau di Web, bungkus UI di dalam Container 375×812
      home: kIsWeb
          ? Center(
        child: Container(
          width: 375,
          height: 812,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(20),
          ),
          clipBehavior: Clip.hardEdge,
          child: const ProfileGuruScreen(),
        ),
      )
      // kalau di Android/iOS sesungguhnya, langsung fullscreen


      :const MainDashboardPage(role: UserRole.siswa),
      //: const ProfileGuruScreen(),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
    );
  }
}