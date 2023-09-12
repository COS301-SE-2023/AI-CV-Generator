import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({Key? key,this.code }) : super(key: key);
  final String? code;
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
        body: ChangePasswordWidget(code: code,)
    );
  }
}

class ChangePasswordWidget extends StatefulWidget {
  const ChangePasswordWidget({super.key, this.code});
  final String? code;
  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePasswordWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  showError(String message) {
    showMessage(message, context);
  }
  toResetSuccess() {
    Navigator.popAndPushNamed(context, "/resetSuccess");
  }
  bool wait = true;
  bool failed = true;
  String message = "Unfortunatley this link is no longer valid";

  @override
  void initState() {
    AuthApi.validateReset(token: widget.code!).then((value) {
      if (value == Code.success) {
        failed = false;
      } else if (value == Code.requestFailed) {
        message = "Something went wrong!!";
        failed = true;
      }
      wait = false;
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wait) return const LoadingScreen();
    if (failed) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Row(
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
                      message,
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ]
            )
          ]
        )
      );
    }
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
                  'Change Password',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
              padding: const EdgeInsets.fromLTRB(500, 10, 500, 10),
              child: TextField(
                key: const Key('name'),
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
                key: const Key('email'),
                obscureText: true,
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm your Email',
                ),
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(600, 0, 600, 0),
                child: ElevatedButton(
                  key: const Key('ChangePassword'),
                  child: const Text('Send Verification Code'),
                  onPressed: () async {
                    setState(() {
                      wait = true;
                    });
                    Code resp = await AuthApi.reset(username: nameController.text, email: emailController.text);
                    if (resp == Code.success) {
                      
                    } else if (resp == Code.failed) {
                      showError("Invalid Credentials!!");
                      setState(() {
                        wait = false;
                      });
                    } else if (resp == Code.requestFailed) {
                      showError("Something went wrong!!");
                      setState(() {
                        wait = false;
                      });
                    }
                  },
                )
            ),
        ]
      )
    );
  }
}