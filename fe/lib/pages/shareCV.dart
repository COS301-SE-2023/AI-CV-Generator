import 'package:ai_cv_generator/api/DownloadService.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

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
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        DownloadService.download(file!.bytes!.toList(), downloadName: file.name);
                      },
                      child: const Text('Export to PDF'),
                    ),
                    const SizedBox(width: 16,),
                
                    ElevatedButton(
                      onPressed: () {
                        RequirementsForShare(context, file);
                      }, 
                      child: const Text("Share via Link")
                    )
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

void RequirementsForShare(BuildContext context, PlatformFile? file) {
  TextEditingController nameC = TextEditingController();
  TextEditingController timeInput = TextEditingController();
  PlatformFile? fi = file;
  DateTime date = DateTime.now();

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
                  'Specify Name and Time',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: nameC,
                  decoration: const InputDecoration(
                    labelText: "Enter Name for file",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 8.0,),
                TextField(
                  controller: timeInput,
                  decoration: const InputDecoration( 
                   icon: Icon(Icons.timer), //icon of text field
                   labelText: "Enter Time" //label text of field
                  ),
                  onTap: () async {
                    TimeOfDay? pickedTime =  await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                        );
                    
                    if(pickedTime != null ){
                        print(pickedTime.format(context));   //output 10:51 PM
                        DateTime parsedTime = DateFormat.jm().parse(pickedTime.format(context).toString());
                        //converting to DateTime so that we can further format on different pattern.
                        print(parsedTime); //output 1970-01-01 22:53:00.000
                        String formattedTime = DateFormat('dd:HH:mm:ss').format(parsedTime);
                        print(formattedTime); //output 14:59:00
                        //DateFormat() is from intl package, you can format the time on any pattern you need.
                        date = parsedTime;
                        timeInput.text = formattedTime;
                    }else{
                        print("Time is not selected");
                    }
                  }
                ),
                const SizedBox(height: 8.0,),
                InkWell(
                      onTap: () async {
                        Duration duration = DateTime.now().difference(date);
                        if (file!.name != null) {
                          file = PlatformFile(name: nameC.text+".pdf", size: file!.bytes!.length,bytes: file?.bytes);
                        }
                        await FileApi.uploadFile(file: file);
                        String linkToCV = await FileApi.generateUrl(filename: file!.name,duration: duration);
                        Clipboard.setData(ClipboardData(text: linkToCV));
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.link),
                          SizedBox(width: 8.0),
                          Text(
                            'Copy Link',
                            style: TextStyle(fontSize: 16.0),
                          ),
                        ]
                      )
                )
              ],
            )
          )
        ),
      );
    }
  );
}

