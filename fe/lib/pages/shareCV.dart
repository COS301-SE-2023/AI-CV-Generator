import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void shareCVModal(BuildContext context,PlatformFile? f) {
  TextEditingController emailC = TextEditingController();
  PlatformFile? file = f;


  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'SHARE',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: emailC,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8.0),
                const Text(
                  'INSERT THE EMAIL ADDRESS TO SHARE WITH',
                  style: TextStyle(fontSize: 12.0),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      child: const Text('Export to PDF'),
                    ),
                    const SizedBox(width: 16,),
                    InkWell(
                      onTap: () async {
                        await FileApi.uploadFile(file: file);
                        DateTime now =  DateTime.now();
                        DateTime then = now.add(Duration(days: 	3));
                        String linkToCV = await FileApi.generateUrl(filename: file!.name,duration: Duration(days: 0,hours: 1));
                        Clipboard.setData(ClipboardData(text: linkToCV));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.link),
                          SizedBox(width: 8.0),
                          Text(
                            'Get Link',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

