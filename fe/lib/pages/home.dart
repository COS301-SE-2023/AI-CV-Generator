import 'package:ai_cv_generator/api/DownloadService.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/pages/navdrawer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import '../models/user/UserModel.dart';
import 'profile.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'dart:async';
import 'dart:typed_data';
import 'package:ai_cv_generator/pages/shareCV.dart';

class Home extends StatefulWidget {
  const Home({super.key});


  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  TextEditingController searchC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
        actions: [

          Transform.scale(
            scale: 0.8,
            child: SizedBox(
              width: 400,
              child: SearchBar(
                controller: searchC,
                leading: IconButton(
                  icon: const Icon(
                    color: Colors.black,
                    Icons.search,
                    ),
                  onPressed: () => {
                    print(searchC.text)
                  },
                ),
                onChanged: (value)=>{
                  print(value)
                } ,
              ),
            ),
          ),

          IconButton(
            onPressed: () async {
              UserModel? mode = await userApi.getUser();
              if (mode != null) {
                Navigator.of(context).push(
                MaterialPageRoute(builder: (c)=>  Profile(model: mode,))
              );
              }
            }, 
            icon: const Icon(Icons.account_circle)
            ),
        
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 128, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child:Templates()
              ),
              SizedBox(width: 24,),
              Expanded(
                flex: 3,
                child:Generate(),
              ),
              SizedBox(width: 24,),

              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: PastCVs(),
                      ),
                      Expanded(
                        flex: 10,
                        child: Text(""),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Templates extends StatefulWidget {
  @override
  TemplatesState createState() => TemplatesState();
}

class TemplatesState extends State<Templates> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      color: Colors.grey,
      child: Align(
        alignment: Alignment.topCenter,
        child: Text("Templates", style: TextStyle(fontSize: 16),),
      ),
    );
  }
}

class PastCVs extends StatefulWidget {
  @override
  PastCVsState createState() => PastCVsState();
}

class PastCVsState extends State<PastCVs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24.0),
      color: Colors.grey,
      child: Align(
        alignment: Alignment.topCenter,
        child: Text("PASTCVs", style: TextStyle(fontSize: 16),),
      ),
    );
  }
}

class Generate extends StatefulWidget {
  @override
  GenerateState createState() => GenerateState();
}

class GenerateState extends State<Generate> {
  PlatformFile? uploadFile;
  PlatformFile? generatedFile;
  TextStyle textStyle = TextStyle(color: Colors.black, fontSize: 12);
  TextEditingController filenameC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.pink,
      padding: EdgeInsets.symmetric(horizontal: 0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(flex: 1, child: Container(color: Colors.grey, height:40, child: TextButton(
                onPressed: () async {
                  uploadFile = await pdfAPI.pick_cvfile();
                  if(uploadFile != null) {                    
                    filenameC.text = uploadFile!.name;
                    FileApi.uploadFile(file: uploadFile);
                    setState(() {
                    });
                  }

                }, child: Text("UPLOAD", style: textStyle),),)),
              SizedBox(width: 8,),
              Expanded(flex: 1, child: Container(color: Colors.grey, height:40, child:TextButton(
                onPressed: () {
                  if(uploadFile != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PdfView(
                          controller: PdfController(document: PdfDocument.openData(uploadFile!.bytes as FutureOr<Uint8List>)),
                          scrollDirection: Axis.horizontal,
                          pageSnapping: false,
                        );
                    });
                  }
                }, child: Text("PREVIEW", style: textStyle),),)),
              SizedBox(width: 48,),
              Expanded(flex: 2, child: Text(filenameC.text, style: textStyle ),),
            ],
          ),
          SizedBox(height: 12,),
          if(uploadFile != null)
          Container(
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container(height:40, child:TextButton(onPressed: (){}, child: Text("GENERATE", style: textStyle),),)),
                Expanded(child: Container(height: 40, child: TextButton(
                  onPressed: () {
                    if (generatedFile != null) {
                      RequirementsForShare(context, generatedFile);
                    }
                  }, child: Text("SHARE", style: textStyle),),),),
                Expanded(child: Container(height: 40, child: TextButton(
                  onPressed: () {
                    if (generatedFile != null) {
                      DownloadService.download(generatedFile!.bytes!.toList(), downloadName: generatedFile!.name);
                    }
                  }, child: Text("DOWNLOAD", style: textStyle),),),),
                Expanded(child: Container(height: 40, child: TextButton(onPressed: () {
                  if(generatedFile != null) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return PdfView(
                          controller: PdfController(document: PdfDocument.openData(generatedFile!.bytes as FutureOr<Uint8List>)),
                          scrollDirection: Axis.horizontal,
                          pageSnapping: false,
                        );
                    });  
                  }
                }, child: Text("EXPAND", style: textStyle),),),),
              ],
            ),
          ),
          SizedBox(height: 4,),
          Expanded(child: Container(
            color: Colors.grey.withOpacity(0.9),
          ),),
        ],
      ),
    );
  }
}

// class _HomeState extends State<Home> {
//   Map data = {};
//   TextEditingController searchC = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return  Scaffold(
//       drawer: const NavDrawer(),
//       appBar: AppBar(
//           backgroundColor: Colors.lightBlue,
//         actions: [

//           Transform.scale(
//             scale: 0.8,
//             child: SizedBox(
//               width: 400,
//               child: SearchBar(
//                 controller: searchC,
//                 leading: IconButton(
//                   icon: const Icon(
//                     color: Colors.black,
//                     Icons.search,
//                     ),
//                   onPressed: () => {
//                     print(searchC.text)
//                   },
//                 ),
//                 onChanged: (value)=>{
//                   print(value)
//                 } ,
//               ),
//             ),
//           ),

//           IconButton(
//             onPressed: () async {
//               UserModel? mode = await userApi.getUser();
//               if (mode != null) {
//                 Navigator.of(context).push(
//                 MaterialPageRoute(builder: (c)=>  Profile(model: mode,))
//               );
//               }
//             }, 
//             icon: const Icon(Icons.account_circle)
//             ),
        
//         ],
//       ),
//       body: const Center(
//         child: Row(
//           children: [
//             Expanded(child: createPage()),
//             Expanded(child: generatedCV())
//           ],
//         ),
//       ),
//     );
//   }
// }