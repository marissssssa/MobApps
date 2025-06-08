import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/providers/locale_provider.dart';
import 'package:educonnect/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({Key? key}) : super(key: key);

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool textToSpeech = false;
  bool largeText = false;
  bool autoSubtitle = false;
  bool highContrast = false;
  @override
  void initState() {
    super.initState();
    _loadHighContrast();
    _loadLargeText();
  }

  Future<void> _loadHighContrast() async {
    final prefs = await SharedPreferences.getInstance();
    final isHighContrast = prefs.getBool('highContrast') ?? false;
    setState(() {
      highContrast = isHighContrast;
    });
  }

  Future<void> _toggleHighContrast(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('highContrast', value);

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleHighContrast(value);

    setState(() {
      highContrast = value;
    });
  }

  Future<void> _loadLargeText() async {
    final prefs = await SharedPreferences.getInstance();
    final isLargeText = prefs.getBool('largeText') ?? false;
    setState(() {
      largeText = isLargeText;
    });
  }

  Future<void> _toggleLargeText(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('largeText', value);

    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.toggleLargeText(value);

    setState(() {
      largeText = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,

        title: Row(
          children: [
            Icon(Icons.accessibility_new, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 8),
            Text(local.accessibilityMode, style: TextStyle(color: Theme.of(context).iconTheme.color)),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: -30,
            left: -40,
            child: Opacity(
              opacity: 0.7,
              child: Icon(
                Icons.accessibility_new,
                size: 400,
                color: const Color(0x3384BDC2),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildToggleTile(
                  context: context,
                  icon: Icons.record_voice_over,
                  title: local.textToSpeech,
                  value: textToSpeech,
                  onChanged: (val) => setState(() => textToSpeech = val),

                ),

                _buildToggleTile(
                  context: context,
                  icon: Icons.format_size,
                  title: local.largeText,
                  value: largeText,
                  onChanged: _toggleLargeText,
                  //onChanged: (val) {
                  //  setState(() => largeText = val);
                  //  Provider.of<ThemeProvider>(context, listen: false).toggleLargeText(val);
                  //},
                ),

                _buildToggleTile(
                  context: context,
                  icon: Icons.closed_caption,
                  title: local.autoSubtitle,
                  value: autoSubtitle,
                  onChanged: (val) => setState(() => autoSubtitle = val),
                ),
                _buildToggleTile(
                  context: context,
                  icon: Icons.contrast,
                  title: local.highContrast,
                  value: highContrast,
                  onChanged: _toggleHighContrast,
                  //onChanged: (val) {
                  //  setState(() => highContrast = val);
                  //  Provider.of<ThemeProvider>(context, listen: false).toggleHighContrast(val);
                  //},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).iconTheme.color),
        title: Text(title),
        trailing: Transform.scale(
          scale: 0.75,
          child: Switch(
            value: value,
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}