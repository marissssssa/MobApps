import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class LatihanDetailPage extends StatefulWidget {
  final String title;
  final List<String>? initialFileNames;
  final String question; // Properti baru untuk soal
  final Function(String, List<String>?) onTurnIn;

  const LatihanDetailPage({
    Key? key,
    required this.title,
    this.initialFileNames,
    required this.question, // Wajibkan properti 'question'
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
    print('Attempting to pick file...');
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        setState(() {
          _uploadedFileNames.add(result.files.single.name);
        });
        print('File picked successfully: ${result.files.single.name}');
      } else {
        print('File picker canceled by user.');
      }
    } catch (e) {
      print('Error picking file: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error selecting file: $e')),
        );
      }
    }
  }

  void _removeFile(String fileNameToRemove) {
    setState(() {
      _uploadedFileNames.remove(fileNameToRemove);
    });
    print('File removed: $fileNameToRemove');
  }

  void _turnIn() {
    print('Turning in: ${widget.title} with files: $_uploadedFileNames');
    widget.onTurnIn(widget.title, _uploadedFileNames.isNotEmpty ? _uploadedFileNames : null);
    Navigator.pop(context);
    print('Navigated back to previous page.');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.title, style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Kerjakan soal berikut:', style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 8),
                    Text(
                      widget.question, // Menampilkan soal dari properti widget
                      style: const TextStyle(fontSize: 14, color: Colors.black87), // Ubah warna agar lebih jelas
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Tampilkan daftar file yang diunggah
            ..._uploadedFileNames.map((fileName) => Card(
                  margin: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ListTile(
                    title: Text(fileName),
                    trailing: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => _removeFile(fileName),
                    ),
                  ),
                )),

            // Tombol "Add or create" selalu ada
            GestureDetector(
              onTap: _pickFile,
              child: Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add),
                      SizedBox(width: 8),
                      Text('Add or create', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                // Tombol "Turn in" aktif jika ada setidaknya satu file
                onPressed: _uploadedFileNames.isNotEmpty ? _turnIn : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(160, 203, 196, 1),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Turn in',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}