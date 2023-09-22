import 'package:ai_cv_generator/pages/widgets/shareCV.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ShareButton extends StatelessWidget {
  const ShareButton({super.key, this.file});
  final PlatformFile? file;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return InkWell(
      onTap: () {
        requirementsforshare(context, file);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              height: h*5,
              width: w*10,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFEA6D79),
                      Color(0xFFFDA187),
                    ]),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(""),
                  Text(
                    "Share",
                    style: TextStyle(
                        fontSize: 0.8*w,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  Container(
                    padding: EdgeInsets.all(0.3*w),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: Colors.white),
                    child:  Icon(
                      Icons.upload,
                      size: 1.2*w,
                      color: const Color(0xFFEA6D79),
                    )
                  )
                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}