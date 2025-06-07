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

  final List<String> subjects = ['All', 'Biology', 'Chemistry', 'Citizenship', 'History', 'Mathematics', 'Physics'];

  // Tambahkan properti 'isPdf' untuk membedakan materi
  final List<Map<String, dynamic>> materials = [
    {'subject': 'Biology', 'type': Icons.description, 'label': 'Sistem Organ Manusia', 'isPdf': true},
    {'subject': 'Biology', 'type': Icons.volume_up, 'label': 'Sel dan Jaringan', 'isPdf': false},
    {'subject': 'Chemistry', 'type': Icons.description, 'label': 'Reaksi Kimia', 'isPdf': true},
    {'subject': 'Chemistry', 'type': Icons.play_circle_filled, 'label': 'Struktur Atom', 'isPdf': false},
    {'subject': 'Citizenship', 'type': Icons.description, 'label': 'Hak dan Kewajiban Warga Negara', 'isPdf': true},
    {'subject': 'History', 'type': Icons.play_circle_filled, 'label': 'Perang Dunia II', 'isPdf': false},
    {'subject': 'History', 'type': Icons.description, 'label': 'Kemerdekaan Indonesia', 'isPdf': true},
    {'subject': 'Mathematics', 'type': Icons.description, 'label': 'Aljabar Dasar', 'isPdf': true},
    {'subject': 'Mathematics', 'type': Icons.volume_up, 'label': 'Geometri', 'isPdf': false},
    {'subject': 'Physics', 'type': Icons.play_circle_filled, 'label': 'Hukum Newton', 'isPdf': false}, 
    {'subject': 'Physics', 'type': Icons.description, 'label': 'Gerak Lurus Beraturan', 'isPdf': true},
    {'subject': 'Physics', 'type': Icons.description, 'label': 'Gerak Lurus Tidak Beraturan', 'isPdf': true},
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

  // Map untuk sub-materi video
  final Map<String, List<Map<String, dynamic>>> subMaterialsMapVideo = {
    'Hukum Newton': [
      {'title': 'Video Hukum Newton 1', 'type': 'video', 'url': 'assets/video/Hukum_Newton.mp4'},
    ],
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
              final label = material['label'];
              final isPdf = material['isPdf'] as bool? ?? true; // Ambil nilai isPdf, default ke true

              return Card(
                child: ListTile(
                  leading: Icon(material['type'], size: 32),
                  title: Text(label),
                  subtitle: Text(material['subject']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    if (isPdf) {
                      final subMaterials = subMaterialsMap[label] ?? [];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubMateriPage(
                            title: label,
                            subMaterials: subMaterials,
                            isPdf: true, // Kirimkan flag isPdf
                          ),
                        ),
                      );
                    } else {
                      // Jika bukan PDF, gunakan subMaterialsMapVideo
                      final subMaterials = subMaterialsMapVideo[label] ?? [];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubMateriPage(
                            title: label,
                            subMaterials: subMaterials,
                            isPdf: false, // Kirimkan flag isPdf
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
}