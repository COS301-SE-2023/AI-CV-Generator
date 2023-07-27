import 'dart:typed_data';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';


 Future<Uint8List?> imagecrop(BuildContext context,Uint8List imgdata) async {
  Uint8List? data;
  final controller = CropController();
  await showDialog(
      context: context, 
      builder: (BuildContext context)  {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Scaffold(
            body: Center(
              child: Crop(
                image: imgdata, 
                controller: controller,
                onCropped: (image) {
                  data = image;
                  Navigator.pop(context);
                },
                initialArea: const Rect.fromLTWH(240, 212, 800, 600),
                withCircleUi: true,
                fixArea: false,
                radius: 20,
              ) 
            ),  
            bottomNavigationBar: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    controller.cropCircle();
                  },
                  child: const Text('Done'),
                ),
              ],
            )
          )
        );
      }
    );
    return data;
}
