import 'package:flutter/material.dart';
import 'sub_materi_page.dart';

class MateriPage extends StatefulWidget {
  final String selectedSubject;

<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
  const MateriPage({super.key, required this.selectedSubject});

  @override
  State<MateriPage> createState() => _MateriPageState();
}

class _MateriPageState extends State<MateriPage> {
  late String selectedSubject;

<<<<<<< HEAD
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
=======
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
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
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
<<<<<<< HEAD
      {
        'title': 'Gerak Lurus Beraturan',
        'filePath': 'assets/materi/Gerak Lurus Beraturan.pdf'
      },
    ],
    // Tambahkan materi lainnya di sini jika perlu
  };
=======
  const MateriPage({Key? key, required this.selectedSubject}) : super(key: key);
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
=======
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
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48

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
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a
=======
            const SizedBox(height: 20),
            ...filteredMaterials.map((material) {
              final label = material['label'];
              final isPdf = material['isPdf'] as bool? ?? true; // Ambil nilai isPdf, default ke true
              final materialTypeIcon = material['type'] as IconData;

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
                      // Ini adalah bagian yang diubah
                      List<Map<String, dynamic>> subMaterialsToPass = [];
                      if (materialTypeIcon == Icons.play_circle_filled) { // Jika ikonnya adalah video
                        subMaterialsToPass = subMaterialsMapVideo[label] ?? [];
                      } else if (materialTypeIcon == Icons.volume_up) { // Jika ikonnya adalah audio
                        subMaterialsToPass = subMaterialsMapAudio[label] ?? [];
                      }

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SubMateriPage(
                            title: label,
                            subMaterials: subMaterialsToPass, // Gunakan subMaterialsToPass
                            isPdf: false, // Kirimkan flag isPdf untuk media
                          ),
                        ),
                      );
                    }
                  },
                ),
              );
            }).toList(),
>>>>>>> eb1a387076a9464f7959cf5a7009f06f1255ca48
          ],
        ),
      ),
    );
  }
}