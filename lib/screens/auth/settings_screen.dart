import 'package:educonnect/screens/auth/accessibility_screen.dart';
import 'package:educonnect/screens/auth/notification_screen.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/providers/locale_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

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
            Icon(Icons.settings_outlined,
                color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 8),
            Text(local.settings,
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
                Icons.settings_outlined,
                size: 400,
                color: Color(0x3384BDC2),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildSettingsTile(
                  context: context,
                  icon: Icons.person_outline,
                  title: local.myProfile,
                  onTap: () {},
                ),
                _buildLanguageDropdown(context, local),
                _buildSettingsTile(
                  context: context,
                  icon: Icons.accessibility_new_outlined,
                  title: local.accessibilityMode,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccessibilityScreen()),
                    );
                  },
                ),
                _buildSettingsTile(
                  context: context,
                  icon: Icons.notifications_none,
                  title: local.notifications,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const NotificationScreen()),
                    );
                  },
                ),
                _buildSettingsTile(
                  context: context,
                  icon: Icons.logout,
                  title: local.logout,
                  onTap: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).iconTheme.color),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLanguageDropdown(BuildContext context, AppLocalizations local) {
    final provider = Provider.of<LocaleProvider>(context);
<<<<<<< HEAD
    String currentLang =
        provider.locale.languageCode == 'en' ? 'English' : 'Indonesia';
=======
    //String currentLang = provider.locale.languageCode == 'en' ? 'English' : 'Indonesia';
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(Icons.language, color: Theme.of(context).iconTheme.color),
        title: Text(local.language),
        trailing: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            //value: currentLang,
            items: const [
              DropdownMenuItem(value: 'Indonesia', child: Text('Indonesia')),
              DropdownMenuItem(value: 'English', child: Text('English')),
            ],
            onChanged: (value) {
              if (value == 'Indonesia') {
                provider.setLocale(const Locale('id'));
              } else {
                provider.setLocale(const Locale('en'));
              }
            },
          ),
        ),
      ),
    );
  }
}
