import 'package:educonnect/screens/auth/settings_screen.dart';
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

final ThemeData highContrastTheme = ThemeData(
  // … (tema kamu yang sudah ada)
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
      builder: (context, child) {
        final scale = themeProvider.isLargeText ? 1.4 : 1.0;
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
          child: child!,
        );
      },
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      darkTheme: highContrastTheme,
      themeMode: themeProvider.isHighContrast
          ? ThemeMode.dark
          : ThemeMode.light,
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
          : const MainDashboardPage(role: UserRole.siswa),
          //: const ProfileGuruScreen(),
    );
  }
}
