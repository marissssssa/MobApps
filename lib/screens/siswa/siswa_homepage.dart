import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/providers/theme_provider.dart';


class SiswaHomepage extends StatelessWidget {
  final void Function(String subject) onSubjectSelected;
  final void Function(String title) onHomeworkSelected;
  final List<Map<String, dynamic>> allLatihan;
  final VoidCallback onProfileTap;

  const SiswaHomepage({
    super.key,
    required this.onSubjectSelected,
    required this.onHomeworkSelected,
    required this.allLatihan,
    required this.onProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;

    // Filter latihan yang akan ditampilkan sebagai homework di homepage
    final List<Map<String, dynamic>> homeworkItems = allLatihan.where((item) =>
    item['title'] == 'Algebra II' || item['title'] == 'World History'
    ).toList();

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            // --- Header ---
            _buildHeader(context, "Skeeter Davis", l10n),
            const SizedBox(height: 24),

            // --- Search Bar ---
            _buildSearchBar(context, l10n),
            const SizedBox(height: 24),

            // --- Materials Section ---
            Text(
              l10n.materials,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildMaterialsGrid(context),
            const SizedBox(height: 24),

            // --- Homework Section ---
            Text(
              l10n.homework,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            ...homeworkItems.map((item) {
              return _buildHomeworkItem(
                context,
                item['title'],
                item['deadline'],
                themeProvider.isDarkMode,
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, String name, AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${l10n.hello},",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onBackground.withOpacity(0.7),
              ),
            ),
            Text(
              name,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            onProfileTap(); // Panggil callback yang diteruskan
          },
          child: const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context, AppLocalizations l10n) {
    return TextField(
      decoration: InputDecoration(
        hintText: l10n.search,
        prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Theme.of(context).cardColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      ),
    );
  }

  Widget _buildMaterialsGrid(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final subjects = [
      {
        'icon': Icons.calculate,
        'title': l10n.mathematics,
        'color': Colors.orange,
      },
      {
        'icon': Icons.biotech,
        'title': l10n.biology,
        'color': Colors.green,
      },
      {
        'icon': Icons.science,
        'title': l10n.chemistry,
        'color': Colors.blue,
      },
      {
        'icon': Icons.rocket_launch,
        'title': l10n.physics,
        'color': Colors.purple,
      },
      {
        'icon': Icons.history_edu,
        'title': l10n.history,
        'color': Colors.red,
      },
      {
        'icon': Icons.flag,
        'title': l10n.citizenship,
        'color': Colors.teal,
      },
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2.5,
      children: subjects.map((subject) {
        return _buildMaterialCard(
          context,
          subject['icon'] as IconData,
          subject['title'] as String,
          subject['color'] as Color,
        );
      }).toList(),
    );
  }

Widget _buildMaterialCard(
  BuildContext context,
  IconData icon,
  String title,
  Color color,
) {
  return GestureDetector(
    onTap: () {

      String subjectKey;
      final l10n = AppLocalizations.of(context)!;
      if (title == l10n.mathematics) subjectKey = 'mathematics';
      else if (title == l10n.physics) subjectKey = 'physics';
      else if (title == l10n.chemistry) subjectKey = 'chemistry';
      else if (title == l10n.biology) subjectKey = 'biology';
      else if (title == l10n.history) subjectKey = 'history';
      else if (title == l10n.citizenship) subjectKey = 'citizenship';
      else subjectKey = 'all';//

      onSubjectSelected(subjectKey);
    },
    child: Card(
        color: color.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
        child: Center(
          child: ListTile(
            leading: Icon(icon, color: color),
            title: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
  );
}

  Widget _buildHomeworkItem(
      BuildContext context,
      String title,
      String date,
      bool isDarkMode,
      ) {
    return GestureDetector(
      onTap: () => onHomeworkSelected(title),
      child: Card(
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: Theme.of(context).cardColor,
        child: ListTile(
          leading: Icon(
            Icons.assignment,
            color: isDarkMode ? Colors.lightBlueAccent : Colors.blueAccent,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            date,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Theme.of(context).iconTheme.color,
          ),
        ),
      ),
    );
  }
}