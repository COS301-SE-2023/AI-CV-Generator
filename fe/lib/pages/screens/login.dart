import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/screens/emailConfirmation.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:flutter/material.dart';
 
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: MyStatefulWidget(),
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

  bool wait = false;

  showError(String message) {
    showMessage(message, context);
  }

  home() {
    Navigator.pushNamed(context, "/home");
  }

  forgotPassword() {
    Navigator.pushNamed(context, "/forgot");
  }

  confirm() {
    Navigator.popAndPushNamed(
      context, '/confirm',
      arguments: EmailConfirmationArguments(
        username: nameController.text,
        password: passwordController.text,
      )
    );
  }
 
  @override
  Widget build(BuildContext context) {
    if (wait) {
      return const LoadingScreen();
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
                  'Log in',
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
                key: const Key('password'),
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                forgotPassword();
              },
              child: const Text('Forgot Password',),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(600, 0, 600, 0),
                child: ElevatedButton(
                  key: const Key('login'),
                  child: const Text('Login'),
                  onPressed: () async {
                    setState(() {
                      wait = true;
                    });
                    Code resp = await AuthApi.login(username: nameController.text,password: passwordController.text);
                    if (resp == Code.success) {
                      home();
                    } else if (resp == Code.failed) {
                      showError("Invalid Login!");
                      setState(() {
                        wait = false;
                      });
                    } else if (resp == Code.requestFailed) {
                      showError("Something went wrong!!");
                      setState(() {
                        
                      });
                    } else if (resp == Code.notEnabled) {
                      await AuthApi.resendEmail(username: nameController.text, password: passwordController.text);
                      confirm();
                    }
                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('Do not have an Account yet?'),
                TextButton(
                  key: const Key('create_account'),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register');
                  },
                )
              ],
            ),
          ],
        )
      );
  }
}