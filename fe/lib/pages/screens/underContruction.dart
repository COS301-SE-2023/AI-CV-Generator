import 'package:flutter/material.dart';

class UnderContruction extends StatefulWidget {
  const UnderContruction({super.key});

  @override
  State<StatefulWidget> createState() => UnderContructionState();
}

class UnderContructionState extends State<UnderContruction> {
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