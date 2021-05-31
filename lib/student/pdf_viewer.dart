import 'package:flutter/material.dart';

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class ViewerScreen extends StatelessWidget {
  final String path;

  const ViewerScreen(this.path);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Validation'),
      ),
      body: PdfView(
        path: path,
      ),
    );
  }
}