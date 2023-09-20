import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  
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
        body: const ForgotPasswordWidget()
    );
  }
}

class ForgotPasswordWidget extends StatefulWidget {
  const ForgotPasswordWidget({super.key});
  @override
  State<StatefulWidget> createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPasswordWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  showError(String message) {
    showMessage(message, context);
  }
  showSuccess(String message) {
    showHappyMessage(message, context);
  }
  toLogin() {
    Navigator.pop(context);
  }
  bool wait = false;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    final _formKey = GlobalKey<FormState>();

    if (wait) return const LoadingScreen();
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(1*w),
              child: const Image(image: ResizeImage(AssetImage('assets/images/logo.png'),width:350,height:350),)
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(2*w, 1*h, 2*w, 1*h),
              child: const Text(
                'Forgot Password',
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
                key: const Key('email'),
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Confirm Your Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 3*h),
            CustomizableButton(
              text: 'Send Verification Code', 
              width: 15*w, 
              height: 5*h, 
              onTap: () async {
                if(_formKey.currentState!.validate() == false) {
                  return;
                }
                setState(() {
                  wait = true;
                });
                Code resp = await AuthApi.reset(username: nameController.text, email: emailController.text);
                if (resp == Code.success) {
                  showSuccess("Please check your email for further instructions!");
                  setState(() {
                    wait = false;
                  });
                  toLogin();
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
              fontSize: 0.9*w
            ),
          ]
        )
      )
    );
  }
}