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
                      children: [
                        AboutMe(),
                      ],
                    ),
                ),
                Expanded(
                  child: 
                    Column(
                      children: [
                        PersonalDetails(),
                        Education(),
                        Links(),
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
        Align(
          alignment: Alignment.centerRight,
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(name, textAlign: textAlign, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 3.0),),
                Text(location, textAlign: textAlign,),
                Text(email, textAlign: textAlign,),
                Text(phoneNumber, textAlign: textAlign,),
              ]
            ),
        )
    );
  }
}

class Education extends StatefulWidget {
  @override
  EducationState createState() => EducationState();
}

class EducationState extends State<Education> {
  String institution = "default";
  String degree = "default";
  TextAlign textAlign = TextAlign.right;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
        Align(
          alignment: Alignment.centerRight,
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(institution, textAlign: textAlign, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
                Text(institution, textAlign: textAlign, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),),
                Text(degree, textAlign: textAlign,),
                DateField(),
              ],
            ),
        ),
    );
  }
}

class DateField extends StatefulWidget {
  @override
  DateFieldState createState() => DateFieldState();
}

class DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return Align(
            alignment: Alignment.centerRight,
            child:
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(width: 40, child: TextField(),),
                  Text("-",),
                  SizedBox(width: 40, child: TextField(),),
                ],
              ),
          );
    }
}

class Links extends StatefulWidget {
  @override
  LinksState createState() => LinksState();
}

class LinksState extends State<Links> {
  String github = "default";
  String behance = "default";
  String dribbble = "default";
  TextAlign textAlign = TextAlign.right;
  
  @override
  Widget build(BuildContext context) {
    return Align(
            alignment: Alignment.centerRight,
            child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("default", textAlign: textAlign, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
                  Text(github, textAlign: textAlign,),
                  Text(behance, textAlign: textAlign,),
                  Text(dribbble, textAlign: textAlign,),
                ]
              ),
            );
  }
}

class AboutMe extends StatefulWidget {
  @override
  AboutMeState createState() => AboutMeState();
}

class AboutMeState extends State {
  TextAlign textAlign = TextAlign.left;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: 
        Align(
          alignment: Alignment.centerLeft,
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("default", textAlign: textAlign, style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
                TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 5,
                ),
              ]
            ),
        )
    );
  }
}