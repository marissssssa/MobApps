import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/providers/locale_provider.dart';
import 'package:educonnect/providers/theme_provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.profile),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
        titleTextStyle: TextStyle(
          color: Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24.0),
        children: [
          Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/150?img=12",
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Frank Sinatra",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "franksinatra72@gmail.com",
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF52C1B9),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 15,
                  ),
                ),
                child: Text(
                  l10n.editProfile,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),
          const Divider(),

          // Menu Items
          _buildProfileMenuItem(
            context: context,
            icon: Icons.person_outline,
            title: l10n.role,
            subtitle: l10n.parent,
          ),
          _buildProfileMenuItem(
            context: context,
            icon: Icons.school_outlined,
            title: l10n.institution,
            subtitle: l10n.publicHighSchool,
          ),

          _buildLanguageMenuItem(context, localeProvider, l10n),

          _buildProfileMenuItem(
            context: context,
            icon: Icons.notifications_outlined,
            title: l10n.notificationSettings,
          ),

          _buildThemeMenuItem(context, themeProvider, l10n),

          _buildProfileMenuItem(
            context: context,
            icon: Icons.download_for_offline_outlined,
            title: l10n.downloadMaterials,
          ),
          _buildProfileMenuItem(
            context: context,
            icon: Icons.delete_sweep_outlined,
            title: l10n.clearCache,
          ),
          const Divider(),
          _buildProfileMenuItem(
            context: context,
            icon: Icons.logout,
            title: l10n.logout,
            textColor: Colors.red,
            isLogout: true,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle,
    Color? textColor,
    bool isLogout = false,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: textColor),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: textColor ?? Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: subtitle != null ? Text(subtitle) : null,
      trailing: isLogout ? null : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {},
    );
  }

  Widget _buildLanguageMenuItem(
      BuildContext context,
      LocaleProvider localeProvider,
      AppLocalizations l10n,
      ) {
    final currentLocale = localeProvider.locale;
    String currentLanguage = l10n.english; // Default ke English

    if (currentLocale != null) {
      switch (currentLocale.languageCode) {
        case 'en':
          currentLanguage = l10n.english;
          break;
        case 'id':
          currentLanguage = l10n.indonesian;
          break;
      }
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.language_outlined),
      title: Text(
        l10n.language,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(currentLanguage),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _showLanguageDialog(context, localeProvider, l10n),
    );
  }

  Widget _buildThemeMenuItem(
      BuildContext context,
      ThemeProvider themeProvider,
      AppLocalizations l10n,
      ) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.color_lens_outlined),
      title: Text(
        l10n.theme,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Theme.of(context).textTheme.bodyLarge?.color,
        ),
      ),
      subtitle: Text(themeProvider.isDarkMode ? l10n.dark : l10n.light),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () => _showThemeDialog(context, themeProvider, l10n),
    );
  }

  void _showLanguageDialog(
      BuildContext context,
      LocaleProvider localeProvider,
      AppLocalizations l10n,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<Locale?>(
                title: Text(l10n.english),
                value: const Locale('en'),
                groupValue: localeProvider.locale,
                onChanged: (Locale? value) {
                  if (value != null) {
                    localeProvider.setLocale(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<Locale?>(
                title: Text(l10n.indonesian),
                value: const Locale('id'),
                groupValue: localeProvider.locale,
                onChanged: (Locale? value) {
                  if (value != null) {
                    localeProvider.setLocale(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showThemeDialog(
      BuildContext context,
      ThemeProvider themeProvider,
      AppLocalizations l10n,
      ) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(l10n.theme),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<ThemeMode>(
                title: Text(l10n.light),
                value: ThemeMode.light,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeProvider.setThemeMode(value);
                    Navigator.pop(context);
                  }
                },
              ),
              RadioListTile<ThemeMode>(
                title: Text(l10n.dark),
                value: ThemeMode.dark,
                groupValue: themeProvider.themeMode,
                onChanged: (ThemeMode? value) {
                  if (value != null) {
                    themeProvider.setThemeMode(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}