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
    Navigator.popAndPushNamed(context, "/");
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
                Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Check your inbox", style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.primary),),
                      SizedBox(width: 16,),
                      Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Click on the link in the email to complete the verification process", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(
                height: 8,
              ),
                Column(
                  children: [
                    Container(
                      child: TextButton(
                        onPressed: () async {
                          //Code code = await AuthApi.register(username: args.username, password: args.password, email: args.email, fname: args.fname, lname: args.lname);
                          Code code = await AuthApi.resendEmail(username: args.username, password: args.password);
                          if (code == Code.success) {
                            error = false;
                            confirm();
                          } else {
                            error = true;
                            errorMessage.text = "Unknown error occurred!";
                            setState(() {
                              
                            });
                          }
                        }, 
                        child: Text(
                          "Resend Email?",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary
                          ),
                        )
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          backToLogin();
                        }, 
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Colors.black
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