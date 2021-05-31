import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdf;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
// import 'package:path_provider/path_provider.dart';
/*
Future<void> pdfGenerator(downloadPath, name) async {

  var myTheme = new pdf.ThemeData.withFont(
    base: Font.ttf(await rootBundle.load("fonts/Roboto-Regular.ttf")),
  );
  final _pdf = pdf.Document(
    theme: myTheme
  );
  final _assetImage = await pdfImageFromImageProvider(
    pdf: _pdf.document,
    image: AssetImage(
      'assets/images/img/profil.jpg',
    ),
  );
  _pdf.addPage(
    pdf.Page(
      pageFormat: PdfPageFormat.a4,
      build: (context) => pdf.Center(
        child: pdf.Container(
          margin: pdf.EdgeInsets.all(2),
          width: PdfPageFormat.a4.width,
          child: pdf.Column(
            children: [
              pdf.Container(
                child: pdf.Text("Validations")
              ),
              pdf.Table(
                children: [
                  pdf.TableRow(
                    children: [
                      pdf.Text("Cell1"),
                      pdf.Text("Cell2"),
                      pdf.Text("Cell3")
                    ]
                  )
                ]
              )

            ],
          ),
        ),
      ),
    ),
  );
  File('$downloadPath/$name.pdf').writeAsBytesSync(_pdf.save());

}
*/
Future<String> getApplicationDocumentsDirectoryPath() async {
//  final Directory applicationDocumentsDirectory =
 // await getApplicationDocumentsDirectory();
  //return applicationDocumentsDirectory.path;
}
