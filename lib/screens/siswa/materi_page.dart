import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:educonnect/providers/theme_provider.dart';
import 'sub_materi_page.dart';

class MateriPage extends StatefulWidget {
  final String selectedSubjectKey;

  const MateriPage({super.key, required this.selectedSubjectKey});
//
  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  late String selectedSubjectKey;
  late ThemeProvider themeProvider;

  static const List<String> allSubjectKeys = [
    'all', 'biology', 'chemistry', 'citizenship',
    'history', 'mathematics', 'physics'
  ];

  final List<Map<String, dynamic>> materials = [
    {'subject': 'biology', 'type': Icons.description, 'label': 'Sistem Organ Manusia', 'isPdf': true},
    {'subject': 'biology', 'type': Icons.volume_up, 'label': 'Sel dan Jaringan', 'isPdf': false},
    {'subject': 'chemistry', 'type': Icons.description, 'label': 'Reaksi Kimia', 'isPdf': true},
    {'subject': 'chemistry', 'type': Icons.play_circle_filled, 'label': 'Struktur Atom', 'isPdf': false},
    {'subject': 'citizenship', 'type': Icons.description, 'label': 'Hak dan Kewajiban Warga Negara', 'isPdf': true},
    {'subject': 'history', 'type': Icons.play_circle_filled, 'label': 'Perang Dunia II', 'isPdf': false},
    {'subject': 'history', 'type': Icons.description, 'label': 'Kemerdekaan Indonesia', 'isPdf': true},
    {'subject': 'mathematics', 'type': Icons.description, 'label': 'Aljabar Dasar', 'isPdf': true},
    {'subject': 'mathematics', 'type': Icons.volume_up, 'label': 'Geometri', 'isPdf': false},
    {'subject': 'physics', 'type': Icons.play_circle_filled, 'label': 'Hukum Newton', 'isPdf': false},
    {'subject': 'physics', 'type': Icons.description, 'label': 'Gerak Lurus Beraturan', 'isPdf': true},
    {'subject': 'physics', 'type': Icons.description, 'label': 'Gerak Lurus Tidak Beraturan', 'isPdf': true},
  ];

  @override
  void initState() {
    super.initState();
    selectedSubjectKey = allSubjectKeys.contains(widget.selectedSubjectKey)
        ? widget.selectedSubjectKey
        : 'all';
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    themeProvider = Provider.of<ThemeProvider>(context);
  }

  @override
  void didUpdateWidget(covariant MateriPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedSubjectKey != widget.selectedSubjectKey) {
      setState(() {
        selectedSubjectKey = allSubjectKeys.contains(widget.selectedSubjectKey)
            ? widget.selectedSubjectKey
            : 'all';
      });
    }
  }

  List<Map<String, dynamic>> getFilteredMaterials() {
    if (selectedSubjectKey == 'all') {
      return materials;
    }
    return materials.where((m) => m['subject'] == selectedSubjectKey).toList();
  }

  String getLocalizedSubject(String key, AppLocalizations l10n) {
    switch (key) {
      case 'all': return l10n.all;
      case 'biology': return l10n.biology;
      case 'chemistry': return l10n.chemistry;
      case 'citizenship': return l10n.citizenship;
      case 'history': return l10n.history;
      case 'mathematics': return l10n.mathematics;
      case 'physics': return l10n.physics;
      default: return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = themeProvider.isDarkMode;
    final filteredMaterials = getFilteredMaterials();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 10),
            Card(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSubjectKey,
                    isExpanded: true,
                    dropdownColor: Theme.of(context).cardColor,
                    style: Theme.of(context).textTheme.bodyLarge,
                    onChanged: (value) {
                      if (value != null) {
                        setState(() {
                          selectedSubjectKey = value;
                        });
                      }
                    },
                    items: allSubjectKeys
                        .map((key) => DropdownMenuItem(
                      value: key,
                      child: Text(getLocalizedSubject(key, l10n)),
                    ))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...filteredMaterials.map((material) {
              final label = material['label'];
              final isPdf = material['isPdf'] as bool? ?? true;
              final materialTypeIcon = material['type'] as IconData;
              final subjectKey = material['subject'] as String;
              final subjectName = getLocalizedSubject(subjectKey, l10n);

              return Card(
                color: Theme.of(context).cardColor,
                child: ListTile(
                  leading: Icon(
                    materialTypeIcon,
                    size: 32,
                    color: isDarkMode ? Colors.tealAccent : Theme.of(context).primaryColor,
                  ),
                  title: Text(
                    label,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  subtitle: Text(
                    subjectName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onTap: () {
                    if (isPdf) {
                      final subMaterials = subMaterialsMap[label] ?? [];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubMateriPage(
                            title: label,
                            subMaterials: subMaterials,
                            isPdf: true,
                          ),
                        ),
                      );
                    } else {
                      List<Map<String, dynamic>> subMaterialsToPass = [];
                      if (materialTypeIcon == Icons.play_circle_filled) {
                        subMaterialsToPass = subMaterialsMapVideo[label] ?? [];
                      } else if (materialTypeIcon == Icons.volume_up) {
                        subMaterialsToPass = subMaterialsMapAudio[label] ?? [];
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubMateriPage(
                            title: label,
                            subMaterials: subMaterialsToPass,
                            isPdf: false,
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  // Data sub-materi tetap sama
  final Map<String, List<Map<String, String>>> subMaterialsMap = {
    'Aljabar Dasar': [
      {'title': 'Aljabar', 'filePath': 'assets/materi/Aljabar.pdf'},
    ],
    'Gerak Lurus Beraturan': [
      {'title': 'Gerak Lurus Beraturan', 'filePath': 'assets/materi/Gerak Lurus Beraturan.pdf'},
    ],
    'Gerak Lurus Tidak Beraturan': [
      {'title': 'Gerak Lurus Tidak Beraturan', 'filePath': 'assets/materi/Gerak Lurus Tidak Beraturan.pdf'},
    ],
    'Sistem Organ Manusia': [
      {'title': 'Sistem Organ Manusia', 'filePath': 'assets/materi/Sistem Organ Manusia.pdf'},
    ],
    'Reaksi Kimia': [
      {'title': 'Reaksi Kimia', 'filePath': 'assets/materi/Reaksi Kimia.pdf'},
    ],
    'Hak dan Kewajiban Warga Negara': [
      {'title': 'Hak dan Kewajiban Warga Negara', 'filePath': 'assets/materi/Hak dan Kewajiban Warga Negara.pdf'},
    ],
    'Kemerdekaan Indonesia': [
      {'title': 'Kemerdekaan Indonesia', 'filePath': 'assets/materi/Kemerdekaan Indonesia.pdf'},
    ],
  };

  final Map<String, List<Map<String, dynamic>>> subMaterialsMapVideo = {
    'Hukum Newton': [
      {'title': 'Hukum Newton 1-3', 'type': 'video', 'url': 'assets/video/Hukum_Newton.mp4'},
    ],
    'Perang Dunia II': [
      {'title': 'Perang Dunia II', 'type': 'video', 'url': 'assets/video/Perang_Dunia_II.mp4'},
    ],
    'Struktur Atom': [
      {'title': 'Perang Dunia II', 'type': 'video', 'url': 'assets/video/Struktur_Atom.mp4'},
    ],
  };

  final Map<String, List<Map<String, dynamic>>> subMaterialsMapAudio = {
    'Geometri': [
      {'title': 'Geometri', 'type': 'audio', 'url': 'assets/audio/Geometri.mp3'},
    ],
    'Sel dan Jaringan': [
      {'title': 'Sel dan Jaringan', 'type': 'audio', 'url': 'assets/audio/Sel_dan_Jaringan.mp3'},
    ],
  };
}