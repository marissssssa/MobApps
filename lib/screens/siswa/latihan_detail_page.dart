import 'package:flutter/material.dart';
import 'package:educonnect/l10n/app_localizations.dart';
import 'package:educonnect/l10n/l10n.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:educonnect/providers/theme_provider.dart';

class LatihanDetailPage extends StatefulWidget {
  final String title;
  final List<String>? initialFileNames;
  final String question;
  final Function(String, List<String>?) onTurnIn;

  const LatihanDetailPage({
    Key? key,
    required this.title,
    this.initialFileNames,
    required this.question,
    required this.onTurnIn,
  }) : super(key: key);

  @override
  State<LatihanDetailPage> createState() => _LatihanDetailPageState();
}

class _LatihanDetailPageState extends State<LatihanDetailPage> {
  List<String> _uploadedFileNames = [];

  @override
  void initState() {
    super.initState();
    if (widget.initialFileNames != null) {
      _uploadedFileNames = List.from(widget.initialFileNames!);
    }
  }

  Future<void> _pickFile() async {
    final l10n = AppLocalizations.of(context)!;

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _uploadedFileNames.add(result.files.single.name);
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${l10n.fileSelectionError}: $e')),
        );
      }
    }
  }

  void _removeFile(String fileNameToRemove) {
    setState(() {
      _uploadedFileNames.remove(fileNameToRemove);
    });
  }

  void _turnIn() {
    widget.onTurnIn(widget.title, _uploadedFileNames.isNotEmpty ? _uploadedFileNames : null);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Theme.of(context).cardColor,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.workOnThisQuestion,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.question,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Uploaded files list
            ..._uploadedFileNames.map((fileName) => Card(
              color: Theme.of(context).cardColor,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: ListTile(
                title: Text(
                  fileName,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () => _removeFile(fileName),
                ),
              ),
            )),

            // Add file button
            GestureDetector(
              onTap: _pickFile,
              child: Card(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n.addOrCreate,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _uploadedFileNames.isNotEmpty ? _turnIn : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDarkMode
                      ? const Color.fromRGBO(82, 193, 185, 1)
                      : const Color.fromRGBO(160, 203, 196, 1),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  l10n.turnIn,
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}