import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class DetailMateriPage extends StatelessWidget {
  final String title;
  final String filePath;

  const DetailMateriPage({super.key, required this.title, required this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SfPdfViewer.asset(filePath),
    );
  }
}
