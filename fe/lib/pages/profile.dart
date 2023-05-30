import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(42),
      child:
        Expanded(
          child:
            Row(
              children: [
                Expanded(
                  child: 
                    Column(

                    ),
                ),
                Expanded(
                  child: 
                    Column(
                      children: [
                        PersonalDetails(),
                        PersonalDetails(),
                      ],
                    ),
                ),
              ],
            )
        )
      );
  }
}

class PersonalDetails extends StatefulWidget {
  @override
  PersonalDetailsState createState() => PersonalDetailsState();
}

class PersonalDetailsState extends State<PersonalDetails> {
  String name = "default";
  String location = "default";
  String email = "default";
  String phoneNumber = "default";
  TextAlign textAlign = TextAlign.right;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: 
        Column(
          children: [
            Text(name, textAlign: textAlign,),
            Text(name, textAlign: textAlign,),
            Text(name, textAlign: textAlign,),
            Text(name, textAlign: textAlign,),
          ]
        ),
    );
  }
}