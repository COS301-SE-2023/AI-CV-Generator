
import 'package:ai_cv_generator/pages/generatedCV.dart';
import 'package:ai_cv_generator/pages/createPage.dart';
import 'package:ai_cv_generator/pages/navdrawer.dart';
import 'package:flutter/material.dart';
import '../models/user/UserModel.dart';
import 'profile.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
        actions: [

          Transform.scale(
            scale: 0.8,
            child: SizedBox(
              width: 400,
              child: SearchBar(
                controller: searchC,
                leading: IconButton(
                  icon: const Icon(
                    color: Colors.black,
                    Icons.search,
                    ),
                  onPressed: () => {
                    print(searchC.text)
                  },
                ),
                onChanged: (value)=>{
                  print(value)
                } ,
              ),
            ),
          ),

          IconButton(
            onPressed: () async {
              UserModel? mode = await userApi.getUser();
              if (mode != null) {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (c)=>  Profile(model: mode,))
              );
              }
            }, 
            icon: const Icon(Icons.account_circle)
            ),
        
        ],
      ),
      body: const Center(
        child: Row(
          children: [
            Expanded(child: createPage()),
            Expanded(child: GeneratedCV())
          ],
        ),
      ),
    );
  }
}

