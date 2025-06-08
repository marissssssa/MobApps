//lib/l10n/l10n.dart
import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';

const List<Locale> supportedLocales = [
  Locale('en'),
  Locale('id'),
];

extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
