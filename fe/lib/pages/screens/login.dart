import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/screens/emailConfirmation.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:flutter/material.dart';
 
class LoginTest extends StatefulWidget {
  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  @override
  Widget build(BuildContext context) {
    return Login(); // Return the actual Login widget here
  }
}


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
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EmailConfirmation(username: nameController.text, password: passwordController.text,))
    );
  }
 
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    if (wait) {
      return const LoadingScreen();
    }
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(1*w),
                  child: const Image(image: ResizeImage(AssetImage('assets/images/logo.png'),width:350,height:350),fit: BoxFit.contain,)
                  ),
              Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(2*w, 1*h, 2*w, 1*h),
                  child: const Text(
                    'Log in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(33*w, 1*h, 33*w, 1*h),
                child: TextFormField(
                  key: const Key('name'),
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(33*w, 1*h, 33*w, 1*h),
                child: TextFormField(
                  key: const Key('password'),
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  forgotPassword();
                },
                child: const Text(
                  'Forgot your password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
                
              ),
              const SizedBox(
                height: 16,
              ),
              CustomizableButton(
                text: 'Login', 
                width: w*10, 
                height: h*5, 
                onTap: () async {
                  if(_formKey.currentState!.validate() == false) {
                    return;
                  }
                  setState(() {
                    wait = true;
                  });
                  Code resp = await AuthApi.login(username: nameController.text,password: passwordController.text);
                  if (resp == Code.success) {
                    setState(() {
                      wait = false;
                    });
                    home();
                  } else if (resp == Code.failed) {
                    showError("Invalid Login!");
                    setState(() {
                      wait = false;
                    });
                  } else if (resp == Code.requestFailed) {
                    showError("Something went wrong!!");
                    setState(() {
                      wait = false;
                    });
                  } else if (resp == Code.notEnabled) {
                    await AuthApi.resendEmail(username: nameController.text, password: passwordController.text);
                    setState(() {
                      wait = false;
                    });
                    confirm();
                  }
                }, 
                fontSize: 0.9*w
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Don\'t have an account yet?'),
                  TextButton(
                    key: const Key('create_account'),
                    child: const Text(
                      'Register here',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/register');
                    },
                  )
                ],
              ),
            ],
          )
        )
      )
    );
  }
}