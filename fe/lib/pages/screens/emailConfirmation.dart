import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:flutter/material.dart';

class EmailConfirmationArguments{
  String username;
  String password;
  EmailConfirmationArguments({
    required this.username,
    required this.password
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
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }

  TextEditingController errorMessage = TextEditingController(text: "Error");
  Stream<String> sampleListener(TextEditingController controller) async* { // <- here
    while (true) {
      await Future.delayed(const Duration(milliseconds: 10));
      yield controller.value.text;
    }
  }

 
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EmailConfirmationArguments;
    void confirm() {
      Navigator.popAndPushNamed(
        context, '/confirm',
        arguments: EmailConfirmationArguments(
          username: args.username,
          password: args.password
        )
      );
    }
    return Scaffold(
          body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 30, 100, 10),
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
                  "An email has been sent to your email account",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Text(
                  "Please check your email to verify your account to continue",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(40),
                      child: ElevatedButton(
                        onPressed: () async {
                          //Code code = await AuthApi.register(username: args.username, password: args.password, email: args.email, fname: args.fname, lname: args.lname);
                          Code code = await AuthApi.resendEmail(username: args.username, password: args.password);
                          if (code == Code.success) {
                            error = false;
                            confirm();
                          } else {
                            error = true;
                            errorMessage.text = "Unknown error accured!";
                            setState(() {
                              
                            });
                          }
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
                      padding: const EdgeInsets.all(40),
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
                )
                
              ],
            ),
          ],
      ));
  }
}