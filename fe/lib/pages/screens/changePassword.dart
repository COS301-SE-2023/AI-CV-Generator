import 'package:ai_cv_generator/dio/client/AuthApi.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/pages/util/errorMessage.dart';
import 'package:ai_cv_generator/pages/util/successMessage.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/generalTextButton.dart';
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
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordRetypeController = TextEditingController();
  
  Color? p2textColor;

  showError(String message) {
    showMessage(message, context);
  }
  showSuccess(String message) {
    showHappyMessage(message, context);
  }
  toLogin() {
    Navigator.popAndPushNamed(context, "/");
  }
  toResetSuccess() {
    Navigator.popAndPushNamed(context, "/resetSuccess");
  }
  bool wait = true;

  @override
  void initState() {
    AuthApi.validateReset(token: widget.code!).then((value) {
      if (value == Code.success) {
        wait = false;
        setState(() {
          
        });
        return;
      } else if (value == Code.requestFailed) {
        showError('Something went wrong!');
      } else if (value == Code.failed) {
        showError('Sorry this link is no longer valid!');
      }
      toLogin();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wait) return const LoadingScreen();
    final _formKey = GlobalKey<FormState>();
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
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
                    'Change Password',
                    style: TextStyle(fontSize: 20),
                  )),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(33*w, 0*h, 33*w, 0*h),
                child: TextFormField(
                  maxLength: 50,
                  key: const Key('password'),
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    counterText: "",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF000000),
                        width: 1.0
                      )
                    ),
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
              Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(33*w, 0*h, 33*w, 0*h),
                child: TextFormField(
                  maxLength: 50,
                  key: const Key('passwordretype'),
                  obscureText: true,
                  controller: passwordRetypeController,
                  decoration: InputDecoration(
                    counterText: "",
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 10,),
              CustomizableButton(
                text: 'Confirm', 
                width: w*10, 
                height: h*5, 
                onTap: () async {
                  if(_formKey.currentState!.validate() == false) {
                    return;
                  }
                  if (passwordController.text != passwordRetypeController.text) {
                    showError("Password does not match");
                    return;
                  }
                  setState(() {
                    wait = true;
                  });
                  Code resp = await AuthApi.changePassword(newPassword: passwordController.text, token: widget.code!);
                  if (resp == Code.success) {
                    showSuccess("Password has been successfully changed");
                    toLogin();
                    
                  } else if (resp == Code.failed) {
                    showError("Something went wrong!!");
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
            ],
          )
        )
      )
    );
  }
}

