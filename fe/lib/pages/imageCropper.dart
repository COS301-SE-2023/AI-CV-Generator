import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';


 Future<Uint8List> imagecrop(BuildContext context,Uint8List imgdata) async {

 final controller = CropController();
 await showDialog(
    context: context, 
    builder: (BuildContext context)  {
      return Dialog(
        child: Scaffold(
          body: Center(
            child: Crop(
              image: imgdata, 
              controller: controller,
              onCropped: (image) {
                imgdata = image;
                Navigator.pop(context);
              },
              initialArea: Rect.fromLTWH(240, 212, 800, 600),
              withCircleUi: true,
              fixArea: false,
              baseColor: Colors.blue.shade900,
              maskColor: Colors.white.withAlpha(100),
              radius: 20,
            ) 
          ),  
          bottomNavigationBar: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.crop();
                }, 
                child: const Text("Done")
              )
            ],
          ),
        )
      );
    }
  );
  return imgdata;
}
