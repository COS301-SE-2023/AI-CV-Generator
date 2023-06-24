
import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/pages/pdfWinLink.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';


class createPage extends StatefulWidget {
  const createPage({super.key});
  @override
  _createPageState createState() => _createPageState();
}

class _createPageState extends State<createPage> {
  Map data = {};
  PlatformFile? file;
  bool fileAvail = false;
  bool linkFile = false;
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (fileAvail == false)
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: OutlinedButton(
                      onPressed: () async {
                          final fi = await pdfAPI.pick_cvfile();
                          if (fi == null) return;
                          
                          
                          setState(() {
                              file = fi;
                              fileAvail = true;
                          });
                      }, 
                      child: const Text("Upload")
                    )
                  ),
                  // Container(
                  //   padding: const EdgeInsets.all(10.0),
                  //   child: OutlinedButton(
                  //     onPressed: () async {
                  //       UserModel? model = await userApi.getUser(id: id);
                  //       print(model == null);
                  //     }, 
                  //     child: const Text("Test Button")
                  //   ) 
                  // ),
                ]
              ),
              fileAvail == true ?
              Expanded(
                child: 
                linkFile == false ?
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Scaffold(
                    appBar: AppBar(
                      actions: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                                setState(() {
                                  file = null;
                                  fileAvail = false;
                                });
                            },
                          )
                      ],
                      leading: IconButton(
                        icon: const Icon(Icons.upload),
                        onPressed: () {
                          if (file == null) {return;}
                            FileApi.uploadFile(file: file);

                          setState(() {
                            fileAvail = true;
                            linkFile = true;
                          });
                        },
                      ),
                      backgroundColor: Colors.blueGrey[900],
                    ),
                    body: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blueGrey,
                            width: 1
                          )
                        ),
                        child: PdfWindow(file: file),
                    )
                  ),
                ) : pdfWinLink(file: file,)
              ) : const Text("")
          ],
        )
      )
    );
  }
  void openFile(PlatformFile? f,BuildContext c) => Navigator.of(c).push(
    MaterialPageRoute(builder: (c)=> PdfWindow(key:null,file: f,))
  );
}