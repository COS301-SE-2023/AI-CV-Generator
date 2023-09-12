import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Verification extends StatelessWidget
{
  TextEditingController codeC = new TextEditingController();
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
        child: Container(
          // alignment: Alignment.centerLeft,
          width: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
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
                  SizedBox(height: 16,),
                  Text("We sent a code to your email.", style: TextStyle(fontSize: 16)),
                ],
              ),
              SizedBox(height: 72,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: BoxConstraints.tight(Size(300,70)),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      key: Key("Code input"),
                      controller: codeC,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(5.0),
                        labelText: 'Code',
                        icon: Icon(Icons.security),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    )
                  ),
                  SizedBox(width: 16,),
                  Container(
                    height: 40,
                      child: ElevatedButton(
                        onPressed: () {},
                        child: Text("Verify")
                      ),
                ),
                ],
              ),
              SizedBox(height: 32,),
              TextButton(onPressed: () {
                
              },
              child: Text("Try again?", style: TextStyle(fontSize: 16,)),)
            ],
          ),
        ),
      )
    );
  }

}