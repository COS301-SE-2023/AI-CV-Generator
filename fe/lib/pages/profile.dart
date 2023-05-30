import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(42),
      child:
        Expanded(
          child:
            Row(
              children: [
                Expanded(
                  child: 
                    Column(

                    )
                ),
                Expanded(
                  child: 
                    Column(

                    )
                ),
              ],
            )
        )
      );
  }
}

class PersonalDetails extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class PersonalDetailsState extends State<PersonalDetails> {
  Widget build(BuildContext context) {
    return Text("");
  }
}