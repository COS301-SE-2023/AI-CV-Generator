import 'package:flutter/material.dart';

class EmailConfirmationArguments{
  String email;
  String username;
  EmailConfirmationArguments({
    required this.email,
    required this.username
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
 
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as EmailConfirmationArguments;
    return Scaffold(
          body: Row(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
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
                  "An email has been sent to ${args.email}, please check your email to verify your account to continue",
                ),
                ElevatedButton(
                  onPressed: () {
                    
                  }, 
                  child: const Text("Resend Email")
                )
              ],
            ),
          ],
      ));
  }
}