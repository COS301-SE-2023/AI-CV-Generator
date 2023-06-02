
import 'package:ai_cv_generator/pages/generatedCV.dart';
import 'package:ai_cv_generator/pages/createPage.dart';
import 'package:flutter/material.dart';
import '../models/user/UserModel.dart';
import 'profile.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';

class Home extends StatefulWidget {
  Home({super.key,required this.id});

  String id;

  @override
  _HomeState createState() => _HomeState(id:id);
}

class _HomeState extends State<Home> {
  Map data = {};
  String id;
  _HomeState({
    required this.id
  });
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => {

            },
          ),
        actions: [
          IconButton(
            onPressed: () async {
              UserModel? mode = await userApi.getUser(id: id);
              if (mode != null) {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (c)=>  Profile(id: id,model: mode,))
              );
              }
            }, 
            icon: const Icon(Icons.account_circle)
            )
        ],
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(child: createPage(id:id)),
            const Expanded(child: generatedCV())
          ],
        ),
      ),
    );
  }
}
