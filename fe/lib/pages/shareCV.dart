import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void shareCVModal(BuildContext context) {
  TextEditingController emailC = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: FractionallySizedBox(
          widthFactor: 0.4,
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SHARE',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16.0),
                Text(
                  'EMAIL',
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 8.0),
                TextField(
                  controller: emailC,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'INSERT THE EMAIL ADDRESS TO SHARE WITH',
                  style: TextStyle(fontSize: 12.0),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        print(emailC.text);
                        Navigator.of(context).pop();
                      },
                      child: Text('Submit'),
                    ),
                    SizedBox(width: 16,),
                    InkWell(
                      onTap: () {
                        String linkToCV = 'insert CV URL here';
                        Clipboard.setData(ClipboardData(text: linkToCV));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //     content: Text('Copied'),
                        //   ),
                        // );
                      },
                      child: Row(
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

