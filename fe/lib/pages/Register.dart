import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:flutter/material.dart';
 
class RegisterPage extends StatelessWidget {
  const  RegisterPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back,color: Colors.black,)
        ),
      ),
        body: const MyStatefulWidget(),
    );
  }
}
 
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);
 
  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}
 
class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetypeController = TextEditingController();
  
  bool error = false;
  Color? p2textColor;
 
  @override
  Widget build(BuildContext context) {
    TextEditingController errorMessage = TextEditingController(text: "Error");
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Image(
                  image: ResizeImage(
                    AssetImage('assets/images/logo.png'),
                    width:175,
                    height:175
                    ),
                  )
                ),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: const Text(
                  'Register',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('fname'),
                controller: fnameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'First Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('lname'),
                controller: lnameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Last Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('username'),
                controller: nameController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'User Name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('password'),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  if (passwordRetypeController.text != passwordController.text) {
                    setState(() {
                      p2textColor = const Color.fromRGBO(250, 0, 0, 0.466);
                      errorMessage.text = "Password does not match";
                      error = true;
                    });
                    
                  } else {
                    setState(() {
                      p2textColor = null;
                      error = false;
                    });
                  }
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('passwordretype'),
                obscureText: true,
                controller: passwordRetypeController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: p2textColor??const Color(0xFF000000),
                      width: 1.0
                    )
                  ),
                  labelText: 'Retype Password',
                  labelStyle: TextStyle(
                    color: p2textColor
                  )
                ),
                onChanged: (value) {
                  if (passwordRetypeController.text != passwordController.text) {
                    setState(() {
                      p2textColor = const Color.fromRGBO(250, 0, 0, 0.466);
                      errorMessage.text = "Password does not match";
                      error = true;
                    });
                  } else {
                    setState(() {
                      p2textColor = null;
                      error = false;
                    });
                  }
                },
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(600, 0, 600, 0),
                child: ElevatedButton(
                  key: const Key('register'),
                  child: const Text('Register'),
                  onPressed: () async {
                    if (passwordController.text != passwordRetypeController.text) {
                      setState(() {
                        errorMessage.text = "Password does not match";
                        error = true;
                      });
                      return;
                    }
                    String? resp = await userApi.register(username: nameController.text,password: passwordController.text,fname: fnameController.text,lname: lnameController.text);
                    if (resp!= null && resp == "1") {
                      error = false;
                      Navigator.pushNamed(context, '/home');
                    } else if (resp != null) {
                      setState(() {
                        errorMessage.text = "Invalid username or password";
                        error = true;
                      });
                    } else {
                      setState(() {
                        errorMessage.text = "Error occurered when registering";
                        error = true;
                      });
                    }
                  },
                )
            ),
            error ?
             Center(child: Text(
              errorMessage.text,
              style: const TextStyle(
              color: Colors.red,
              backgroundColor: Color.fromARGB(0, 186, 40, 40)
            ),)) : const Text(""),
          ],
        ));
  }
}