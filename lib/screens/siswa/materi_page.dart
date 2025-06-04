// lib/screens/siswa/materi_page.dart

import 'package:flutter/material.dart';

class MateriPage extends StatelessWidget {
  // Parameter wajib yang akan diisi dari SiswaHomepage
  final String selectedSubject;

<<<<<<< HEAD
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
=======
  const MateriPage({Key? key, required this.selectedSubject}) : super(key: key);
>>>>>>> 90ee457fe2d022664d411e9c86275447042a211a

  @override
  Widget build(BuildContext context) {
    // Contoh UI sederhana untuk halaman materi:
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          selectedSubject,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        color: Colors.grey[100],
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Judul materi
            Text(
              'Materi: $selectedSubject',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 16),

            // Contoh konten materi
            Expanded(
              child: Center(
                child: Text(
                  'Di sini akan ditampilkan detail materi untuk "$selectedSubject".\n\n'
                  'Anda bisa menambahkan daftar sub‐materi, video, PDF, atau konten lain sesuai kebutuhan.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                ),
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
