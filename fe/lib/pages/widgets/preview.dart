// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render_widgets.dart';

void main () => runApp(const Preview());

class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: StringsSkill.appBarTitle,
      home: PreviewForm(),
    );
  }
}

class PreviewForm extends StatefulWidget {
  const PreviewForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PreviewFormState();
  }
}

class _PreviewFormState extends State<PreviewForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController skill1 = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(StringsSkill.appHeadingTitle),
      ),
      body: ListView(
        children: [
          titleSection,
          Center (
            child: _buildForm(),
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: _buildBackButton(),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: _buildSubmitButton(),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: _buildExportButton(),
            ),
          ],
        ),
        ],
      ),
    );
  }

  Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsPreview.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
    );


  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              _buildPreview(),
          ],
        ),
    );
  }

  Widget _buildPreview() {
    return SizedBox(
      width: 600.0,
      height: 800.0,
      child: PdfViewer.openAsset('assets/Resume 1.pdf'),
    );
  }
   

  Widget _buildBackButton() {
    return SizedBox(
      width: 30,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitBack();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(3.0),
          ),
          child: const Icon(Icons.arrow_back),
      )
    );
  }


  Widget _buildSubmitButton() {
    return SizedBox(
      width: 140,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitForm();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10.0),
          ),
          child: const Text('Save'),
      )
    );
    
  }

  Widget _buildExportButton() {
    return SizedBox(
      width: 140,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            //shareCVModal(context, f);
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10.0),
          ),
          child: const Text('Export'),
      )
    );
    
  }

  void _submitBack() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ReferencesForm()));
  }


  void _submitForm() {
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const References()));*/
  }
}