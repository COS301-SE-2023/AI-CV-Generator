import 'package:flutter/material.dart';

class Help extends StatefulWidget {
  const Help({super.key});

  @override
  State<StatefulWidget> createState() => HelpState();
}

class HelpState extends State<Help> {
  void back() {
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
          ), 
          onPressed: () async {
            back();
          },
        ),
        actions: [
          Transform.scale(
            scale: 0.8,
            child: const SizedBox(
              width: 400,
            ),
          ),
          TextButton(
            onPressed: () {
                Navigator.pushNamed(context, '/about');
            },
            child: Text("ABOUT", style: Theme.of(context).appBarTheme.toolbarTextStyle),
          ),
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Under Contruction")
          ],
        ),
      )
    );
  }

}