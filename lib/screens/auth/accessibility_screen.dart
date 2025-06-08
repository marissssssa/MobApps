import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
// 'flutter_localizations' dihapus dari sini
import 'package:provider/provider.dart';
// 'locale_provider' dihapus dari sini
import 'package:educonnect/providers/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AccessibilityScreen extends StatefulWidget {
  const AccessibilityScreen({super.key});

  @override
  State<AccessibilityScreen> createState() => _AccessibilityScreenState();
}

class _AccessibilityScreenState extends State<AccessibilityScreen> {
  bool textToSpeech = false;
  bool largeText = false;
  bool autoSubtitle = false;
<<<<<<< HEAD
  // Nilai awal highContrast akan kita sinkronkan dengan provider
  // bool highContrast = false; // Baris ini akan kita modifikasi
=======
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
    //themeProvider.toggleHighContrast(value);

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
    //themeProvider.toggleLargeText(value);

    setState(() {
      largeText = value;
    });
  }
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    // Ambil nilai highContrast langsung dari provider
    final themeProvider = Provider.of<ThemeProvider>(context);
    final highContrast = themeProvider.isHighContrast;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        title: Row(
          children: [
            Icon(Icons.accessibility_new,
                color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 8),
            Text(local.accessibilityMode,
                style: TextStyle(color: Theme.of(context).iconTheme.color)),
          ],
        ),
      ),
      body: Stack(
        children: [
          const Positioned(
            top: -30,
            left: -40,
            child: Opacity(
              opacity: 0.7,
              child: Icon(
                Icons.accessibility_new,
                size: 400,
                color: Color(0x3384BDC2),
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
                  // Gunakan nilai dari provider
                  value: highContrast,
<<<<<<< HEAD
                  onChanged: (val) {
                    // Tidak perlu setState untuk highContrast karena sudah di-handle oleh provider
                    // setState(() => highContrast = val);
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleHighContrast(val);
                  },
=======
                  onChanged: _toggleHighContrast,
                  //onChanged: (val) {
                  //  setState(() => highContrast = val);
                  //  Provider.of<ThemeProvider>(context, listen: false).toggleHighContrast(val);
                  //},
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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