import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

showHappyMessage(String message, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 500,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              height: 90,
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 81, 54, 234),
                borderRadius: BorderRadius.all(Radius.circular(4))
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(width: 48,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Yay!",
                          style: TextStyle(color: Colors.white,fontSize: 18),
                        ),
                        Text(
                          message,
                          style: const TextStyle(color: Colors.white,fontSize: 15),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    )
                  )
                ]
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(4)
                ),
                child: Stack(
                  children: [
                    SvgPicture.asset(
                      "assets/images/party-popper-svgrepo-com.svg",
                      height: 32,
                      width: 30,
                      color: Colors.white,
                    )
                  ],
                ),
              )
            ),
            Positioned(
              top: -10,
              left: -10,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/images/circle-filled-circle-radio-filled-round-bullet-svgrepo-com.svg",
                    height: 40,
                    color: const Color.fromARGB(255, 81, 54, 234),
                  ),
                  Positioned(
                    //top: 10,
                    child: TapRegion(
                      onTapInside: (PointerEvent) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      }, 
                      child: SvgPicture.asset(
                        "assets/images/circle-xmark-svgrepo-com.svg",
                        height: 20,
                        color: Colors.white,
                      ),
                    )
                  )
                ],
              ),
            )
          ]
        )
      ),
    );
  }