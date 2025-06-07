import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'detail_materi_page.dart';
import 'video_player_page.dart'; 

class SubMateriPage extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> subMaterials; //
  final bool isPdf;

  const SubMateriPage({
    super.key,
    required this.title,
    required this.subMaterials,
    this.isPdf = true,
  });

  Future<void> _downloadFile(BuildContext context, String filePath, String title) async {
    final byteData = await rootBundle.load(filePath);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$title.pdf');
    await file.writeAsBytes(byteData.buffer.asUint8List());

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$title berhasil diunduh!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        itemCount: subMaterials.length,
        itemBuilder: (context, index) {
          final item = subMaterials[index];
          return Card(
            child: ListTile(
              // Ikon berbeda berdasarkan isPdf
              leading: Icon(isPdf ? Icons.description : Icons.play_circle_filled),
              title: Text(item['title']!),
              trailing: isPdf
                  ? IconButton(
                      icon: const Icon(Icons.download),
                      onPressed: () => _downloadFile(context, item['filePath']!, item['title']!),
                    )
                  : null, // Tidak ada tombol download untuk video
              onTap: () {
                if (isPdf) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMateriPage(
                        title: item['title']!,
                        filePath: item['filePath']!,
                      ),
                    ),
                  );
                } else {
                  // Navigasi ke halaman pemutar video
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerPage(
                        title: item['title']!,
                        videoUrl: item['url']!,
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