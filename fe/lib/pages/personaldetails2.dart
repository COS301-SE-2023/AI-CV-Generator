// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/qualifications2.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp( const PersonalDetails());

class PersonalDetails extends StatelessWidget {
  const PersonalDetails({super.key});
  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: PersonalDetailsForm(),
    );
  }

  bool addDetails(String s, String t, String u, int i, String v) 
  {
    return true;
  }
}

Future<UserModel?> getUser() async {
  return await userApi.getUser();
}

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PersonalDetailsFormState();
  }
}

class _PersonalDetailsFormState extends State<PersonalDetailsForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cell = TextEditingController();
  TextEditingController address = TextEditingController();
  UserModel? user;
  void updateUser() async {
    user!.fname = fname.text;
    user!.lname = lname.text;
    user!.email = email.text;
    user!.phoneNumber = cell.text;
    user!.location = address.text;
    await userApi.updateUser(user: user!);
  }

  void getUser() async {
    user = await userApi.getUser();
    fname.text = user!.fname;
    lname.text = user!.lname;
    email.text = user!.email!;
    cell.text = user!.phoneNumber!;
    address.text = user!.location!;
  }


  @override
  Widget build(BuildContext context) {
    getUser();
    

    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(StringsPersonal.appHeadingTitle),
      ),
      body: ListView(
        children: [
          titleSection,
          Center ( 
            child: Container ( 
            padding: const EdgeInsets.all(25.0),
            child: _buildForm(),
            ),
        ),
        Center (
          child: Container(
              padding: const EdgeInsets.all(4.0),
              child: SizedBox(
                width: 150,
                height: 30,
                child: ElevatedButton(
                  onPressed: () async {
                      updateUser();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QualificationsDetailsForm()));
                    },
                    child: const Text('Save & Proceed'),
                )
              ),
            )
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
              StringsPersonal.appsubHeadingTitle,
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
            _buildNameField(),
            _buildLastNameField(),
            _buildEmailField(),
            _buildCellField(),
            _buildAddrField(),
          ],
        ));
  }

  Widget _buildNameField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Name input"),
        controller: fname,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'First Name',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.person),
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

  Widget _buildLastNameField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Last Name input"),
        controller: lname,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Last Name',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.person),
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

  Widget _buildEmailField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Email input"),
        controller: email,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Email',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.email),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
          .hasMatch(value!)) {
            return 'This is not a valid email';
          }
        },
      )
    );
  }

  Widget _buildCellField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Cell input"),
        controller: cell,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Contact Number',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.phone),
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

  Widget _buildAddrField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Address input"),
        controller: address,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Address',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.home),
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

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 150,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitForm();
          },
          child: const Text('Save & Proceed'),
      )
    );
    
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const QualificationsDetailsForm()));
  }
}