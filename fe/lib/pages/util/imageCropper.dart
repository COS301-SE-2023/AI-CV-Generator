import 'dart:typed_data';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ImageCrop extends StatefulWidget {
  ImageCrop({super.key, required this.data});
  Uint8List? data;
  
  @override
  State<StatefulWidget> createState() => ImageCropState();

}

class ImageCropState extends State<ImageCrop> {

  late Uint8List data;

  stop() {
    Navigator.pop(context);
  }

  cancel() {
    widget.data = null;
    stop();
  }

  save() {
    widget.data = data;
    stop();
  }

  @override
  void initState() {
    data = widget.data!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    final CropController controller = CropController();
    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.grey.shade300
          ),
          color: Colors.grey.shade100
        ),
        width: 50*w,
        height: 85*h,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                ), 
                onPressed: () async { 
                  cancel();
                },
              ),
            ),
            body: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20,),
                  Container(
                    color: Colors.white,
                    width: 500,
                    height: 500,
                    child: Crop(
                      image: data, 
                      onCropped: (image) {
                        data = image;
                        save();
                      },
                      controller: controller,
                      initialArea: const Rect.fromLTWH(240, 212, 800, 600),
                    withCircleUi: true,
                    fixArea: false,
                    radius: 20,
                    ),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CustomizableButton(
                        text: "Save", 
                        width: 100, 
                        height: 30, 
                        onTap: () {
                          controller.cropCircle();
                        }, 
                        fontSize: 12
                      ),
                      const SizedBox(width: 20,),
                      CustomizableButton(
                        text: "Cancel", 
                        width: 100, 
                        height: 30, 
                        onTap: () {
                          cancel();
                        }, 
                        fontSize: 12
                      )
                    ],
                  ),
                  const SizedBox(height: 20,)
                ],
              )
            )
          )
        )
      )
    );
  }

}


 Future<Uint8List?> imagecrop(BuildContext context,Uint8List imgdata) async {
  ImageCrop crop = ImageCrop(data: imgdata);
  await showDialog(
      context: context, 
      barrierColor: Colors.transparent,
      builder: (BuildContext context)  {
        return SizedBox(
          height: 800,
          width: 80,
          child: crop,
        );
      }
    );
    return crop.data;
}
