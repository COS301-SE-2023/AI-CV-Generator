import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class pdfWinLink extends StatefulWidget{
    final PlatformFile? file;
    const pdfWinLink(
    {
      Key? key,
      this.file,
    }
    ) : super(key: key);

    @override
    _pdfWinLinkState createState() => _pdfWinLinkState();
}

class _pdfWinLinkState extends State<pdfWinLink> {
    @override
    Widget build(BuildContext context) {
        String? filename = "Unavailable!";
        PlatformFile? file = widget.file;
        if (file != null && file.name != null)
          filename = file.name;
        return Scaffold(
          body: ElevatedButton(onPressed:() => {}, child: Text(filename)),
        );
    }
}