import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verification extends StatefulWidget {
  const Verification({super.key});
  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  TextEditingController codeC = TextEditingController();
  bool isLoading = false;
  bool isResendLoading = false;
  bool verified = false;
  bool error = false;

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
      body: Center(
        child: SizedBox(
          // alignment: Alignment.centerLeft,
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              verified == false ?
              error == true ?
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Error", style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.primary),),
                      const SizedBox(width: 16,),
                      Icon(Icons.error, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text("Incorrect code.", style: TextStyle(fontSize: 16)),
                ],
              ) :
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Check your inbox", style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.primary),),
                      const SizedBox(width: 16,),
                      Icon(Icons.email, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                  const SizedBox(height: 16,),
                  const Text("We sent a code to your email.", style: TextStyle(fontSize: 16)),
                ],
              ) : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Verified", style: TextStyle(fontSize: 28, color: Theme.of(context).colorScheme.primary),),
                      const SizedBox(width: 16,),
                      Icon(Icons.check, color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
              const SizedBox(height: 72,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints.tight(const Size(300,70)),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      key: const Key("Code input"),
                      controller: codeC,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        labelText: 'Code',
                        icon: Icon(Icons.security),
                      ),
                      validator: (value) {
                        if(value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    )
                  ),
                  const SizedBox(width: 16,),
                  SizedBox(
                    height: 40,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (codeC.text.isEmpty) {
                              return;
                            }
                            isLoading = true;
                            Timer.periodic(const Duration(seconds: 3), (timer) {
                              setState(() {
                                isLoading = false;
                                //if success
                                // verified = true;
                                //else error
                                error = true;
                                Timer.periodic(const Duration(seconds: 3), (timer) {
                                  setState(() {
                                    error = false;
                                  });
                                });
                              });
                            });
                          });
                        },
                        child: isLoading ? const CircularProgressIndicator(color: Colors.grey, strokeWidth: 1,) : const Text("Verify") 
                      ),
                ),
                ],
              ),
              const SizedBox(height: 32,),
              TextButton(onPressed: () {
                if(isResendLoading == false)
                {
                  Timer.periodic(const Duration(seconds: 3), (timer) {
                    setState(() {
                      isResendLoading = false;
                    });
                  });
                  setState(() {
                    isResendLoading = true;
                  });
                }
              },
              child: isResendLoading ? const CircularProgressIndicator(color: Colors.grey, strokeWidth: 1,) : const Text("Resend Mail?", style: TextStyle(fontSize: 16,)),)
            ],
          ),
        ),
      )
    );
  }

}