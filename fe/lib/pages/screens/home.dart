import 'package:ai_cv_generator/api/DownloadService.dart';
import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/dio/client/generationApi.dart';
import 'package:ai_cv_generator/dio/response/GenerationResponses/MockGenerationResponse.dart';
import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateA.dart';
import 'package:ai_cv_generator/pages/template/TemplateB.dart';
import 'package:ai_cv_generator/pages/template/TemplateC.dart';
import 'package:ai_cv_generator/pages/widgets/AILoadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/EmptyCV.dart';
import 'package:ai_cv_generator/pages/widgets/ErrorScreen.dart';
import 'package:ai_cv_generator/pages/widgets/cvHistory.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/pdf_window.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdfx/pdfx.dart';
import '../../models/user/UserModel.dart';
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'dart:async';
import 'package:ai_cv_generator/pages/widgets/shareCV.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  static UserModel? adjustedModel;
  static bool ready = false;

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};
  UserModel? model;
  int co = 0;

  @override
  void initState() {
    userApi.getUser().then((value) {
      model = value;
      setState(() {});
    });
    super.initState();
  }

  Widget add(String filename,) {
    return OutlinedButton(
        onPressed: ()  {
          FileApi.requestFile(filename: filename).then((value) {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: PdfWindow(file: value,)
                );
            });
          });

        },
        child: Text(filename),
    );
  }

  Future<void> generateFile() async {
    if (generatedFile == null) return;
    switch (tem) {
      case Template.templateA:
        generatedFile = await templateAPdf!.transform();
      break;
      case Template.templateB:
        generatedFile = await templateBPdf!.transform();
      break;
      default:
        generatedFile = await templateCPdf!.transform();
      break;
    }
  }

  void updatePastCVs() {
    FileApi.getFiles().then((value) {
      list = [];
      for (var element in value!) {
        list.add(add(element.filename));
      }
        setState(() {
      });
    });
  }

  void switchTemplate(Template t) {
    if (t == Template.templateA) {
      tem = Template.templateA;
      if (ready) {
        //templateAPdf 
        editPage = TemplateA(user: adjustedmodel!, data: cvdata!);
      }    
    } else  if (t == Template.templateB) {
      tem = Template.templateB;
      if (ready) {
        editPage = TemplateB(user: adjustedmodel!, data: cvdata!);
      }
    }
    setState(() {
      
    });
  }

  PlatformFile? uploadFile;
  PlatformFile? generatedFile;
  TextStyle textStyle = const TextStyle(fontSize: 12);
  TextEditingController filenameC = TextEditingController();
  List<Widget> list = [];
  Widget? editPage = const EmptyCVScreen();
  TemplateA? templateAPdf;
  Color tempA = Colors.blue;
  TemplateB? templateBPdf;
  Color tempB = Colors.transparent;
  TemplateC? templateCPdf;
  Color tempC = Colors.transparent;
  Template tem = Template.templateA;
  bool ready = false;
  UserModel? adjustedmodel;
  CVData? cvdata;

  @override
  Widget build(BuildContext context) {
    CVHistory cvHistory = CVHistory(context: context);
    if(model == null) {
      return const LoadingScreen();
    }
    return  Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
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
          const SizedBox(width: 100,),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, '/profile');
                model = await userApi.getUser();
                setState(() {});
              }, 
              child: Row(
                children: [
                  Text(model!.fname,),
                  const SizedBox(width: 4,),
                  const Icon(Icons.account_circle),
                  const SizedBox(width: 16,),
                ],
              )
            ),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 128, vertical: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(
                      color: const Color.fromARGB(0, 0, 0, 0),
                    ),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topCenter,
                        child: Text("TEMPLATES", style: TextStyle(fontSize: 16),),
                      ),
                      SingleChildScrollView(
                        
                        child: Container(
                          height: 499,
                          child: GridView.count(
                            crossAxisCount: 1,
                            children:[
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: tempA,
                                  width: 5
                                )
                              ),
                              padding: const EdgeInsets.fromLTRB(0,5, 0,5),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (tem != Template.templateA) {
                                      tem = Template.templateA;
                                      tempA = Colors.blue;
                                      tempB = tempC= Colors.transparent;
                                      if (ready) {
                                        templateAPdf = TemplateA(user: adjustedmodel!, data: cvdata!);
                                        editPage = templateAPdf;
                                        generatedFile = await templateAPdf!.transform();
                                      }
                                      setState(() {
                                        
                                      });
                                    }
                                  },
                                  child: Image(image: Image.asset("assets/images/TemplateAAsset.jpg").image,height: 250,width: 100,),
                                )
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: tempB,
                                  width: 5
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (tem != Template.templateB) {
                                      tem = Template.templateB;
                                      tempB = Colors.blue;
                                      tempA = tempC = Colors.transparent;
                                      if (ready) {
                                        templateBPdf = TemplateB(user: adjustedmodel!, data: cvdata!);
                                        editPage = templateBPdf;
                                        generatedFile = await templateBPdf!.transform();
                                      }
                                      setState(() {
                                          
                                      });
                                    }
                                  },
                                  child: Image(image: Image.asset("assets/images/TemplateBAsset.png").image,height: 250,width: 100,),
                                )
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: tempC,
                                  width: 5
                                ),
                              ),
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: () async {
                                    if (tem != Template.templateC) {
                                      tem = Template.templateC;
                                      tempC = Colors.blue;
                                      tempB = tempA = Colors.transparent;
                                      if (ready) {
                                        templateCPdf = TemplateC(user: adjustedmodel!, data: cvdata!);
                                        editPage = templateCPdf;
                                        generatedFile = await templateCPdf!.transform();
                                      }
                                      setState(() {
                                          
                                      });
                                    }
                                  },
                                  child: Image(image: Image.asset("assets/images/TemplateCAsset.jpg").image,height: 250,width: 100,),
                                )
                              ),
                            )
                          ],
                          )
                        ),
                      )
                    ],
                  )
                )
              ),
              const SizedBox(width: 24,),
              Expanded(
                flex: 3,
                child:Container(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            child: SizedBox(
                              height: 40,
                              width: 100, 
                              child: ElevatedButton(
                                onPressed: () async {
                                  Home.adjustedModel = model;
                                  await showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        child: ConstrainedBox(
                                          constraints: const BoxConstraints(maxWidth: 800),
                                          child: const PersonalDetailsForm()
                                        )
                                        
                                      );
                                    }
                                  );
                                  if (Home.ready == false) return;
                                  setState(() {
                                    editPage = null;
                                  });
                                  setState(() {
                                    editPage = const AILoadingScreen();
                                  });
                                  MockGenerationResponse? response = await GenerationApi.mockgenerate(userModel: (Home.adjustedModel)!);
                                  if (response?.data.description == null) {
                                    editPage = ErrorScreen(errormsg: "Rate Limit Exceeded!");
                                    setState(() {});
                                    return;
                                  }
                                  switch (tem) {
                                    case Template.templateA:
                                      templateAPdf = TemplateA(user: response!.mockgeneratedUser, data: response!.data);
                                      editPage = templateAPdf;
                                      generatedFile = await templateAPdf!.transform();
                                    break;
                                    case Template.templateB:
                                      templateBPdf = TemplateB(user: response!.mockgeneratedUser, data: response!.data);
                                      editPage = templateBPdf;
                                      generatedFile = await templateBPdf!.transform();
                                    break;
                                    default:
                                      templateCPdf = TemplateC(user: response!.mockgeneratedUser, data: response!.data);
                                      editPage = templateCPdf;
                                      generatedFile = await templateCPdf!.transform();
                                    break;
                                  }
                                  adjustedmodel = response!.mockgeneratedUser;
                                  cvdata = response!.data;
                                  ready = true;
                                  setState(() {});
                                }, 
                                child: Text("SURVEY", style: textStyle),
                              ),
                            )
                          ),
                          const SizedBox(width: 43,),
                          Container(
                            child: SizedBox(
                              height: 40,
                              width: 100, 
                              child: ElevatedButton(
                                onPressed: () async {
                                  uploadFile = await pdfAPI.pick_cvfile();
                                  if(uploadFile != null) {                    
                                    filenameC.text = uploadFile!.name;
                                    await FileApi.uploadFile(file: uploadFile);
                                    updatePastCVs();
                                  }
                                }, 
                                child: Text("UPLOAD", style: textStyle),
                              ),
                            )
                          ),
                          const SizedBox(width: 43,),
                          Container(
                            child: SizedBox(
                              height: 40,
                              width: 100,
                              child: ElevatedButton(
                                onPressed: () async {
                                  await generateFile();
                                  if(uploadFile != null) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return PdfView(
                                          controller: PdfController(document: PdfDocument.openData(uploadFile!.bytes as FutureOr<Uint8List>)),
                                          scrollDirection: Axis.horizontal,
                                          pageSnapping: false,
                                        );
                                      }
                                    );
                                  }
                                },
                                child: Text("PREVIEW", style: textStyle),
                              ),
                            )
                          ),
                          const SizedBox(width: 48,),
                          Expanded(
                            flex: 2,
                            child: Text(
                              filenameC.text,
                              style: textStyle
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12,),
                      if(uploadFile != null || generatedFile != null)
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: SizedBox(
                                height:40,
                                width: 100,
                                child:ElevatedButton(
                                  onPressed: () async {
                                    // MockGenerationResponse? response = await GenerationApi.mockgenerate(userModel: (Home.adjustedModel)!);
                                    // editPage = TemplateA(user: (await userApi.getUser())!);
                                    // setState(() {});
                                  }, 
                                  child: Text("GENERATE", style: textStyle),
                                ),
                              )
                            ),
                            Container(
                              child: SizedBox(
                                height: 40,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await generateFile();
                                    if (generatedFile != null) {
                                      requirementsforshare(context, generatedFile);
                                    }
                                    updatePastCVs();
                                  },
                                  child: Text("SHARE", style: textStyle),
                                ),
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                height: 40,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await generateFile();
                                    if (generatedFile != null) {
                                      DownloadService.download(generatedFile!.bytes!.toList(), downloadName: generatedFile!.name);
                                    }
                                  }, child: Text("DOWNLOAD", style: textStyle),
                                ),
                              ),
                            ),
                            Container(
                              child: SizedBox(
                                height: 40,
                                width: 100,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    await generateFile();
                                    if(generatedFile != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return PdfView(
                                            controller: PdfController(document: PdfDocument.openData(generatedFile!.bytes as FutureOr<Uint8List>)),
                                            scrollDirection: Axis.horizontal,
                                            pageSnapping: false,
                                          );
                                        }
                                      );  
                                    }
                                  }, child: Text("EXPAND", style: textStyle)
                                )
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 4,),
                      Expanded(child:
                        Container(
                          height: 400,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: const Color.fromARGB(0, 0, 0, 0),
                            ),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: editPage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 24,),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    children: [
                      const Expanded(
                        flex: 2,
                        child: PastCVs(),
                      ),
                      Expanded(
                        flex: 10,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            border: Border.all(
                              color: const Color.fromARGB(0, 0, 0, 0),
                            ),
                            color: Theme.of(context).colorScheme.surface,
                          ),
                          child: SizedBox.expand(
                            child: Center(child: CVHistory(context: context,list: list,),)
                          )
                        ),
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

class PastCVs extends StatefulWidget {
  const PastCVs({super.key});

  @override
  PastCVsState createState() => PastCVsState();
}

enum Template {templateA,templateB,templateC}

class PastCVsState extends State<PastCVs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: const Align(
        alignment: Alignment.bottomCenter,
        child: Text("PAST CVs", style: TextStyle(fontSize: 16),),
      ),
    );
  }
}