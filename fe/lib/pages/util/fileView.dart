import 'package:ai_cv_generator/pages/widgets/buttons/downloadButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/shareButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class FileView extends StatelessWidget {
  const FileView({super.key, this.file});
  final PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    return SizedBox(
      width: 37*w,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            icon: const Icon(Icons.arrow_back,color: Colors.white,)
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(w*1),
                width: 32*w,
                height: 85*h,
                child: SfPdfViewer.memory(
                  file!.bytes!,
                  pageSpacing: 8
                ),
              ),
              Container(
                padding: EdgeInsets.all(w*0.1),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: h*1
                      ),
                      child: DownloadButton(file: file,),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: h*1
                      ),
                      child: ShareButton(file: file,),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
}