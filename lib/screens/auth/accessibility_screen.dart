import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/providers/locale_provider.dart';

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
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            const Icon(Icons.settings_outlined, color: Colors.black),
            const SizedBox(width: 8),
            Text(local.accessibilityMode, style: const TextStyle(color: Colors.black)),
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
                Icons.accessibility,
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
                  icon: Icons.record_voice_over,
                  title: local.textToSpeech,
                  value: textToSpeech,
                  onChanged: (val) => setState(() => textToSpeech = val),

                ),
                _buildToggleTile(
                  icon: Icons.format_size,
                  title: local.largeText,
                  value: largeText,
                  onChanged: (val) => setState(() => largeText = val),
                ),
                _buildToggleTile(
                  icon: Icons.closed_caption,
                  title: local.autoSubtitle,
                  value: autoSubtitle,
                  onChanged: (val) => setState(() => autoSubtitle = val),
                ),
                _buildToggleTile(
                  icon: Icons.contrast,
                  title: local.highContrast,
                  value: highContrast,
                  onChanged: (val) => setState(() => highContrast = val),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleTile({
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
        leading: Icon(icon, color: Colors.black54),
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
