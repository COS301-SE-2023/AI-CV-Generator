import 'package:ai_cv_generator/pages/util/fileView.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';

import 'package:flutter/painting.dart' as paint;
import 'dart:math' as math;

class CVHistory extends StatefulWidget {
  final BuildContext context;
  final Axis axis;
  final List<Widget>? list;
  const CVHistory({super.key, required this.context, this.list, required this.axis});

  @override
  CVHistoryState createState() => CVHistoryState();
}

class CVHistoryState extends State<CVHistory> {
  List<Widget> list = [];

  @override
  void initState() {
    FileApi.getFiles().then((value) {
      for (var element in value!) {
        paint.ImageProvider prov = paint.MemoryImage(element.cover);
        list.add(add(element.filename,prov));
      }
        setState(() {
      });
    });
    super.initState();
  }

  Widget add(String filename,paint.ImageProvider prov) {
    return InkWell(
        onTap: ()  {
          FileApi.requestFile(filename: filename).then((value) {
            showDialog(
              context: widget.context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  child: FileView(file: value,)
                );
            });
          });

        },
        child: RotatedBox(
            quarterTurns: 2,
            child: 
            Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(math.pi),
              child: Image(
                image: ResizeImage(
                  prov,
                  width: 595~/2.5,
                  height: 841~/2.5
                )
              ),
            )
             
          ),
    );
  }
  @override
  Widget build(BuildContext context) {
    if (widget.list != null) {
      list = widget.list!;
    }
    return Container(
      child: 
      list.isNotEmpty ?
      SingleChildScrollView(
        scrollDirection: widget.axis,
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
                 Icon(Icons.insert_drive_file,color: Colors.grey,size: 100,),
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