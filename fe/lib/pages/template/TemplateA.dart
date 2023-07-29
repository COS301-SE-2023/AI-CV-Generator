import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

// Ui counter part for pdf
class TemplateA extends StatefulWidget {
  const TemplateA({super.key});

  @override
  State<StatefulWidget> createState() => TemplateAState();
}

class TemplateAState extends State<TemplateA> {
  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}

// Pdf
class TemplateAPdf {
  final pdf = pw.Document();
  final double fontText = 13;
  final double fontHeading = 24;
  final double fontSubHeading = 16;
  final pw.Widget relatedSpacing = pw.SizedBox(height: 8);
  final pw.Widget unRelatedSpacing = pw.SizedBox(height: 16);

  void writeOnPdf() async {

  }
}