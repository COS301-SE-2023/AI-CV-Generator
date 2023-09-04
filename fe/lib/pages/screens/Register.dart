import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/screens/emailConfirmation.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
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
            Navigator.popAndPushNamed(context,'confirm');
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
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetypeController = TextEditingController();

  void confirm() {
    Navigator.pushNamed(
      context, '/confirm',
      arguments: EmailConfirmationArguments(
        email: emailController.text,
        username: nameController.text
      )
    );
  }

   TextEditingController errorMessage = TextEditingController(text: "Error");
    Stream<String> sampleListener(TextEditingController controller) async* { // <- here
      while (true) {
        await Future.delayed(const Duration(milliseconds: 10));
        yield controller.value.text;
      }
    } 
    
  
  bool error = false;
  bool wait = false;
  Color? p2textColor;
  Color? userNameAndPwordError;
 
  @override
  Widget build(BuildContext context) {
    if (wait) {
      return const LoadingScreen();
    }
    return Scaffold(
          body: Column(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
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
         
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 10, 5, 10),
                    width: 267.5,
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
                    padding: const EdgeInsets.fromLTRB(5, 10, 0, 10),
                    width: 267.5,
                    child: TextField(
                      key: const Key('lname'),
                      controller: lnameController,
                      decoration: const InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        labelText: 'Last Name',
                      ),
                    ),
                  )
                  
                ],
              ),
            
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('username'),
                controller: nameController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: userNameAndPwordError??const Color(0xFF000000),
                      width: 1.0
                    )
                  ),
                  labelText: 'User Name',
                ),
                onChanged: (value) {
                  error = false;
                  userNameAndPwordError=null;
                  p2textColor = null;
                  setState(() {
                    
                  });
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('email'),
                controller: emailController,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(),
                  labelText: 'Email',
                ),
                
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('password'),
                obscureText: true,
                controller: passwordController,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: userNameAndPwordError??const Color(0xFF000000),
                      width: 1.0
                    )
                  ),
                  labelText: 'Password',
                ),
                onChanged: (value) {
                  if (passwordRetypeController.text != passwordController.text) {
                    setState(() {
                      p2textColor = const Color.fromRGBO(250, 0, 0, 0.466);
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
                      errorMessage.text = "Password does not match";
                      setState(() {
                        p2textColor = const Color.fromRGBO(250, 0, 0, 0.466);
                        error = true;
                      });
                      return;
                    }
                    wait = true;
                    setState(() {
                      
                    });
                    Code code = await AuthApi.register(username: nameController.text,password: passwordController.text,email: emailController.text,fname: fnameController.text,lname: lnameController.text);
                    wait = false;
                    setState(() {
                      
                    });
                    if (code == Code.success) {
                      error = false;
                      setState(() {
                        
                      });
                      confirm();
                    } else if (code == Code.failed) {
                      setState(() {
                        errorMessage.text = "Username already Exists";
                        p2textColor = userNameAndPwordError = const Color.fromRGBO(250, 0, 0, 0.466);
                        error = true;
                      });
                    } else {
                      setState(() {
                        errorMessage.text = "Invalid Username or Password";
                        p2textColor = userNameAndPwordError = const Color.fromRGBO(250, 0, 0, 0.466);
                        error = true;
                      });
                    }
                  },
                )
            ),
            if (error)
             Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
                child: StreamBuilder<String>(
                  stream: sampleListener(errorMessage),
                  builder: (context, AsyncSnapshot<String> snapshot) {
                    if (snapshot.hasError || snapshot.data == null) {
                      return const Text(
                        "",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          backgroundColor: Color.fromARGB(0, 186, 40, 40)
                        ),
                      );
                    } else {
                      return Text(
                        snapshot.data as String,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          backgroundColor: Color.fromARGB(0, 186, 40, 40)
                        ),
                      );
                    }
                  }
                )
              )
            )
          ],
      ));
  }
}