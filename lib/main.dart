import 'package:educonnect/screens/auth/settings_screen.dart';
import 'package:flutter/material.dart';
import 'screens/auth/signup_page.dart'; // Panggil SignUpScreen di sini
// import 'screen/splash_screen.dart';
// import 'screen/login_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'providers/locale_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}
//MaterialApp(

//);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EduConnect',
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const SignUpScreen(), // Ganti ke SignUpScreen
    );
  }
}
