import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:uac_campus/widgets/custom_app_bar.dart';
import 'package:uac_campus/widgets/drawer.dart';
import 'package:uac_campus/student/pdf_viewer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../to_pdf.dart';


class Validation extends StatefulWidget{
  @override
  _ValidationState createState() => _ValidationState();
}

class _ValidationState extends State<Validation> with TickerProviderStateMixin{
  Color globalColor = new Color.fromRGBO(40, 70, 79, 1);

  _initData() async {

  }

  @override
  void initState() {
    super.initState();
    _initData();
  }

  @override
  Widget build(BuildContext context) {
    String name = "Validation";
    return Scaffold(

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CustomAppBar((context), "Mon Parcours Académique")
          ];
        },
        body: Column(
          children: [
            Container(              
              child: FlatButton(
                child: Image.asset("assets/images/icons/pdf-file.png", width: 50, height: 50,),
                onPressed: () async {
                  String downloadPath = await createDir();
                //  pdfGenerator(downloadPath, name);
                  String message = "Le fichier n'a pas pu etre téléchargé";
                  bool success = false;
                  if (File('$downloadPath/$name.pdf').existsSync()) {
                    success = true;
                  }
                  Scaffold.of(context).showSnackBar(
                      SnackBar(
                        content: Text( success ? "Fichier téléchargé" : message),
                        action: SnackBarAction(
                          label:  success ? 'Voir' : 'Annuler',
                          onPressed: () {
                            if(success){
                              actionIfSuccess("$downloadPath/$name.pdf");
                            }
                          },
                        ),
                      )
                  );
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: ScrollPhysics(),
              child: bodyData(),
            )
          ],
        ),

      ),
      drawer: CustomDrawer(context, "/validation"),
    );
  }
  actionIfSuccess(String path){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ViewerScreen(path),
      ),
    );
  }

  Widget bodyData() => DataTable(
      onSelectAll: (b) {},
      sortColumnIndex: 1,
      sortAscending: true,
      columns: <DataColumn>[
        DataColumn(
          label: Text("First Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.firstName.compareTo(b.firstName));
            });
          },
        ),
        DataColumn(
          label: Text("Last Name"),
          numeric: false,
          onSort: (i, b) {
            print("$i $b");
            setState(() {
              names.sort((a, b) => a.lastName.compareTo(b.lastName));
            });
          },
        ),
      ],
      rows: names
          .map(
            (name) => DataRow(
          cells: [
            DataCell(
              Text(name.firstName),
              showEditIcon: false,
              placeholder: false,
            ),
            DataCell(
              Text(name.lastName),
              showEditIcon: false,
              placeholder: false,
            )
          ],
        ),
      )
          .toList());


}

class Name {
  String firstName;
  String lastName;

  Name({this.firstName, this.lastName});
}

var names = <Name>[
  Name(firstName: "Pawan", lastName: "Kumar"),
  Name(firstName: "Aakash", lastName: "Tewari"),
  Name(firstName: "Rohan", lastName: "Singh"),
];





Future<String> createDir() async{
  Permission.storage.request();
  String path = "UacMobile";
  var dir = new Directory("storage/emulated/0/$path");
  if ( await dir.exists()){
      path= dir.path;
  }else{
    dir.create().then((Directory directory) {
      path = directory.path;
    });
  }
  print("Dir path: "+path);
  return path;
}
