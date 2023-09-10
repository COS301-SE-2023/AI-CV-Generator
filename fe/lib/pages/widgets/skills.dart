// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/widgets/references.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:flutter/material.dart';

class SkillsForm extends StatefulWidget {
  const SkillsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SkillsFormState();
  }
}

class _SkillsFormState extends State<SkillsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController skill1 = TextEditingController();
  TextEditingController skill2 = TextEditingController();
  TextEditingController skill3 = TextEditingController();
  TextEditingController skill4 = TextEditingController();
  TextEditingController skill5 = TextEditingController();
  
  Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsSkill.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ), 
          onPressed: () async { 
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(height: 64,),
          titleSection,
          Center ( 
            child: Container ( 
            padding: const EdgeInsets.all(25.0),
            child: _buildForm(),
            ),
        ),
        const SizedBox(height: 64,),
        Center (
          child: Container ( 
            padding: const EdgeInsets.all(20.0),
            child: _buildAddButton(),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 140,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showQuestionaireModal(context, EmploymentDetailsForm());
                  },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    child: const Text('Back'),
                )
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 140,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showQuestionaireModal(context, const ReferencesForm());
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(10.0),
                    ),
                    child: const Text('Save & Proceed'),
                )
              ),
            ),
          ],
        ),
        ],
      ),
    );
  }


  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildSkillField1(),
            _buildSkillField2(),
            _buildSkillField3(),
          ],
        ));
  }

  Widget _buildSkillField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key('Skill1'),
        controller: skill1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Skill 1',
          enabledBorder: OutlineInputBorder(),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  Widget _buildSkillField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key('Skill2'),
        controller: skill2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Skill 2',
          enabledBorder: OutlineInputBorder(),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  Widget _buildSkillField3() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key('Skill3'),
        controller: skill3,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Skill 3',
          enabledBorder: OutlineInputBorder(),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }

  Widget _buildAddButton() {
    return ElevatedButton(
        onPressed: () {
            _submitAdd();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(10.0),
          ),
          child: const Icon(Icons.add),
      );
  }


  Widget _buildBackButton() {
    return SizedBox(
      width: 140,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitBack();
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(10.0),
          ),
          child: const Text('Back'),
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
          child: const Text('Save & Proceed'),
      )
    );
    
  }

  void _submitAdd() {
    //
  }

  void _submitBack() {
    Navigator.pushNamed(context, "/employmentdetails");
  }

  void _submitForm() {
    Navigator.pushNamed(context, "/references");
  }
}