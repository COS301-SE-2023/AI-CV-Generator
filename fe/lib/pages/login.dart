import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/pages/Register.dart';
import 'package:ai_cv_generator/pages/home.dart';
import 'package:flutter/material.dart';
 
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
 
  static const String _title = 'Sample App';
 
  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      title: _title,
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
 
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool Error = false;
 
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Image(image: ResizeImage(AssetImage('assets/images/logo.png'),width:350,height:350),)
                ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(600, 0, 600, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    bool resp = await userApi.login(username: nameController.text,password: passwordController.text);
                    if (resp) {
                      Error = false;
                      Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Home(id:"test_id")
                    ));
                    } else {
                      setState(() {
                        Error = true;
                      });
                    }
                  },
                )
            ),
            Error ?
            const Center(child: Text("Password or Email invalid",style: TextStyle(
              color: Colors.red,
              backgroundColor: Color.fromARGB(0, 186, 40, 40)
            ),)) : const Text(""),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Do not have an Account yet?'),
                TextButton(
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => const RegisterPage()
                    ));
                  },
                )
              ],
            ),
          ],
        )
      );
  }
}