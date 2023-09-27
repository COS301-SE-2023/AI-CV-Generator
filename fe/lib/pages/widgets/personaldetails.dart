// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';

class PersonalDetailsFormTest extends StatefulWidget{
  PersonalDetailsFormTest({super.key});

  @override
  State<StatefulWidget> createState() => PersonalDetailsFormTestState();
}

class PersonalDetailsFormTestState extends State<PersonalDetailsFormTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: PersonalDetailsForm(),
    );
  }
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

  @override
  void initState() {
    getUser();
    super.initState();
  }

  Future<bool> updateUser() async {
    Home.adjustedModel!.fname = fname.text;
    Home.adjustedModel!.lname = lname.text;
    Home.adjustedModel!.email = email.text;
    Home.adjustedModel!.phoneNumber = cell.text;
    Home.adjustedModel!.location = address.text;
    return _formKey.currentState!.validate();
  }

  getUser()  {
    fname.text = Home.adjustedModel!.fname;
    lname.text = Home.adjustedModel!.lname;
    email.text = Home.adjustedModel!.email?? "";
    cell.text = Home.adjustedModel!.phoneNumber?? "";
    address.text = Home.adjustedModel!.location?? "";
  }

  // navigation
  toNext() {
    showQuestionaireModal(context, const QualificationsDetailsForm());
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return Scaffold(
      drawer:  const NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ), 
          onPressed: () async { 
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: titleSection(w,h),
              ),
            ),
            Expanded(
              flex: 8,
              child: Container ( 
                padding: const EdgeInsets.all(16.0),
                child: _buildForm(),
              ),
            ),
            CustomizableButton(
              text: 'Save and Proceed', 
              width: w*10, 
              height: h*5, 
              onTap: () async {
                if(await updateUser() == false) {
                  return;
                }
                toNext();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(height: 6.4*h,),
          ],
        ),
      ),
    );
  }

  Widget titleSection(double w,double h) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(0.8*w),
            child: Text (
              StringsPersonal.appsubHeadingTitle,
              style: TextStyle (
                fontSize: w*h*0.2
              ),
          ),
        ),
      ],
    );
  }


  Widget _buildForm() {
  return SingleChildScrollView(
    child: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          _buildNameField(),
          const SizedBox(height: 8,),
          _buildLastNameField(),
          const SizedBox(height: 8,),
          _buildEmailField(),
          const SizedBox(height: 8,),
          _buildCellField(),
          const SizedBox(height: 8,),
          _buildAddrField(),
        ],
      ),
    ),
  );
}


  Widget _buildNameField() {
    return Container (
      constraints: BoxConstraints.tight( Size(550,70)),
      child: TextFormField(
        maxLength: 50,
        key: const Key("Name input"),
        controller: fname,
        decoration: const InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'First Name',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.person),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      )
    );
  }

  Widget _buildLastNameField() {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        maxLength: 50,
        key: const Key("Last Name input"),
        controller: lname,
        decoration: const InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Last Name',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.person),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      )
    );
  }

  Widget _buildEmailField() {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        maxLength: 25,
        key: const Key("Email input"),
        controller: email,
        decoration: const InputDecoration(
          counterText: "",
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
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        maxLength: 20,
        key: const Key("Cell input"),
        controller: cell,
        decoration: const InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Contact Number',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.phone),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      )
    );
  }

  Widget _buildAddrField() {
    return Container (
      constraints: BoxConstraints.tight(const Size(550,70)),
      child: TextFormField(
        maxLength: 50,
        key: const Key("Address input"),
        controller: address,
        decoration: const InputDecoration(
          counterText: "",
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'General Location',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.home),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
      )
    );
  }
}