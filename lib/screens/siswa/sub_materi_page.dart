import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:educonnect/providers/theme_provider.dart';
import 'detail_materi_page.dart';
import 'video_player_page.dart';

class SubMateriPage extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> subMaterials;
  final bool isPdf;

  const SubMateriPage({
    super.key,
    required this.title,
    required this.subMaterials,
    this.isPdf = true,
  });

  Future<void> _downloadFile(BuildContext context, String sourcePath, String titleToSaveAs) async {
    final l10n = AppLocalizations.of(context)!;

    try {
      final byteData = await rootBundle.load(sourcePath);
      final dir = await getApplicationDocumentsDirectory();
      final String fileExtension = sourcePath.split('.').last;
      final String fileName = '$titleToSaveAs.$fileExtension';
      final file = File('${dir.path}/$fileName');

      await file.writeAsBytes(byteData.buffer.asUint8List());

      String fileType = l10n.file;
      if (fileExtension == 'pdf') {
        fileType = 'PDF';
      } else if (['mp4', 'mov', 'avi', 'mkv'].contains(fileExtension.toLowerCase())) {
        fileType = l10n.video;
      } else if (['mp3', 'wav', 'aac', 'flac'].contains(fileExtension.toLowerCase())) {
        fileType = l10n.audio;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$fileType "$titleToSaveAs" ${l10n.downloadSuccess} ${dir.path}')),
      );
    } catch (e) {
      print('Error downloading file: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${l10n.downloadFailed} "$titleToSaveAs": ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final l10n = AppLocalizations.of(context)!;
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).iconTheme.color),
      ),
      body: ListView.builder(
        itemCount: subMaterials.length,
        itemBuilder: (context, index) {
          final item = subMaterials[index];
          final String fileTitle = item['title']!;
          final String? sourcePathForDownload = isPdf ? item['filePath'] : item['url'];

          return Card(
            color: Theme.of(context).cardColor,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                isPdf ? Icons.description : Icons.play_circle_filled,
                color: isDarkMode ? Colors.tealAccent : Theme.of(context).primaryColor,
              ),//
              title: Text(
                fileTitle,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              trailing: sourcePathForDownload != null
                  ? IconButton(
                icon: Icon(
                  Icons.download,
                  color: Theme.of(context).iconTheme.color,
                ),
                onPressed: () => _downloadFile(context, sourcePathForDownload, fileTitle),
              )
                  : null,
              onTap: () {
                if (isPdf) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailMateriPage(
                        title: fileTitle,
                        filePath: item['filePath']!,
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => VideoPlayerPage(
                        title: fileTitle,
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