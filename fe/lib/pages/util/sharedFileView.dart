import 'package:ai_cv_generator/dio/client/shareClient.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/downloadButton.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SharedFileView extends StatefulWidget {
  const SharedFileView({super.key,required this.uuid});
  final String uuid;
  
  @override
  State<StatefulWidget> createState() => SharedFileViewState();
}

class SharedFileViewState extends State<SharedFileView> {

  // Error/Success Messaging
  showError(String message) {
    showMessage(message, context);
  }

  showSuccess(String message) {
    showHappyMessage(message, context);
  }
  
  toLogin() {
    Navigator.popAndPushNamed(context, '/');
  }

  PlatformFile? file;
  @override
  void initState() {
    ShareApi.retrieveFile(uuid: widget.uuid).then((value) {
      file = value;
      setState(() {
        
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (file == null) {
      return const LoadingScreen();
    }
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        width: w*100,
        height: h*100,
        decoration: BoxDecoration(
          color: Colors.grey.shade800
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(w*1),
                width: 32*w,
                height: 92*h,
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