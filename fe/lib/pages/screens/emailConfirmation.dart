import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:flutter/material.dart';

class EmailConfirmationArguments{
  String email;
  String username;
  String password;
  String fname;
  String lname;
  EmailConfirmationArguments({
    required this.email,
    required this.username,
    required this.password,
    required this.fname,
    required this.lname
  });
}

class EmailConfirmation extends StatelessWidget {
  const  EmailConfirmation({Key? key}) : super(key: key);
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
  
  bool error = false;
  Color? p2textColor;

  void backToLogin() {
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }
 
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EmailConfirmationArguments;
    return Scaffold(
          body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                child: const Image(
                  image: ResizeImage(
                    AssetImage('assets/images/logo.png'),
                    width:350,
                    height:350
                    ),
                  )
                ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "An email has been sent to ${args.email}",
                  style: const TextStyle(
                    color: Color(0xFFEA6D79),
                    fontSize: 20
                  ),
                ),
                const Text(
                  "Please check your email to verify your account to continue",
                  style: TextStyle(
                    color: Color(0xFFEA6D79),
                    fontSize: 20
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () {
                          AuthApi.register(username: args.username, password: args.password, email: args.email, fname: args.fname, lname: args.lname);
                        }, 
                        child: const Text(
                          "Resend Email",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(30),
                      child: ElevatedButton(
                        onPressed: () {
                          backToLogin();
                        }, 
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.white
                          ),
                        )
                      ),
                    )
                  ],
                )
                
              ],
            ),
          ],
      ));
  }
}