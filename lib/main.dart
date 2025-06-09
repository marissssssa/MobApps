import 'package:flutter/foundation.dart'; // ← untuk kIsWeb
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'l10n/app_localizations.dart';

import 'screens/orang_tua/orang_tua_homepage.dart';
import 'screens/guru/profile_guru.dart';
import 'package:educonnect/screens/main_dashboard_page.dart';
import 'package:educonnect/l10n/l10n.dart';

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
      locale: localeProvider.locale,
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
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
    );
  }
}
