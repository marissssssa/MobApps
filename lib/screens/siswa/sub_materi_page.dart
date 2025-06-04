import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart'; // LANGKAH 3: Tambahkan import ini
import 'detail_materi_page.dart';

// LANGKAH 4: Ubah menjadi StatefulWidget
class SubMateriPage extends StatefulWidget {
  final String title;
  final List<Map<String, String>> subMaterials;

  const SubMateriPage(
      {super.key, required this.title, required this.subMaterials});

  @override
  State<SubMateriPage> createState() => _SubMateriPageState();
}

class _SubMateriPageState extends State<SubMateriPage> {
  Future<void> _downloadFile(String filePath, String title) async {
    try {
      final byteData = await rootBundle.load(filePath);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$title.pdf');
      await file.writeAsBytes(byteData.buffer.asUint8List());

      // LANGKAH 5: Gunakan 'mounted' check sebelum memakai context
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$title berhasil diunduh!')),
      );
    } catch (e) {
      // Menangani jika terjadi error saat download
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunduh: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: widget.subMaterials.length,
        itemBuilder: (context, index) {
          final item = widget.subMaterials[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.description),
              title: Text(item['title']!),
              trailing: IconButton(
                icon: const Icon(Icons.download),
                onPressed: () =>
                    _downloadFile(item['filePath']!, item['title']!),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailMateriPage(
                      title: item['title']!,
                      filePath: item['filePath']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
  // LANGKAH 1: Fungsi yang salah di sini sudah dihapus
}
