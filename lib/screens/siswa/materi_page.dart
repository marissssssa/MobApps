import 'package:flutter/material.dart';
import 'sub_materi_page.dart';

class MateriPage extends StatefulWidget {
  final String selectedSubject;

  const MateriPage({super.key, required this.selectedSubject});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  late String selectedSubject;

  final List<String> subjects = [
    'All',
    'Biology',
    'Chemistry',
    'Citizenship',
    'History',
    'Mathematics',
    'Physics'
  ];
  final List<Map<String, dynamic>> materials = [
    {
      'subject': 'Biology',
      'type': Icons.description,
      'label': 'Sistem Organ Manusia'
    },
    {
      'subject': 'Biology',
      'type': Icons.volume_up,
      'label': 'Sel dan Jaringan'
    },
    {
      'subject': 'Chemistry',
      'type': Icons.description,
      'label': 'Reaksi Kimia'
    },
    {
      'subject': 'Chemistry',
      'type': Icons.play_circle_filled,
      'label': 'Struktur Atom'
    },
    {
      'subject': 'Citizenship',
      'type': Icons.description,
      'label': 'Hak dan Kewajiban Warga Negara'
    },
    {
      'subject': 'History',
      'type': Icons.play_circle_filled,
      'label': 'Perang Dunia II'
    },
    {
      'subject': 'History',
      'type': Icons.description,
      'label': 'Kemerdekaan Indonesia'
    },
    {
      'subject': 'Mathematics',
      'type': Icons.description,
      'label': 'Aljabar Dasar'
    },
    {'subject': 'Mathematics', 'type': Icons.volume_up, 'label': 'Geometri'},
    {
      'subject': 'Physics',
      'type': Icons.play_circle_filled,
      'label': 'Hukum Newton'
    },
    {
      'subject': 'Physics',
      'type': Icons.description,
      'label': 'Gerak Lurus Beraturan'
    },
    {
      'subject': 'Physics',
      'type': Icons.description,
      'label': 'Gerak Lurus Tidak Beraturan'
    },
  ];

  @override
  void initState() {
    super.initState();
    selectedSubject = widget.selectedSubject;
  }

  @override
  void didUpdateWidget(covariant MateriPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedSubject != widget.selectedSubject) {
      setState(() {
        selectedSubject = widget.selectedSubject;
      });
    }
  }

  List<Map<String, dynamic>> getFilteredMaterials() {
    if (selectedSubject == 'All') {
      return materials;
    }
    return materials.where((m) => m['subject'] == selectedSubject).toList();
  }

  final Map<String, List<Map<String, String>>> subMaterialsMap = {
    'Aljabar Dasar': [
      {'title': 'Aljabar', 'filePath': 'assets/materi/Aljabar.pdf'},
    ],
    'Gerak Lurus Beraturan': [
      {
        'title': 'Gerak Lurus Beraturan',
        'filePath': 'assets/materi/Gerak Lurus Beraturan.pdf'
      },
    ],
    // Tambahkan materi lainnya di sini jika perlu
  };

  @override
  Widget build(BuildContext context) {
    final filteredMaterials = getFilteredMaterials();

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: selectedSubject,
                    isExpanded: true,
                    onChanged: (value) {
                      setState(() {
                        selectedSubject = value!;
                      });
                    },
                    items: subjects
                        .map((subject) => DropdownMenuItem(
                              value: subject,
                              child: Text(subject),
                            ))
                        .toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...filteredMaterials.map((material) {
              return Card(
                child: ListTile(
                  leading: Icon(material['type'], size: 32),
                  title: Text(material['label']),
                  subtitle: Text(material['subject']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    final label = material['label'];
                    final subMaterials = subMaterialsMap[label] ?? [];

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SubMateriPage(
                          title: label,
                          subMaterials: subMaterials,
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
