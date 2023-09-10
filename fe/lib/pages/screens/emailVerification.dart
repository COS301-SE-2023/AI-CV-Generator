import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:flutter/material.dart';

class EmailVerification extends StatefulWidget {
  
  const EmailVerification({super.key, this.code});
  final String? code;
  @override
  State<StatefulWidget> createState() => EmailVerificationState();
}

class EmailVerificationState extends State<EmailVerification> {
  bool error = false;
  TextEditingController errorMessage = TextEditingController(text: "Error");
  Stream<String> sampleListener(TextEditingController controller) async* { // <- here
    while (true) {
      await Future.delayed(const Duration(milliseconds: 10));
      yield controller.value.text;
    }
  }

  toLogin() {
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  Widget build(Object context) {
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
                      child: FloatingActionButton(
                        onPressed: () async {
                          Code response = await AuthApi.verify(code: widget.code!);
                          if (response == Code.success) {
                            toLogin();
                          } else if (response == Code.expired) {
                            errorMessage.text = "Unfortunatley this token is expired please register again";
                            error = true;
                            setState(() {
                              
                            });
                          } else {
                            errorMessage.text = "Verification failed something went wrong!";
                            error = true;
                            setState(() {
                              
                            });
                          }
                        }, 
                        child: const Text(
                          "Verify",
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