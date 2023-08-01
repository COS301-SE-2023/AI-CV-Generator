import 'package:ai_cv_generator/pages/widgets/pdf_window.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';

class CVHistory extends StatefulWidget {
  final BuildContext context;
  List<Widget>? list;
  CVHistory({super.key, required this.context, this.list});

  @override
  CVHistoryState createState() => CVHistoryState();
}

class CVHistoryState extends State<CVHistory> {
  List<Widget> list = [];

  @override
  void initState() {
    FileApi.getFiles().then((value) {
      for (var element in value!) {
        list.add(add(element.filename));
      }
        setState(() {
      });
    });
    super.initState();
  }

  Widget add(String filename,) {
    return OutlinedButton(
        onPressed: ()  {
          FileApi.requestFile(filename: filename).then((value) {
            showDialog(
              context: widget.context,
              builder: (context) {
                return Dialog(
                  child: PdfWindow(file: value,)
                );
            });
          });

        },
        child: Text(filename),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (widget.list != null) {
      list = widget.list!;
    }
    return Container(
      child: 
      list.length > 0 ?
      SingleChildScrollView(
        child: Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              ...list,
            ], 
        ) 
      ) : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Icon(Icons.access_alarm,color: Colors.grey,size: 100,),
                 SizedBox(height: 20),
                Text("No CVs...", 
                style: TextStyle(
                  color: Colors.grey
                )
                ),
              ],
            ),
          )
      
    );
  }
}