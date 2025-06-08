// sub_materi_page.dart
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'detail_materi_page.dart';
import 'video_player_page.dart';

class SubMateriPage extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> subMaterials;
  final bool isPdf; // Menunjukkan apakah halaman ini berisi materi PDF (true) atau media (video/audio) (false)

  const SubMateriPage({
    super.key,
    required this.title,
    required this.subMaterials,
    this.isPdf = true, // Default ke true untuk kompatibilitas mundur
  });

  // Fungsi yang diperbarui untuk mengunduh berbagai jenis file
  Future<void> _downloadFile(BuildContext context, String sourcePath, String titleToSaveAs) async {
    try {
      final byteData = await rootBundle.load(sourcePath);
      final dir = await getApplicationDocumentsDirectory();

      // Ambil ekstensi file dari sourcePath (misal: 'pdf', 'mp4', 'mp3')
      final String fileExtension = sourcePath.split('.').last;
      
      final String fileName = '$titleToSaveAs.$fileExtension'; // Buat nama file lengkap
      final file = File('${dir.path}/$fileName'); // Buat objek file

      await file.writeAsBytes(byteData.buffer.asUint8List()); // Tulis data ke file

      // Tentukan tipe file untuk pesan yang lebih spesifik
      String fileType = 'file';
      if (fileExtension == 'pdf') {
        fileType = 'PDF';
      } else if (['mp4', 'mov', 'avi', 'mkv'].contains(fileExtension.toLowerCase())) {
        fileType = 'video';
      } else if (['mp3', 'wav', 'aac', 'flac'].contains(fileExtension.toLowerCase())) {
        fileType = 'audio';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fileType "$titleToSaveAs" berhasil diunduh ke ${dir.path}/$fileName!')),
      );
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengunduh "$titleToSaveAs": ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: subMaterials.length,
        itemBuilder: (context, index) {
          final item = subMaterials[index];
          final String fileTitle = item['title']!;

          // Tentukan jalur sumber untuk diunduh.
          // Jika isPdf true, gunakan 'filePath'. Jika false (media), gunakan 'url'.
          final String? sourcePathForDownload = isPdf ? item['filePath'] : item['url'];

          return Card(
            child: ListTile(
              // Ikon berbeda berdasarkan tipe halaman (PDF atau media)
              leading: Icon(isPdf ? Icons.description : Icons.play_circle_filled),
              title: Text(fileTitle),
              // Tampilkan tombol unduh jika ada sumber yang bisa diunduh
              trailing: sourcePathForDownload != null
                  ? IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () => _downloadFile(context, sourcePathForDownload, fileTitle),
                    )
                  : null, // Tidak ada tombol download jika sourcePathForDownload null
              onTap: () {
                if (isPdf) { // Navigasi ke PDF Viewer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMateriPage(
                        title: fileTitle,
                        filePath: item['filePath']!, // Pastikan 'filePath' ada untuk PDF
                      ),
                    ),
                  );
                } else { // Navigasi ke Video/Audio Player
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerPage(
                        title: fileTitle,
                        videoUrl: item['url']!, // Pastikan 'url' ada untuk video/audio
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}