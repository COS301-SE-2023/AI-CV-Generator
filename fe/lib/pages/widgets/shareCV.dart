import 'package:ai_cv_generator/api/downloadService.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void shareCVModal(BuildContext context,PlatformFile? f) {
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
                        requirementsforshare(context, file);
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

void requirementsforshare(BuildContext context, PlatformFile? file) {

  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return Dialog(
        child: ShareWidget(file: file,)
      );
    }
  );
}

// ignore: must_be_immutable
class ShareWidgetTest extends StatefulWidget {
  ShareWidgetTest({
    super.key,
    this.file
  });

  PlatformFile? file;

  @override
  State<StatefulWidget> createState() => ShareWidgetTestState();

}

class ShareWidgetTestState extends State<ShareWidgetTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: ShareWidget(file: widget.file),
    );
  }
}

// ignore: must_be_immutable
class ShareWidget extends StatefulWidget {
  ShareWidget({super.key, required this.file});
  PlatformFile? file;
  @override
  State<StatefulWidget> createState() => ShareWidgetState();
}

class ShareWidgetState extends State<ShareWidget> {
  TextEditingController nameC = TextEditingController();
  TextEditingController timeInput = TextEditingController(text: '1');
  DateTime date = DateTime.now();
  final List<String> _dropdownItems = [
    '1',
    '2',
    '4',
    '8',
    '16',
    '24'
  ];
  back() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 220,
        width: 400,
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              Container(
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.grey.shade100
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Hours: '),
                    DropdownButton<String>(
                      value: timeInput.text,
                      onChanged: (String? newValue) {
                        timeInput.text = newValue??'0';
                        date = DateTime.now();
                        date.add(Duration(hours: int.parse(timeInput.text)));
                        setState(() {
                          
                        });
                      },
                      items: _dropdownItems.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8.0,),
              InkWell(
                onTap: () async {
                  String name = nameC.text.replaceAll(" ", "_");
                  PlatformFile file = PlatformFile(name: '$name.pdf', size: widget.file!.bytes!.length,bytes: widget.file!.bytes);
                  String linkToCV = await FileApi.generateUrlFromNewFile(file: file,hours: int.parse(timeInput.text));
                  Clipboard.setData(ClipboardData(text: linkToCV));
                  back();
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.link,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8.0),
                    Text(
                      'Copy Link',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Theme.of(context).colorScheme.primary
                        ),
                    ),
                  ]
                )
              )
            ],
          )
          )
        )
      )
    );
  }

}

