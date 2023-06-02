import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  Profile({super.key,required this.id,required this.model});
  String id;
  UserModel model;


  @override
  ProfileState createState() => ProfileState(id:id,model: model);
}

bool isEditingEnabled = false;

class ProfileState extends State<Profile> {
  final _formKey = GlobalKey<FormState>();
  UserModel model;
  String id;

  ProfileState({
    required this.id,
    required this.model
  });

  @override
  Widget build(BuildContext context) {
    String email =  model.email != null ? model.email! : "No email...";
    String phoneNumber =  model.phoneNumber != null? model.phoneNumber!:"No phone number...";
    String location = model.location != null ? model.location!:"No location...";
    String aboutMe = model.description!= null? model.description!:"No description...";
    String workExperience = "";
    String education = "";
    final details = model.details;
    if (details != null) {
      for (int n=0; n <details.employhistory.employHis.length; n++) {
        workExperience += "${details.employhistory.employHis[n].company} ";
        workExperience += "${details.employhistory.employHis[n].title} ";
        workExperience += "${details.employhistory.employHis[n].start_date}-";
        workExperience += "${details.employhistory.employHis[n].end_date}\n";
      }
      if (details.employhistory.employHis.isEmpty) workExperience = "No Work expierience listed...";
      for (int n=0; n<details.qualifications.qualifications.length; n++) {
        education += "${details.qualifications.qualifications[n].qualification} ";
        education += "${details.qualifications.qualifications[n].instatution} ";
        education += "${details.qualifications.qualifications[n].date.toString()}\n";
      }
      if (details.qualifications.qualifications.isEmpty) education = "No education listed...";
    } else {
      education = "No education listed...";
      workExperience = "No Work expierience listed...";
    }

    String links = "";
    
    return Material(child:Padding(
      padding: const EdgeInsets.symmetric(vertical: 42, horizontal: 420),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const CircleAvatar(
                radius: 50,
                // backgroundImage: AssetImage(imagePath),
                backgroundColor: Colors.blue,
              ),
              const SizedBox(height: 16,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: OutlinedButton(
                  onPressed: () {
                    _formKey.currentState!.save();
                    setState(() {
                      isEditingEnabled = false;
                    });
                  }, 
                  child: const Text("SAVE")
                ) 
              ),
              const SizedBox(height: 8,),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: OutlinedButton(
                  onPressed: () {
                      setState(() {
                      isEditingEnabled = true;
                    });
                  }, 
                  child: const Text("EDIT")
                ) 
              ),
              const SizedBox(height: 16,),
              InputField(label: "NAME", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: model.fname, onSaved: (value)=>{model.fname=value!},)),
              const SizedBox(height: 16,),
              InputField(label: "EMAIL", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: email, onSaved: (value)=>{email=value!},)),
              const SizedBox(height: 16,),
              InputField(label: "PHONE NUMBER", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: phoneNumber, onSaved: (value)=>{phoneNumber=value!},)),
              const SizedBox(height: 16,),
              InputField(label: "LOCATION", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: location, onSaved: (value)=>{location=value!},)),
              const SizedBox(height: 16,),
              InputField(label: "ABOUT ME", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: aboutMe, onSaved: (value)=>{aboutMe=value!}, maxLines: 10,)),
              const SizedBox(height: 16,),
              InputField(label: "EDUCATION", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: education, onSaved: (value)=>{education=value!}, maxLines: 10,)),
              const SizedBox(height: 16,),
              InputField(label: "WORK EXPERIENCE", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: workExperience, onSaved: (value)=>{workExperience=value!}, maxLines: 10,)),
              const SizedBox(height: 16,),
              InputField(label: "LINKS", widgetField: TextFormField(enabled: isEditingEnabled, initialValue: links, onSaved: (value)=>{links=value!}, maxLines: 10,)),
              const SizedBox(height: 16,),
            ],
          )
        )
      ));
  }
}

class InputField extends StatefulWidget {
  final String label;
  final Widget widgetField;
  const InputField({super.key, required this.label, required this.widgetField});
  @override
  InputFieldState createState() => InputFieldState();
}

class InputFieldState extends State<InputField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          const SizedBox(height: 8,),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: widget.widgetField,
          )
        ],
      ),
    );
  }
}