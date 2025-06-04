import 'package:flutter/material.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:educonnect/l10n/app_localizations.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  bool taskNotification = true;
  bool announcementNotification = false;
  bool reminderNotification = true;

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
            Icon(Icons.notifications, color: Theme.of(context).iconTheme.color),
            const SizedBox(width: 8),
            Text(local.notification,
                style: TextStyle(color: Theme.of(context).iconTheme.color)),
          ],
        ),
      ),
      body: Stack(
        children: [
          const Positioned(
            top: -40,
            left: -50,
            child: Opacity(
              opacity: 0.7,
              child: Icon(
                Icons.notifications_active,
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
                  icon: Icons.assignment,
                  title: local.taskNotification,
                  value: taskNotification,
                  onChanged: (val) => setState(() => taskNotification = val),
                ),
                _buildToggleTile(
                  icon: Icons.campaign,
                  title: local.announcement,
                  value: announcementNotification,
                  onChanged: (val) =>
                      setState(() => announcementNotification = val),
                ),
                _buildToggleTile(
                  icon: Icons.alarm,
                  title: local.reminderNotification,
                  value: reminderNotification,
                  onChanged: (val) =>
                      setState(() => reminderNotification = val),
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
